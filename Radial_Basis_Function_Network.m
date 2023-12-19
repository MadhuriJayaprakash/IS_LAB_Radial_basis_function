clc
clear all;

u = 0.1: 1/22: 1;
V = (1 + 0.6*sin (2 * pi * u / 0.7)) + 0.3 * sin (2 * pi * u) / 2;
[p,n1] = findpeaks(V);


for i = 1 : length(n1)
    c(i)= u(n1(i));
end

a1 = 0.36 - 0.19;
a2 = 0.89 - 0.73;
b0 = randn(1);
b1 = randn(1);
b2 = randn(1);
Eta = 0.1;
elim = 0.0000000001;
e = [];
etotal = 1;

while etotal >= elim
 
    e = [];
    Y = [];
for i = 1 : length(u)
Q1 = exp(-(u(i)-c(1))^2/(2*a1^2));
Q2 = exp(-(u(i)-c(2))^2/(2*a2^2));
Y(i) = Q1*b1+Q2*b2+b0;
e(i) = V(i) - Y(i);

D1 = e(i);
b1 = b1 + Eta*D1*Q1;
b2 = b2 + Eta*D1*Q2;
b0 = b0 + Eta*D1*1;

end


for i = 1 : length(u)
    Q1 = exp(-(u(i)-c(1))^2/(2*a1^2));
    Q2 = exp(-(u(i)-c(2))^2/(2*a2^2));
    Y(i) = Q1*b1+Q2*b2+b0;
    e(i) = V(i) - Y(i);
end
etotal = (e.^2)/length(u);
fprintf('e=%2.10f \n',etotal);
end
plot(u,V,u,Y);