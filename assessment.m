%计算评价标准
%PH=pollution(:,1); DO=pollution(:,2); Mn=pollution(:,3); NH=pollution(:,4); 
pollution2(:,2)=2./pollution(:,2); 
pollution2(:,3)=pollution(:,3)./15;
pollution2(:,4)=pollution(:,4)./2;
biaozhun=[0 0 0 0 0;0.266666667	0.333333333	0.4	0.666666667	1;0.133333333	0.266666667	0.4	0.666666667	1;0.075	0.25	0.5	0.75	1];
alpha=biaozhun(:,1)./2;
thigama=(biaozhun(:,3)-alpha)./sqrt(-log(1-0.9));
for i=1:476
    j=ceil(i/17);k=mod(i,17);
    if(k==0)
        k=17;
    end
    pingjia(j,k)=sum(1-exp(-((pollution2(i,2:4)-alpha(2:4)')./thigama(2:4)').^2));
end
bianyixishu=std(pingjia,0,2) ./mean(pingjia,2);
for i=1:17
    zonghepingjia(i)=sum(pingjia(:,i).*bianyixishu);
end
zonghepingjia=zonghepingjia';%每个地区的评价

bianyixishu2=std(pingjia)./mean(pingjia);
for i=1:28
    zonghepingjia2(i)=sum(pingjia(i,:).*bianyixishu2);
end
zonghepingjia2=zonghepingjia2';%每个月的评价