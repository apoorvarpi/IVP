function MotionBasedMultiObjectTracking()
obj = setupSystemObjects();

tracks = initializeTracks();

nextId = 1; 
k = 0;
mask2 = readFrame();
while ~isDone(obj.reader)
    frame = readFrame();
    [centroids, bboxes, mask] = detectObjects(frame);
    predictNewLocationsOfTracks();
    [assignments, unassignedTracks, unassignedDetections] = ...
        detectionToTrackAssignment();
    updateAssignedTracks();
    updateUnassignedTracks();
    deleteLostTracks();
    createNewTracks();

    displayTrackingResults();
   % pause(0.1);
end
    function obj = setupSystemObjects()
        obj.reader = vision.VideoFileReader('sample.avi');

        obj.maskPlayer = vision.VideoPlayer('Position', [740, 400, 700, 400]);
        obj.videoPlayer = vision.VideoPlayer('Position', [20, 400, 700, 400]);
        obj.finalPlayer = vision.VideoPlayer('Position', [740, 200, 700, 400]);


        obj.detector = vision.ForegroundDetector('NumGaussians', 3, ...
            'NumTrainingFrames', 40, 'MinimumBackgroundRatio', 0.7);

        obj.blobAnalyser = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
            'AreaOutputPort', true, 'CentroidOutputPort', true, ...
            'MinimumBlobArea', 400);
    end

    function tracks = initializeTracks()
        tracks = struct(...
            'id', {}, ...
            'bbox', {}, ...
            'kalmanFilter', {}, ...
            'age', {}, ...
            'totalVisibleCount', {}, ...
            'consecutiveInvisibleCount', {});
    end

    function frame = readFrame()
        frame = obj.reader.step();
    end

    function [centroids, bboxes, mask] = detectObjects(frame)
        mask = obj.detector.step(frame);
        mask = imopen(mask, strel('rectangle', [3,3]));
        mask = imclose(mask, strel('rectangle', [15, 15]));
        mask = imfill(mask, 'holes');
        [~, centroids, bboxes] = obj.blobAnalyser.step(mask);
    end

    function predictNewLocationsOfTracks()
        for i = 1:length(tracks)
            bbox = tracks(i).bbox;

            predictedCentroid = predict(tracks(i).kalmanFilter);

            predictedCentroid = int32(predictedCentroid) - bbox(3:4) / 2;
            tracks(i).bbox = [predictedCentroid, bbox(3:4)];
        end
    end

    function [assignments, unassignedTracks, unassignedDetections] = ...
            detectionToTrackAssignment()

        nTracks = length(tracks);
        nDetections = size(centroids, 1);

        cost = zeros(nTracks, nDetections);
        for i = 1:nTracks
            cost(i, :) = distance(tracks(i).kalmanFilter, centroids);
        end

        costOfNonAssignment = 20;
        [assignments, unassignedTracks, unassignedDetections] = ...
            assignDetectionsToTracks(cost, costOfNonAssignment);
    end

    function updateAssignedTracks()
        numAssignedTracks = size(assignments, 1);
        for i = 1:numAssignedTracks
            trackIdx = assignments(i, 1);
            detectionIdx = assignments(i, 2);
            centroid = centroids(detectionIdx, :);
            bbox = bboxes(detectionIdx, :);

            correct(tracks(trackIdx).kalmanFilter, centroid);

            tracks(trackIdx).bbox = bbox;

            tracks(trackIdx).age = tracks(trackIdx).age + 1;

            tracks(trackIdx).totalVisibleCount = ...
                tracks(trackIdx).totalVisibleCount + 1;
            tracks(trackIdx).consecutiveInvisibleCount = 0;
        end
    end

    function updateUnassignedTracks()
        for i = 1:length(unassignedTracks)
            ind = unassignedTracks(i);
            tracks(ind).age = tracks(ind).age + 1;
            tracks(ind).consecutiveInvisibleCount = ...
                tracks(ind).consecutiveInvisibleCount + 1;
        end
    end

    function deleteLostTracks()
        if isempty(tracks)
            return;
        end

        invisibleForTooLong = 20;
        ageThreshold = 8;

        ages = [tracks(:).age];
        totalVisibleCounts = [tracks(:).totalVisibleCount];
        visibility = totalVisibleCounts ./ ages;

        lostInds = (ages < ageThreshold & visibility < 0.6) | ...
            [tracks(:).consecutiveInvisibleCount] >= invisibleForTooLong;

        tracks = tracks(~lostInds);
    end

    function createNewTracks()
        centroids = centroids(unassignedDetections, :);
        bboxes = bboxes(unassignedDetections, :);

        for i = 1:size(centroids, 1)

            centroid = centroids(i,:);
            bbox = bboxes(i, :);

            kalmanFilter = configureKalmanFilter('ConstantVelocity', ...
                centroid, [200, 50], [100, 25], 100);
            newTrack = struct(...
                'id', nextId, ...
                'bbox', bbox, ...
                'kalmanFilter', kalmanFilter, ...
                'age', 1, ...
                'totalVisibleCount', 1, ...
                'consecutiveInvisibleCount', 0);

            tracks(end + 1) = newTrack;

            nextId = nextId + 1;
        end
    end

    function displayTrackingResults()
        frame = im2uint8(frame);
        mask = uint8(repmat(mask, [1, 1, 3])) .* 255;

        minVisibleCount = 8;
        if ~isempty(tracks)
            
            reliableTrackInds = ...
                [tracks(:).totalVisibleCount] > minVisibleCount;
            reliableTracks = tracks(reliableTrackInds);

            if ~isempty(reliableTracks)
                bboxes = cat(1, reliableTracks.bbox);
                %disp(bboxes);
                ids = int32([reliableTracks(:).id]);
                %x = 1;
                %id1 = [];
                %for i = 1:length(ids)
                %   if ids(i)~=3
                %        id1(x) = ids(i);
                %        x = x+1;
                %    else
                %        bboxes=[0 0 0 0];
                %    end
                %end
               % ids = id1;
               % disp(id1);
                labels = cellstr(int2str(ids'));
                %disp(labels);
                predictedTrackInds = ...
                    [reliableTracks(:).consecutiveInvisibleCount] > 0;
                isPredicted = cell(size(labels));
                isPredicted(predictedTrackInds) = {' predicted'};
                labels = strcat(labels, isPredicted);
                frame = insertObjectAnnotation(frame, 'rectangle', ...
                    bboxes, labels);

                mask = insertObjectAnnotation(mask, 'rectangle', ...
                    bboxes, labels);
            end
        end

        obj.maskPlayer.step(mask);
        obj.videoPlayer.step(frame);
        mask = im2uint8(mask);
        frame = im2uint8(frame);
        mask1 = mask;
        mask2 = im2uint8(mask2);
        [r,c]=size(mask);
        for i = 1:r
            for j = 1:c
                if mask(i,j) == 0
                    mask1(i,j) = frame(i,j);
                else
                    mask1(i,j) = 255;
                end
            end
        end
        if(k==10)
            mask2 = mask1;
        end
        k=k+1;
        if k>10
            for i = 1:r
                for j = 1:c
                    if mask2(i,j) == 255 && mask1(i,j)~=255
                        mask2(i,j) = mask1(i,j);
                    end
                end
            end
        end
        obj.finalPlayer.step(mask2);
        imwrite(mask2, './Background.jpg');
    end
end
