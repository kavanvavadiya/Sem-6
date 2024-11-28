%Task1

x=-10:10;

Y1=x.*x;
Y2=cos(x);
subplot(2,1,1);
plot(x,Y2);
xlabel("x")
ylabel("cos(x)")
grid on
title("Graph of cos(x) vs x")

subplot(2,1,2);
plot(x,Y1);
xlabel("x")
ylabel("x^2")
title("Graph of x^2 vs x")
grid on
