function [ ] = figsize( Width,Height,Metric )
%FIGSIZE 调整当前绘图大小。
%        Adjust the size of figure in 'cm' or 'in'
%
%   注意：使用此函数在 m 文件中需要设置默认参数。
%   WARNING:You need to define your screen size and default unit (cm or in)
%   in the function file.
%   
%   FIGSIZE() 根据默认参数调整图片大小。
%   FIGSIZE() Resize the figure as your preference.
%
%   FIGSIZE(Width) 根据默认单位调整图片宽度，宽高比保持不变。
%   FIGSIZE(Width) Adjust the width (in your default unit) and keep the
%   aspect ratio.
%
%   FIGSIZE(Width,Height) 根据默认单位调整图片宽度和高度。
%   FIGSIZE(Width,Height) Adjust the width and height in your default unit.
%
%   FIGSIZE(Width,Height,Metric) 根据指定参数调整图片。
%   FIGSIZE(Width,Height,Metric) Resize the figure as your input.
%
%   例：
%         x = -pi:pi/10:pi;
%         y = tan(sin(x)) - sin(tan(x));
%         plot(x,y);
%         FIGSIZE(3.5,2.5,'in');
%

% ---------------------------
% 设置屏幕大小(对角线长度)（英寸）
% Screen Size(diagonal) (in inches)
Screen = 13.3;
% 设置默认单位（in/cm）
% default unit (in/cm)
DefaultMetric = 'in';
% 设置默认图片宽度（单位为默认单位）
% default width（in default unit above）
DefaultWidth = 3.5; % IEEEtran single column
% ---------------------------

fprintf('Current Setting:\n');
fprintf('Screen Size: %.1f inches\n',Screen);
fprintf('Default Width: %.2f %s\n',DefaultWidth,DefaultMetric);

if nargin < 1
    Width = DefaultWidth;
end

if nargin < 2
    pos = get(gcf,'position');
    Height = Width * (pos(4)-pos(2)) / (pos(3)-pos(1));
end

if nargin < 3
    Metric = DefaultMetric;
end


if strcmp(Metric,'in') 
    ScreenSize = Screen;
elseif strcmp(Metric,'cm')
    ScreenSize = Screen * 2.54;
else
    error('Metric should be ''in'' or ''cm'' ');
end

scrsz = get(0,'ScreenSize');
ScreenWidth = ScreenSize / sqrt(1+(scrsz(4)/scrsz(3))^2);
ScreenHeight = ScreenWidth * scrsz(4) / scrsz(3);
WidthRatio = Width / ScreenWidth;
HeightRatio = Height / ScreenHeight;
set(gcf,'Unit','Normalized','Position',[0.35 0.35 WidthRatio HeightRatio]);

end

