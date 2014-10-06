function [subStructList,idx] = where(structList,fieldName,value)
% WHERE filter a list of structure such that StructList.(...).fieldName == value
% 

 valueList = struct.extract(structList,fieldName);
 if isnumeric(valueList)
     valueList = num2cell(valueList);
 end
 
idx = cellfun(@(x) isequal(x,value), valueList );
subStructList = structList(idx);

idx = find(idx);



end





