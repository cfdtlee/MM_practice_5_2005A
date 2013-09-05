load percentage2.txt;
n=10;
%percent(:,n);1=饮用水，2=IV类，3=V类，4=劣V类
percent2(:,1)=percentage2(:,2)+percentage2(:,4)+percentage2(:,6);
percent2(:,2)=percentage2(:,8);
percent2(:,3)=percentage2(:,10);
percent2(:,4)=percentage2(:,12);
C=0;k=3;


AGOpercent(1,:)=percent2(1,:)+C;
for i=2:10%cumsum()
    AGOpercent(i,:)=AGOpercent(i-1,:)+percent2(i,:);
end

B=[-0.5*(AGOpercent(1:end-1,k)+AGOpercent(2:end,k)),ones(n-1,1)];
Y=percent2(2:end,k)+C;
r=B\Y;
y=dsolve('Dy+a*y=b','y(0)=y0');
y=subs(y,{'a','b','y0'},{r(1),r(2),AGOpercent(1,k)});
digits(6),y=vpa(y); %为提高预测精度，先计算预测值，再显示微分方程的解
yuce=subs(y,'t',[0:n+10]);
yuce=[percent2(1,k)+C,yuce(2:end)-yuce(1:end-1)];



Y =[174.0000  179.0000  183.0000  189.0000  207.0000  234.0000  220.5000  256.0000  270.0000  285.0000]';
%x1=[percent(1:7,1);percent(10:,1)]
X=[ones(10,1),percent2(:,1),percent2(:,2)+percent2(:,3),percent2(:,4)];
[b,bint,r,rint,stats]=regress(Y,X,0.01)
X=[percent2(:,1),percent2(:,2)+percent2(:,3),percent2(:,4)];
rstool(X,Y,'purequadratic')
%用预测出来的各类水的比例带入拟合公式去求未来十年的污水