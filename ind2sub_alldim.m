function out = ind2sub_alldim(siz,ndx, nout)
%IND2SUB Multiple subscripts from linear index.
%   IND2SUB is used to determine the equivalent subscript values
%   corresponding to a given single index into an array.
%
%   {I1,I2,I3,...,In} = IND2SUB(SIZ,IND) returns N subscript arrays
%   I1,I2,..,In containing the equivalent N-D array subscripts
%   equivalent to IND for an array of size SIZ.


if nargin < 3
    nout = length(siz);
end

siz = double(siz);

if length(siz)<=nout,
  siz = [siz ones(1,nout-length(siz))];
else
  siz = [siz(1:nout-1) prod(siz(nout:end))];
end
n = length(siz);
k = [1 cumprod(siz(1:end-1))];
for i = n:-1:1,
  vi = rem(ndx-1, k(i)) + 1;         
  vj = (ndx - vi)/k(i) + 1; 
  out{i} = vj; 
  ndx = vi;     
end
