function [ output_args ] = tapply( x, list, fname )
% This is a 'dirty' quivalent of the R function
% Apply a function to each (non-empty) group of values given by a unique combination of the
% levels of certain factors.
%
% IN:
%     x : a vector 
%     list : a cell of one or more factors, each of same length as ‘X’.
%     fname : the function to be applied (e.g. @mean)
% Out 
%     a N*M*... matrix
%     where N, M, etc are the number of levels of each factor defined in list
%
% Example:
% x = 1:120
% A = sort(repmat([1 2], 1,60))
% B = repmat([1 2 3 4], 1,30)
% y = tapply(x, {A, B}, @mean)
%
% y =
%         29    30    31    32
%         89    90    91    92




x=x(:);
c=['['];
for i = 1:length(list)
  l=list{i};
  l=l(:);
  dim(i)=length(unique(l));
  if length(l) ~=length(x)
      error(['length(var)~=length(list{' num2str(i) '}'])
  end
  c=[c 'i' num2str(i) ' '];
end

c=[c ']'];

if length(list)==1
output_args=zeros(1,dim);
else
output_args=zeros(dim);
end

for i = 1:numel(output_args)
    eval([c '=ind2sub(dim,i);']);
    test=ones(1, length(x));
    for j = 1:length(list)
        eval(['ind = i' num2str(j) ';']);
        l=list{j};
        l=l(:);
        f=unique(l);
        test(l~=f(ind))=0;
    end
    output_args(i)=fname(x(test==1));
end
end

