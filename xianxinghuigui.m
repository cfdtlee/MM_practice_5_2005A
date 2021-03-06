
load percentage2.txt;
n=10;
%percent(:,n);1=饮用水，2=IV类，3=V类，4=劣V类
percent2(:,1)=percentage2(:,2)+percentage2(:,4)+percentage2(:,6);
percent2(:,2)=percentage2(:,8);
percent2(:,3)=percentage2(:,10);
percent2(:,4)=percentage2(:,12);

k=1;
AGOpercent(1,:)=percent2(1,:);

for i=2:10%cumsum()
    AGOpercent(i,:)=AGOpercent(i-1,:)+percent2(i,:);
end

B=[-0.5*(AGOpercent(1:end-1,k)+AGOpercent(2:end,k)),ones(n-1,1)];
Y=percent2(2:end,k);
r=B\Y;
y=dsolve('Dy+a*y=b','y(0)=y0');
y=subs(y,{'a','b','y0'},{r(1),r(2),AGOpercent(1,k)});
digits(6),y=vpa(y); %为提高预测精度，先计算预测值，再显示微分方程的解
yuce=subs(y,'t',[0:n+10]);
yuce=[percent2(1,k),yuce(2:end)-yuce(1:end-1)];

Y =[174.0000  179.0000  183.0000  189.0000  207.0000  234.0000  220.5000  256.0000  270.0000  285.0000]';

X=[ones(10,1),[2.9+6.7;percent2(3:7,2)+percent2(3:7,3);15.7+7.8],percent2(:,4)];
[b,bint,r,rint,stats]=regress(Y,X)
plot(percent2(:,2)+percent2(:,3)+,Y,'*')

Y=percent2(:,4);
X=[ones(10,1),[174.0000  179.0000  183.0000  189.0000  207.0000  234.0000  220.5000  256.0000  270.0000  285.0000]'];
[b,bint,r,rint,stats]=regress(Y,X)

%用预测出来的各类水的比例带入拟合公式去求未来十年的污水
%Xyc1=[69.6138	68.0243	66.471	64.9533	63.4701	62.0209	60.6047	59.2209	57.8687	56.5473]';
%Xyc2=[18.7994    19.67118	20.62539	21.67112	22.8182	24.0775	25.4613	26.9829	28.6573	30.5013]';
%Xyc3=[11.5868	12.30452	12.90361	13.37558	13.7117	13.9016	13.934	13.7962	13.474	12.9514]';
Xyc=[ones(10,1),Xyc1,Xyc2,Xyc3];
Yyc=Xyc*b;
Yobj=[ones(10,1),Xyc1+[0;0;Xyc2(3:end)-min(Xyc2(3:end),20)]+Xyc3,min(Xyc2,20),zeros(10,1)]*b