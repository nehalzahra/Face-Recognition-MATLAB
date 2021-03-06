function detected = myPrediction(testImage,sceneFeatures,nFaces)

% Companion file for Face Recognition demo


fcnHandle = @(x) detectFASTFeatures(x,...
	'MinQuality',0.025,...
	'MinContrast',0.025); %#ok
extractorMethod = 'SURF'; %#ok
metric = 'SAD'; %#ok

boxPoints = fcnHandle(testImage);
[boxFeatures, boxPoints] = extractFeatures(testImage, boxPoints,...
	'Method',extractorMethod,...
	'BlockSize',3,...
	'SURFSize',64);
matchMetric = zeros(size(boxFeatures,1),nFaces);
for ii = 1:nFaces
	[~,matchMetric(:,ii)] = matchFeatures(boxFeatures,sceneFeatures{ii},...
		'MaxRatio',1,...
		'MatchThreshold',100,...
		'Metric',metric);
end
	[~,detected] = min(mean(matchMetric));
