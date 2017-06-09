function [ hl, hf ] = colorerrorbar( x, y, err, color, facealpha )
%COLORERRORBAR 阴影误差曲线图
%   x: 横坐标
%   y: 纵坐标
%   err: 上下误差，输入为 err 或 [neg pos]
%   color: 颜色
%   facealpha: 透明度
%
%   Sea Also ERRORBAR

if nargin < 5
    facealpha = 0.3;
end
if nargin < 4
    color = [];
end

n = size(x);
if n(1) > n(2)
    x = x';
end
n = size(y);
if n(1) > n(2)
    y = y';
end
n = size(err);
if n(1) > n(2)
    err = err';
end
n = size(err);
if n(1) == 1
    neg = y - err;
    pos = y + err;
else
    neg = err(1,:);
    pos = err(2,:);
end

if isempty(color)
    hl = plot(x,y);
    color = get(hl,'Color');
else
    hl = plot(x,y,'Color',color);
end

hf = patch([x fliplr(x)],[pos fliplr(neg)], color,'FaceAlpha',facealpha,'EdgeAlpha',0);

end

