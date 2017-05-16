function [ ] = figlegend( varargin )
%FIGLEGEND 选择图例显示内容，将图例重新排序。
%          Select the items shown and reorder the items in the legend.
%
%   FIGLEGEND()  将图例项目倒序排列。
%   FIGLEGEND()  Reverse the items in the legend.
%
%   FIGLEGEND(0) 重新设置图例,显示所有元素。
%   FIGLEGEND(0) Reset the legend and show all the items.
%
%   FIGLEGEND(NewOrder) 重新设置图例顺序，也可以用于只显示部分曲线图例。例如，
%   FIGLEGEND([1,3,2])将第二个元素与第三个元素对调。
%   FIGLEGEND(NewOrder) Reorder the items in legend. It can also used for
%   selecting the items you want to show in the legend and hide others. For
%   example, FIGFONT(1,2) swaps the second and third items in the legend.
%   
%   FIGLEGEND(Item1, Item2) 将图例中两个元素互换。例如，FIGFONT(1, 2)将图例中第
%   一个和第二个元素互换。
%   FIGLEGEND(Item1, Item2) Swap two items in the label. For example, 
%   FIGLEGEND(1,2) swaps the first and second items in the legend.
% 
%   例：
%         x = -pi:pi/10:pi;
%         y = tan(sin(x)) - sin(tan(x));
%         plot(x,y); hold on; 
%         plot(x,y+1); plot(x,y+2);
%         legend('line1','line2','line3');
%         FIGLEGEND([3 1]);
%


g = get(gca,'children');
g = flipud(g);
l = get(get(gca,'Legend'),'String');


switch nargin
    case 0
        g(1:length(l)) = flipud(g(1:length(l)));
        set(gca,'children',flipud(g));
        legend(g(1:length(l)));
    case 1
        if varargin{1} == 0
            legend off
            legend('show');
        else
            if ~prod(ismember(varargin{1},1:length(g))) || ...
                    ~(length(varargin{1}) == length(unique(varargin{1})))
                error('Input error');
            end
            map = [varargin{1} setdiff(1:length(g),varargin{1})];
            g = g(map);
            set(gca,'children',flipud(g));
            legend(g(1:length(varargin{1})));
        end
    case 2
        Item1 = g(varargin{1});
        Item2 = g(varargin{2});
        temp = Item1;
        g(varargin{1}) = Item2;
        g(varargin{2}) = temp;
        set(gca,'children',flipud(g));
        legend(g(1:length(l)));
    otherwise
        error('Too many inputs');
end

