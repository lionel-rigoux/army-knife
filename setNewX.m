function [updatedX] = setNewX(currentX,options, varargin)
% This function allows to set new values of x using label

n = numel(varargin);
assert(mod(n,2)==0,'***Parameters should be: ''name'',newValue,...');
updatedX=currentX;
for i=1:2:n
    name = varargin{i};
    newValue = varargin{i+1};
    idx=options.stateLabel.(name);
    updatedX(idx)=newValue;
end
    
    