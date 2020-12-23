function sceneFeatures = trainStackedFaceDetector(imgSet)

%% FACE RECOGNITION BY AGGREGATED FEATURES

% Select directory of images, and show metadata for single image
nFaces = numel(imgSet);
% Try to use all images. For simplicity, keep number per set the same (this
% is not strictly necessary)
trainingPhotosPerPerson = max(5,min([imgSet.Count]));
testSet = select(imgSet,1:trainingPhotosPerPerson);
allIms = [testSet.ImageLocation];

adjustHistograms = false; %Low-cost way to improve performance
fcnHandle = @(x) detectFASTFeatures(x,...
	'MinQuality',0.025,...
	'MinContrast',0.025); %#ok
extractorMethod = 'SURF';%#ok
metric = 'SAD'; %#ok

% Rather than match to individual faces or to "person-averaged faces,"
% create "montages" of each training set. Features are "aggregated" in that
% matches are evaluated to whole training sets, rather than to subsets
% thereof.

inds = reshape(1:numel(allIms),[],nFaces);
scenePoints = cell(nFaces,1);
sceneFeatures = cell(nFaces,1);
targetSize = 100;
thumbSize = [targetSize,targetSize];
for ii = 1:nFaces
	% Create montages of each training set of face images:
	trainingImage = createMontage(allIms(inds(:,ii)),...
		'montageSize',[size(inds,1),1],...
		'thumbSize',thumbSize);
	if adjustHistograms
		trainingImage = histeq(trainingImage);%#ok
	end
	scenePoints{ii} = fcnHandle(trainingImage);
	[sceneFeatures{ii}, scenePoints{ii}] = extractFeatures(trainingImage, scenePoints{ii},...
		'Method',extractorMethod);
end