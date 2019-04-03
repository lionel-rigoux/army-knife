function [ d ] = dPrime( hit, fa )
%This function computes the dprime using hit and false alarm rates

d = norminv(hit) - norminv(fa);

end

