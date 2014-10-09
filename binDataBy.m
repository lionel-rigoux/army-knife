function [ binDataMat ] = binDataBy( dataMat, sizeBin, binDim, fun )
% This function bins a matrix along the dim dimension by bin of sizeBin elements

sizeMat=size(dataMat);

if nargin < 4
    fun = @mean;
end

if nargin < 3
    binDim = find (sizeMat > 1, 1, 'first');
    assert(~isempty(binDim), 'dataMat is a singleton')
end

byVar = ind2sub_alldim(sizeMat, 1:numel(dataMat));
byVar{binDim} = ceil(byVar{binDim}/sizeBin);

for iDim = 1:length(byVar)
    byVar{iDim}=reshape(byVar{iDim}, sizeMat);
end
binDataMat = tapply(dataMat, byVar, fun)
end

