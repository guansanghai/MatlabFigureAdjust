function [ ] = figline( LineWidth, MarkerSize, Style)
%FIGLINE 调整当前绘图中所有曲线线条颜色，粗细及数据点类型和大小。
%        Adjust the Color, LineWidth, LineStyle, MarkerSize and Marker of all the 
%        lines in one step. 
%
%   FIGLINE(LineWidth, MarkerSize, Style) 一次设置绘图中全部曲线，
%   保持不变则使用 [] 缺省。
%   FIGLINE(LineWidth, MarkerSize, Style) Adjust the styles of all the 
%   lines in one step, and jump the parameter constant with '[]'.
%
%   例如，FIGLINE(2) 将线宽设置为 2
%   FIGLINE(2, [], '-') 将线宽设置为 2，线形为直线。
%   FIGLINE(2, 0) 将线宽设置为 2，隐藏数据点。
%   FIGLINE(0, 6, '.') 隐藏图中曲线，绘制成散点图，散点大小为 6。
%   FIGLINE('--bros') 线宽和数据点大小保持不变，线形设置为虚线，颜色为蓝和红，
%   数据点形状分别设置为圆和方块，等效于 FIGLINE([], [], '--os')。
%
%   For example, FIGLINE(2) set the LineWidth of all the lines as 2.
%   FIGLINE(2, [], '-') Set the LineWidth as 2 and LineStyle as solid line.
%   FIGLINE(2, 0) Set the LineWidth as 2 and hide markers.
%   FIGLINE(0, 6, '.') Hide the line and set MarkerSize as 6.
%   FIGLINE('--bros') Keep the LineWidth and MarkerSize, and set the two (or
%   more) lines' color as blue and red, marker as circle and square 
%   separately. You can also use FIGLINE([], [], '--bros').
%
%   注意：添加适当间隔以避免歧义。例如，使用'.-'或'- .'，而不是'-.'(点划线)，以产生点状数
%   据点'.'和直线'-'。同样需要注意的还有'--'(虚线)。
%   WARNING: Add proper spaces to avoid ambiguity. For example, use '.-'
%   or '- .', other than '-.'(dash-dotted line), to set dotted Marker '.'
%   and solid line '-'. The same to '--'(dashed line).
%
%   函数中提供了 9 个可供自定义的颜色，使用 '1' ~ '9' 调用。
%   You can customize the color you frequently used in this function, and
%   call them by '1' to '9'.
%
%   颜色 (Color): 'y' | 'm' | 'c' | 'r' | 'g' | 'b' | 'w' | 'k' | '1'~'9'(custom)
%   线形 (LineStyle): '-' | '--' | ':' | '-.'
%   数据点形状 (Marker): '+' | 'o' | '*' | '.' | 'x' | 's' | 'd' | '^' | 'v' |'<' | '>' | 'p' | 'h'
%
%   例：
%         x = -pi:pi/20:pi;
%         y = tan(sin(x)) - sin(tan(x));
%         plot(x,-y); hold on; plot(x,y+1);
%         FIGLINE(2, 24, '--.');
%

% You can predefine colors frequently used here
ColorMap = {[0 0.45 0.74],[0.85 0.33 0.1],[0.93 0.69 0.13],[0.49 0.18 0.56],...
    [0.47 0.67 0.19],[0.3 0.75 0.93],[0.64 0.08 0.18],[0.3 0.3 0.3],[0.6 0.6 0.6]};

PermittedColorChar = 'ymcrgbwk';
PermittedColorNum = '123456789';
PermittedLineStyle = '-=:;';
PermittedMarker = '+o*.xsd^v<>ph';

if nargin == 0
    return;
elseif nargin == 1
    if isa(LineWidth,'double')
        MarkerSize = [];
        Style = [];
    elseif isa(LineWidth,'char')
        Style = LineWidth;
        LineWidth = [];
        MarkerSize = [];
    end
elseif nargin == 2
    Style = [];
end

if ~isempty(Style) && ~isa(Style,'char')
    error('The Style is invalid');
end

if ~prod(ismember(Style,[' ' PermittedColorChar PermittedColorNum PermittedLineStyle PermittedMarker]))
    error('The Style should be y m c r g b w k 1~9 - -- : -. + o * . x s d ^ v < > p h');
end

if ~isempty(Style)
    Style = strrep(Style,'--','=');
    Style = strrep(Style,'-.',';');
end

Color = Style(ismember(Style,[PermittedColorChar PermittedColorNum]));
LineStyle = Style(ismember(Style,PermittedLineStyle));
Marker = Style(ismember(Style,PermittedMarker));

g = get(gca,'children');
h = [];
for temp = g
    if isa(temp,'matlab.graphics.chart.primitive.Line')
        h = [h temp];
    end
end

if ~isempty(LineStyle)
    LineStyleTable = repmat(LineStyle,1,ceil(length(h)/length(LineStyle)));
    for ii = 1:length(h)
        switch LineStyleTable(ii)
            case '-'
                set(h(ii),'LineStyle','-');
            case '='
                set(h(ii),'LineStyle','--');
            case ':'
                set(h(ii),'LineStyle',':');
            case ';'
                set(h(ii),'LineStyle','-.');
        end            
    end 
end

if ~isempty(LineWidth)
    if ~isscalar(LineWidth) || ~isa(LineWidth,'double') || LineWidth < 0
        error('The LineWidth is invalid');
    end
    if LineWidth == 0
        for temp = h
            set(temp,'LineStyle','none');
        end
    else
        for temp = h
            set(temp,'LineWidth',LineWidth);
        end
    end    
end

if ~isempty(Marker)
    % you can predefine a markertable here
    % MarkerTable = repmat(['o' 's' '^' 'v'],1,ceil(length(h)/length(Marker)));
    MarkerTable = repmat(Marker,1,ceil(length(h)/length(Marker)));
    for ii = 1:length(h)
        set(h(ii),'Marker',MarkerTable(ii));
    end 
end

if ~isempty(Color)
    % you can predefine a colortable here
    % ColorTabel = repmat(['b' 'r' 'm' 'c'],1,ceil(length(h)/length(Color)));
    ColorTable = repmat(Color,1,ceil(length(h)/length(Color)));
    for ii = 1:length(h)
        color = ColorTable(ii);
        if ismember(color,PermittedColorNum)
            color = ColorMap{str2double(color)};
        end
        set(h(ii),'Color',color);
    end 
end

if ~isempty(MarkerSize)
    if ~isscalar(MarkerSize) || ~isa(MarkerSize,'double') || MarkerSize < 0
        error('The MarkerSize is invalid');
    end
    if MarkerSize == 0
        for temp = h
            set(temp,'Marker','none');
        end
    else
        for ii = 1:length(h)
            set(h(ii),'MarkerSize',MarkerSize);
        end
    end 
end

end


