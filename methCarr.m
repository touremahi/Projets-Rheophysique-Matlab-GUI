function [y2,a,b]=methCarr(x,y)

% Moindres carrées

xm=mean(x);
ym=mean(y);

xib=x-xm;
yib=y-ym;

xib2=xib.^2;
xiyi=xib.*yib;
a=sum(xiyi)/sum(xib2);

b=ym-(a*xm);

y2=a*x+b;
% plot(x,y,'-*',x,y2,'--')
end