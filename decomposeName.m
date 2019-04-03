function [ fields ] = decomposeName( structName, sep )
% Decompose a struct or a file name splitting by sep
% eg.

if nargin ==1
    sep ='\.';
end


listSep = regexp(structName, sep);
nSep = length(listSep);
if nSep ==0;
    fields = {structName};
else
    fields{1} = structName(1:(listSep(1)-1));
    for iSep = 2:nSep
        fields{iSep}=structName((listSep(iSep-1)+1):(listSep(iSep)-1));
    end
    fields{end+1} = structName((listSep(end)+1):end);
end



end

