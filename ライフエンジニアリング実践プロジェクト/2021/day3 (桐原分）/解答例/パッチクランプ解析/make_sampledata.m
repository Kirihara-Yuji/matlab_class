clear vars
close all

c=zeros(1,1000);

for j=1:1000
%サンプルデータ作り
size=10000;
max=0.2;
min=0.1;
std=0.02;

x=ones(1,size)*min;
x(size/2+1:size)=max;
y1=x;

x=x+randn(1,size)*std;
y2=x;

for i=1:size
    temp=randn(1,1);
    if temp>3
        x(i)=0.5;
    end
end

y3=x;
%サンプルデータ作り終わり

x=movmean(x,round(size/100));

y4 = x;

ave_bef=mean(x(1:round(size*0.1)));
ave_aft=mean(x(round(size*0.9):size));
ave=(ave_bef+ave_aft)/2;

diff=x-ave;

for i=2:size
    if diff(i-1)*diff(i)<0
        diff_point=i;
        c(j)=diff_point;
    end
end


end
figure('Name','sample')
hold on
plot(y3,'Color',[0.2 0.2 0.6]);
plot(y4,'Color','g');
plot(y1,'Color','y');
line([diff_point diff_point],[0 0.5],"Color",'r');
txt=['境目=',num2str(diff_point)];
legend('サンプルデータ','移動平均 n=100','理想のステップ関数',txt);
hold off

figure('Name','diff_pointのヒストグラム')
histogram(c);
