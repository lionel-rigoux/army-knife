function [ binDataMat ] = binDataUnequalBy( dataMat, binNumber, binDim, fun )
% This function bins a matrix along the dim dimension in nBin
% Warning: this could lead to bins of different size, arbitrary splitted

sizeMat=size(dataMat);

if nargin < 4
    fun = @mean;
end

if nargin < 3
    binDim = find (sizeMat > 1, 1, 'first');
    assert(~isempty(binDim), 'dataMat is a singleton')
end

byVar = ind2sub_alldim(sizeMat, 1:numel(dataMat));

% if rem(length(byVar{binDim}),sizeBin)~=0;
%     warning('The number of elements is not a multiple of sizeBin!')
% end

%byVar{binDim} = ceil(byVar{binDim}/sizeBin);
[~, ~, byVar{binDim}]=histcounts(byVar{binDim}, binNumber);

for iDim = 1:length(byVar)
    byVar{iDim}=reshape(byVar{iDim}, sizeMat);
end
binDataMat = tapply(dataMat, byVar, fun);
end

