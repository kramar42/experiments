function res=EqSolve(number)
x= sym ('x');
if(number==1)
  x1 = -3:0.01:2;
  y = x1.*x1.*sin(x1)+x1.^5+35-x1.^3;
  plot(x1,y);
  grid on;
  axis( [ -3, 2, -40, 40 ] )
  
   res=fzero(@(res) F1(res),[-3,-1]);

elseif(number==2)
% res=solve(x^13-(cosh(x))^5+x+x^30+5-log((5+pi*sinh(x^3))^2));
  x1 = -3:0.01:3;
  y = x1.^13-(cosh(x1)).^5+x1+x1.^30+5-log((5+pi.*sinh(x1.^3)).^2);
  plot(x1,y);
  grid on;
  axis( [ -2, 2, -3, 2 ] )
  
   res{1}=fzero(@(res) F2(res),[-2,-1]);
   res{2}=fzero(@(res) F2(res),[-1,0]);
   res{3}=fzero(@(res) F2(res),[0,1]);
   res{4}=fzero(@(res) F2(res),[1,2]);

elseif(number==3)
res=solve(+(-318.000)*x^0+(-295.000)*x^1+(921.000)*x^2+(585.000)*x^3+(-774.000)*x^4+(-199.000)*x^5+(187.000)*x^6+(-10.000)*x^7);
    x1 = -18:0.01:18;
    y = +(-318.000).*x1.^0+(-295.000).*x1.^1+(921.000).*x1.^2+(585.000).*x1.^3+(-774.000).*x1.^4+(-199.000).*x1.^5+(187.000).*x1.^6+(-10.000).*x1.^7;
  plot(x1,y);
  grid on;
  axis( [ -3, 18, -200, 200 ] )
end
function f = F1(x1)
f=x1*sin(x1)+x1^5+35-x1^3;
end
function f = F2(x)
f=x^13-(cosh(x))^5+x+x^30+5-log((5+pi*sinh(x^3))^2);