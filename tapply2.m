function [ outputArg ] = tapply( x, list, fName, options, isEvalOption )
% This is a 'dirty' quivalent of the R function
% Apply a function to each (non-empty) group of values given by a unique combination of the
% levels of certain factors.
%
% IN:
%     x : a vector
%     list : a cell of one or more factors, each of same length as ‘X’.
%     fName : the function to be applied (e.g. @mean)
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


if exist('options')
    isOption = 1;
else
    isOption = 0;
    isEvalOption=0;
end


if exist('isEvalOption')
    isEvalOption=0;
end

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


try
    
    if length(list)==1
        outputArg=zeros(1,dim);
    else
        outputArg=zeros(dim);
    end
    
    for i = 1:numel(outputArg)
        eval([c '=ind2sub(dim,i);']);
        test=ones(1, length(x));
        for j = 1:length(list)
            eval(['ind = i' num2str(j) ';']);
            l=list{j};
            l=l(:);
            f=unique(l);
            test(l~=f(ind))=0;
        end
        
        if isOption == 1
            if isEvalOption ~=0
                outputArg(i)=fName(x(test==1), eval(options));
            else
                outputArg(i)=fName(x(test==1), options);
            end
        else
            outputArg(i)=fName(x(test==1));
        end
    end
        catch
            if length(list)==1
                outputArg=cell(1,dim);
            else
                outputArg=cell(dim);
            end
            
            for i = 1:numel(outputArg)
                eval([c '=ind2sub(dim,i);']);
                test=ones(1, length(x));
                for j = 1:length(list)
                    eval(['ind = i' num2str(j) ';']);
                    l=list{j};
                    l=l(:);
                    f=unique(l);
                    test(l~=f(ind))=0;
                end
                
                if isOption == 1
                    if isEvalOption ~=0
                        outputArg{i}=fName(x(test==1), eval(options));
                    else
                        outputArg{i}=fName(x(test==1), options);
                    end
                else
                    outputArg{i}=fName(x(test==1));
                end
            end
            
end
end


            
