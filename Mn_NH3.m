%Ѱ����ȾԴ
load liuliangliusu.txt%26*7,����ÿ����Ϊһ���µ�����������
zhandianjuli=[0	950	1728	2123	2623	2787	3251];
liuliang=liuliangliusu(2:2:26,:);
liusu=liuliangliusu(1:2:26,:);
for k=171:391
    j=mod(k,17);
    if(j~=0 && j<=7)
        i=ceil(k/17)-10;
        cMn(i,j)=pollution(k,3);
        cNH3(i,j)=pollution(k,4);
    end
end

%�����������ʺ��������&��Сֵ
kk=?;
for i=1:13
    for j=1:6
        wMn1(i,j)=liuliang(i,j+1)*cMn(i,j+1)*exp(2*kk*(zhandianjuli(j+1)-zhandianjuli(j))/(liusu(i,j)+liusu(i,j+1)))-liuliang(i,j)*cMn(i,j);
        wNH31(i,j)=liuliang(i,j+1)*cNH3(i,j+1)*exp(2*kk*(zhandianjuli(j+1)-zhandianjuli(j))/(liusu(i,j)+liusu(i,j+1)))-liuliang(i,j)*cNH3(i,j);
        nMn2(i,j)=liuliang(i,j+1)*cMn(i,j+1)-liuliang(i,j)*cMn(i,j)*exp(2*kk*(zhandianjuli(j+1)-zhandianjuli(j))/(liusu(i,j)+liusu(i,j+1)));
        wNH32(i,j)=liuliang(i,j+1)*cNH3(i,j+1)-liuliang(i,j)*cNH3(i,j)*exp(2*kk*(zhandianjuli(j+1)-zhandianjuli(j))/(liusu(i,j)+liusu(i,j+1)));
    end
end
%�������Ũ��
CMn=(sum(wMn1)+sum(wMn2))./13./(2*zhandianjuli(j+1)-zhandianjuli(j));
CNH3=(sum(wNH31)+sum(wNH32))./13./(2*zhandianjuli(j+1)-zhandianjuli(j));