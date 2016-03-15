function [val] = newtonDivDiff(X,y,x_val)

% Newton Divided difference formula%
% x is the input array of x data
% y is the input array of y data
% x_val is the value of x where y is required
% fun will be printed on screen
% val is the function value at x_val

%----------Theory_-----------------------%
%Newtons Divided Difference Interploation Formula (NDD)
%%
%	:: if f(x0),f(x!),...f(xn) are values of f(x) corrosponding to the argument
%	   x0,x1,...xn, that are not necessarly equally spaced then 
%          f(x) = f(x0) + (x-x0)(fx0,x1) + (x-x0)(x-x1)(fx0,x1,x2) + (x-x0)(x-x1)(x-x2)
%		  (fx0,x1,x2,x3)....(x-x0)(x-x1)(x-x2)..(x-xn-1)(fx0,x1...xn)
%
%   where, 
%		f(x0,x1)  = f(x1)-f(x0)
%			    ___________
%			      x1-x0
%
%
%		f(xr-1,xr) = f(xr) - f(xr-1)
%		             ______________
%			     (xr)-(xr-1)
%
%------------start of function------------%

dataMatrix = [X' y']; %creating x and y array

for n=3:1:(length(X)+1) %initializing the loop for getting the differncial%
    for loop_counter=1:1:(length(dataMatrix(:,n-1))-(n-2)) %loop for assigning data to the matrix%
        dataMatrix(loop_counter,n) = (dataMatrix((loop_counter+1),n-1) - dataMatrix(loop_counter,n-1))/(dataMatrix((loop_counter+n-2),1) - dataMatrix(loop_counter,1)); % calculating the data%
    end
end

%-------printing the string ---------%
fprintf('\n\nNewton Forward Divided Difference Method\n');
fprintf('--------------------------------------------------------------------------------------------\n');
fprintf('x\t\ty\t\t');
for i=1:(length(dataMatrix(1,:))-2) 
    fprintf('DivDiff%d\t',i)
end
    fprintf('\n');
    fprintf('--------------------------------------------------------------------------------------------\n\n')
    

%--------printing the data----------------%
for i=1:(length(dataMatrix(:,1)))
    for j=1:(length(dataMatrix(1,:)))
        fprintf('%f\t',dataMatrix(i,j)) %printing data element by element%
    end
    fprintf('\n');
end

%--------returning the function ----------%
syms x;  % defining x to be used in the function%
funcStr = dataMatrix(1,2); % this is just f(0)%
fprintf('\n Function is ,\nf(x) = ');
for i=1:(length(dataMatrix(1,:))-2)
    funcSeg = dataMatrix(1,i+2); % f'(x),f''(x),f'''(x) etc.. %
    for j=1:i
        funcSeg = (x-dataMatrix(j,1))*funcSeg; % segmented function string%
    end
    funcStr = funcStr + funcSeg; %adding up those string%
    funcSeg = 1;
end
disp(simplify(funcStr)); % displaying the string by simplifying it first%

%------calculating the functional value----%
val = subs(funcStr,x,x_val); % calculating functional value by just substitution%
end
