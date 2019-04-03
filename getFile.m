function [ listFile ] = getFile( exp )

%% Same as dir but remove '.' and '..' and return absolute paths in a cell var

assert(~isempty(dir(exp)), 'empty directory');
dirFile = dir(exp);
if strcmp(dirFile(1).name, '.') == 1
    dirFile = dirFile(3:end);
end
if isdir(exp)
    root = exp;
else
    root = fileparts(exp);
end
for i = 1:length(dirFile)
    listFile{i, 1} = [root filesep dirFile(i).name];
end

end

