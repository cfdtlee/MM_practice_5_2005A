load percentage.txt;
n=10;
%percent(:,n);1=饮用水，2=IV类，3=V类，4=劣V类
percent(:,1)=percentage(:,2)+percentage(:,4)+percentage(:,6);
percent(:,2)=percentage(:,8);
percent(:,3)=percentage(:,10);
percent(:,4)=percentage(:,12);
C=0;k=3;
for i=1:9
    for j=1:4
        percentjb(i,j)=(percent(i,j)+C)/(percent(i+1,j)+C);
    end
end
find(percentjb(:,3)>exp(2/12))
find(percentjb(:,3)<exp(-2/12))

AGOpercent(1,:)=percent(1,:)+C;
for i=2:10%cumsum()
    AGOpercent(i,:)=AGOpercent(i-1,:)+percent(i,:);
end

B=[-0.5*(AGOpercent(1:end-1,k)+AGOpercent(2:end,k)),ones(n-1,1)];
Y=percent(2:end,k)+C;
r=B\Y;
y=dsolve('Dy+a*y=b','y(0)=y0');
y=subs(y,{'a','b','y0'},{r(1),r(2),AGOpercent(1,k)});
digits(6),y=vpa(y); %为提高预测精度，先计算预测值，再显示微分方程的解
yuce=subs(y,'t',[0:n+10]);
yuce=[percent(1,k)+C,yuce(2:end)-yuce(1:end-1)];

lei1=[93.1,85.6996,83.7427,81.8306,79.9621,78.1363,76.3521,74.6088,72.9052,71.2405,69.6138,68.0243,66.471,64.9533,63.4701,62.0209,60.6047,59.2209,57.8687,56.5473,55.2561];
lei2=[3.9,10.9144,11.0328,11.1525,11.2735,11.3957,11.5193,11.6443,11.7706,11.8983,12.0273,12.1578,12.2896,12.4229,12.5577,12.6939,12.8316,12.9708,13.1114,13.2537,13.3974];
lei3=[3, 2.65901, 2.95006, 3.27298, 3.63124, 4.02871, 4.46969, 4.95894, 5.50175, 6.10397, 6.7721, 7.51338, 8.33579, 9.24822, 10.2605, 11.3836, 12.6297, 14.0121, 15.5459, 17.2476, 19.1355];


