function [OVL] = OVL(target,background)
%GSSMD Calculate Overlap of two distributions

% get range of values
nbins = round(1+log2(min(length(target),length(background))));
x=linspace(min([target background]),max([target background]),nbins);

% estimate probability density function
pdf_t=hist(target,x);     
pdf_b=hist(background,x);

% estimate overlap
OVL=sum(min([pdf_t./sum(pdf_t); pdf_b./sum(pdf_b)]));

end