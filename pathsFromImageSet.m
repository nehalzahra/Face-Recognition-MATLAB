function [paths,allIms,allPaths] = pathsFromImageSet(imgSet)


if isa(imgSet,'imageSet')
	allIms = [imgSet.ImageLocation]';
	allPaths = [];
elseif isa(imgSet,'matlab.io.datastore.ImageDatastore')
	allIms = imgSet.Files;
end
if isempty(allIms)
	paths = [];
else
	fcn = @(x) fileparts(x);
	allPaths = cellfun(fcn,allIms,'UniformOutput',false);
	paths = unique(allPaths,'stable');
end