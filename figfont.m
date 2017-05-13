function [ ] = figfont( varargin )
%FIGFONT 调整当前绘图窗口中坐标轴标签及图例字号和字体，并根据内容设置文本解释器。
%        Adjust the font name and font size of axis labels and legend,
%        and set the interpreter automatically.
%
%   FIGFONT()  将坐标轴标签及图例字体改为函数中定义的默认字体(预定义为'Times')，字号不变。
%   FIGFONT()  Set the font name of axis label and legend as your default 
%              font defined in this function file (predefined as 'Times').
%   
%   FIGFONT(FontSize) 将坐标轴标签及图例字体改为默认字体，字号均改为输入大小。
%   例如，FIGFONT(14) 设置坐标轴标签及图例字体为Times，字号均为14。
%   FIGFONT (FontSize) Set the the font name of axis labels and legend as 
%   your default font, and the font size of both as your input. For 
%   example, FIGFONT (14) sets axis labels' and legend's size as your 
%   default, and their font size as 14.  
%
%   FIGFONT(LabelFontSize,LegendFontSize) 将坐标轴标签及图例字体改为默认字体，
%   字号分别设置为输入大小。例如，FIGFONT(18,14) 设置坐标轴标签字号18，图例字号14。
%   FIGFONT(LabelFontSize,LegendFontSize) Set the the font name of axis 
%   labels and legend as your default font, and set their font size 
%   separately. For example, FIGFONT (18,14) sets axis labels' font size as 
%   18, and legend's font size as 14.
%
%   FIGFONT(LabelFontSize,LegendFontSize,FontName) 将坐标轴标签及图例字号分别设置为
%   输入大小，字体均改为输入字体。例如，FIGFONT(18,14,'Courier') 设置坐标轴标签及图例
%   字体为Courier，坐标轴字号18，图例字号14。
%   FIGFONT (LabelFontSize, LegendFontSize, FontName) Set the axis labels'
%   and legend's font size as your input separately, and set their font 
%   as your input. For example, FIGFONT (18,14,'Courier') sets their font as 
%   Courier, the axis label font size 18, and the legend font size 14.
%   
%   FIGFONT(LabelFontSize,LegendFontSize,LabelFontName,LegendFontName)
%   将坐标轴标签及图例字体改为默认字体，字号分别设置为输入大小，字体分别改为输入字体。
%   例如，FIGFONT(18,14,'Helvetica','Times') 设置坐标轴标签字体为Helvetica，
%   图例字体为Times，坐标轴标签字号18，图例字号14。
%   FIGFONT(LabelFontSize,LegendFontSize,LabelFontName,LegendFontName)
%   Set the font size and font name separately. For example，
%   FIGFONT(18,14,'Helvetica','Times') set the axis label font as
%   Helvetica, legend font as Times，axis label size 18，legend font size 14.
%
%   例：
%         x = -pi:pi/10:pi;
%         y = tan(sin(x)) - sin(tan(x));
%         plot(x,y); hold on; plot(x,y+1);
%         xlabel('The x axis');
%         ylabel('The y axis');
%         legend('$c_1=0$','$c_2=1$');
%         FIGFONT(18,14);
%

DefaultFont = 'Times';

if nargin == 0
    LabelFontName = DefaultFont;
    LegendFontName = DefaultFont;
elseif nargin == 1
    LabelFontSize = varargin{1};
    LegendFontSize = varargin{1};
    LabelFontName = DefaultFont;
    LegendFontName = DefaultFont;
elseif nargin == 2
    LabelFontSize = varargin{1};
    LegendFontSize = varargin{2}; 
    LabelFontName = DefaultFont;
    LegendFontName = DefaultFont;
elseif nargin == 3
    LabelFontSize = varargin{1};
    LegendFontSize = varargin{2};
    LabelFontName = varargin{3};
    LegendFontName = varargin{3};
elseif nargin == 4
    LabelFontSize = varargin{1};
    LegendFontSize = varargin{2};
    LabelFontName = varargin{3};
    LegendFontName = varargin{4};
else
    error('Too many inputs');
end

for axis = 'xyz'
    if sum((get(get(gca,[axis 'label']),'String') == '$')) >= 2
        set(get(gca,[axis 'Label']),'Interpreter','latex');
    end
end

s = get(get(gca,'Legend'),'String');
for ii = 1:length(s)
    if sum(s{ii} == '$') >= 2
        set(get(gca,'Legend'),'Interpreter','latex');
    end
end


if nargin ~= 0
    set(get(gca,'XLabel'),'FontSize',LabelFontSize);
    set(get(gca,'YLabel'),'FontSize',LabelFontSize);
    set(get(gca,'ZLabel'),'FontSize',LabelFontSize);
    set(get(gca,'Legend'),'FontSize',LegendFontSize);
end


set(get(gca,'XLabel'),'FontName',LabelFontName);
set(get(gca,'YLabel'),'FontName',LabelFontName);
set(get(gca,'ZLabel'),'FontName',LabelFontName);
set(get(gca,'Legend'),'FontName',LegendFontName);


end

