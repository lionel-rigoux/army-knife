function [structIsChanged] = changeLabel(structToChange, fieldNameToChange, newValue)

% Replace the values of structToChange.(fieldNameToChange) by newValue (in order of apparition)

[label, indexInStruct, orderToReplace] =  unique(struct.extract(structToChange, fieldNameToChange));
if nargin < 3
    newValue = num2cell(1:length(label));
end
assert(length(label) == length(newValue), 'Wrong number of element in newValue')
[~, I] = sort(indexInStruct);
newValue(I)=newValue;
newValue = newValue(orderToReplace);
[structToChange.(fieldNameToChange)] = deal(newValue{:});
structIsChanged = structToChange;