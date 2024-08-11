close all;

x=-100:0.01:100;
t=0.01;

xpt=x+t; %x plus t
xmt=x-t; %x minus t

[rxptn,cxptn]=size(xpt(xpt<0)); %Number of entries in xpt that are negative
[rxptp,cxptp]=size(xpt(xpt>=0)); %Number of entries in xpt that are nonnegative
H1=[zeros(rxptn,cxptn),ones(rxptp,cxptp)];

[rxmtn,cxmtn]=size(xmt(xmt<0)); %Number of entries in xpt that are negative
[rxmtp,cxmtp]=size(xmt(xmt>=0)); %Number of entries in xpt that are nonnegative
H2=[zeros(rxmtn,cxmtn),ones(rxmtp,cxmtp)];

H=H1-H2;

h=plot(x,H);
ylim([0 1.05]);
xlabel('x')
set(h,'EraseMode','xor');

for t=0.01:0.05:95,
    drawnow;
    xpt=x+t; %x plus t
    xmt=x-t; %x minus t

    [rxptn,cxptn]=size(xpt(xpt<0)); %Number of entries in xpt that are negative
    [rxptp,cxptp]=size(xpt(xpt>=0)); %Number of entries in xpt that are nonnegative
    H1=[zeros(rxptn,cxptn),ones(rxptp,cxptp)];

    [rxmtn,cxmtn]=size(xmt(xmt<0)); %Number of entries in xpt that are negative
    [rxmtp,cxmtp]=size(xmt(xmt>=0)); %Number of entries in xpt that are nonnegative
    H2=[zeros(rxmtn,cxmtn),ones(rxmtp,cxmtp)];

    H=H1-H2;
    set(h,'YData',H)

end;