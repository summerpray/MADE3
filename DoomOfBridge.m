clear
clc
clf
begin = 0; %起点
endes = 320;  %终点
step = 1;  %步长
l = 166;   %车轮距 默认为166mm
t = begin:step:endes;

%轨迹方程
x = 0.3960 * cos(2.65*(t + 1.4));
y = 0.99 * sin(t + 1.4);

%一阶导数
x1 = -(5247*sin((53*t)/200 + 371/100))/50000;
y1 =  (99*cos(t/10 + 7/5))/1000;
%二阶导数
x2 = -(278091*cos((53*t)/200 + 371/100))/10000000;
y2 = -(99*sin(t/10 + 7/5))/10000;

figure(1)
plot(x,y)

%每一点的斜率
lengh_t = size(t);
k = eye(1,lengh_t(1,2));
for i = 1:1:lengh_t(1,2)
    k(i) = y1(i) / x1(i);
end

%求曲率和曲率半径
p = eye(1,lengh_t(1,2));    %曲率
p_r = eye(1,lengh_t(1,2));  %曲率半径
p_c_x = eye(1,lengh_t(1,2));%曲率中心x坐标
p_c_y = eye(1,lengh_t(1,2));%曲率中心y坐标
M = eye(1,lengh_t(1,2));    %左转 右转
for i = 1:step:lengh_t(1,2)
    %求曲率
    TempOfp = abs(x1(i)*y2(i)-x2(i)*y1(i))/(x1(i)^2+y1(i)^2)^(3/2);
    p(i) = TempOfp;
    p_r(i) = 1/TempOfp;
    %求曲率中心xy坐标
    p_c_x(i) = x(i)+y1(i)*(x1(i)^2+y1(i)^2)/(y1(i)*x2(i)-x1(i)*y2(i));
    p_c_y(i) = y(i)-x1(i)*(x1(i)^2+y1(i)^2)/(y1(i)*x2(i)-x1(i)*y2(i));
    if x1(i)*y2(i)-x2(i)*y1(i) < 0
        M(i) = 1;
    else
        M(i) = -1;
    end
end

%求公切点T
for i = 1:step:lengh_t(1,2)-1
    xa = x(i)
    xb = x(i + 1)
    ya = y(i)
    yb = y(i + 1)
    
