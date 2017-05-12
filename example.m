%%
x = -pi/2:pi/20:pi/2;
y = tan(sin(2*x))/25 - sin(tan(2*x))/20;
plot(x,y);
hold on;
plot(x,y+0.05);
xlabel('The x axis');
ylabel('The y axis');
legend('$c_1=0$','$c_2=1$','Location','Southeast');

%%
% figsize();
% figfont(14);
% figtick();
% figline(2,8,'os');
% figsave('example');
