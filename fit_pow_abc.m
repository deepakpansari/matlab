function [a_temp,b_temp,c_temp] = fit_pow_abc(x,y)


%Curve fitting for power law%
% Fit  acurve of the form y= a*x^b + c, For the following data by the
% methode of least square.cd 
format compact
syms b d p

for i=1:(length(x)-1)
    x_av(i) = (x(i) + x(i+1))/2;
    dx(i) = x(i+1) - x(i);
    dy(i) = y(i+1) - y(i);
end

Y_temp = dy./dx;
if Y_temp(1)<0 
    is_negetive=1;
else
    is_negetive=0;
end

Y = log(abs(dy./dx));
X = log(x_av);

f1 = (b-1)*sum(X.^2) + d*sum(X) - sum(X.*Y);
f2 = (b-1)*sum(X) + d*length(X) - sum(Y);
[b d] = solve(f1,f2);
 
b = double(b);

if is_negetive ==1
    a = double(-exp(d)/b);
else
    a = double(exp(d)/b);
end

c = double(y - a*x.^b);

c_avg=1;
if rem(length(x),2)==1
    for i=1:length(x)
        c_avg = c_avg*nthroot(c(i),length(x));
    end
elseif rem(length(x),2)==0
     for i=1:length(x)
        c_avg = c_avg*sqrt(nthroot(c(i),length(x)/2));
     end
end

c = c_avg;

%%% copy all a b c from command window and paste it here %%%

a_temp=a;
b_temp=b;
c_temp=c;

scatter(x,y)
hold on

x=linspace(x(1),x(length(x)));
y = a*x.^b + c;
plot(x,y)
grid on
end

    
