function [ ] = figtick( varargin )
%FIGTICK 调整当前绘图窗口中坐标轴刻度。
%        Adjust the axis tick label.
%
%   FIGTICK() 自动调整 x,y,z 坐标轴，补齐小数点后位数。
%   FIGTICK() Adjust x,y,z axis tick labels automatically, fill in zeros
%   after the decimal point to make the tick labels aligned.
%
%   FIGTICK(Axis) 自动调整指定坐标轴，补齐小数点后位数。例如，FIGTICK('xy')。
%   FIGTICK(Axis) Adjust tick labels on your input axises, fill in zeros 
%   after the decimal point.
%
%   FIGTICK(Axis,n) 手动调整指定坐标轴，保留小数点后 n 位。例如，FIGTICK('x',2) 
%   或 FIGTICK('yz',1) 等。
%   FIGTICK(Axis,n) Adjust tick labels on your input axises manually,
%   accurate to the n-th(your input) decimal place. Such as FIGTICK('x',2)
%   and FIGTICK('yz',1).
%
%   FIGTICK(Axis,TickLabel) 手动设置指定坐标轴刻度。
%   例如，FIGTICK('z',{'0','1.0','2.0'}) 可将 z 坐标轴刻度改为 0 ,1.0, 2.0。
%   FIGTICK(Axis,TickLabel) Set the tick labels manually. For example,
%   FIGTICK('z',{'0','1.0','2.0'}) sets the z axis tick label as 0 ,1.0,
%   2.0.
%
%   FIGTICK(Axis,OldLabel,NewLabel) 手动替换指定坐标轴内容。
%   例如，FIGTICK('y','0','0.00') 可将 y 轴 0 刻度改为 0.00。
%   FIGTICK(Axis,OldLabel,NewLabel) replace a tick label to your input.
%   For example, FIGTICK('y','0','0.00') changes '0' tick on your y axis to
%   '0.00'.
%
%   例：
%         x = -pi/2:pi/20:pi/2;
%         y = tan(sin(2*x))/25 - sin(tan(2*x))/20;
%         plot(x,y);
%         FIGTICK();
%

axis = '';
digits = [];

if nargin == 0
    axis = 'xyz';
else
    axis = varargin{1};
end

if nargin > 0
    if  ~prod(axis == 'x' | axis == 'y' | axis == 'z') || isempty(axis)
        error('Fisrt input should be ''x'' or ''y'' or ''z'' ');
    end
end

if nargin == 2
    if isa(varargin{2},'double')
        if ~isscalar(varargin{2})
            error('The second input should be a scalar');
        end
        digits = repmat(varargin{2},1,length(varargin{1}));
    elseif isa(varargin{2},'cell')
        if length(varargin{1}) > 1
            error('You can only set one axis');
        end
        TickLabelName = [axis 'ticklabel'];
        set(gca,TickLabelName,varargin{2});
        return;
    else
        error('Second input should be a number or a cell ');
    end
end

if nargin == 3
    if ~isa(varargin{2},'char') || ~isa(varargin{3},'char')
        error('The second and third inputs should be chars');
    end
    for AxisName = axis
        ticklabels = get(gca,[AxisName 'ticklabel']);
        for ii = 1:length(ticklabels)
            if strcmp(varargin{2},ticklabels{ii})
                ticklabels{ii} = varargin{3};
            end
        end
        set(gca,[AxisName 'ticklabel'],ticklabels);
    end
    return;
end

if isempty(digits)
    for AxisName = axis
        maxdigit = 0;
        ticks = get(gca,[AxisName 'tick']);
        for labelnum = ticks
            labelchar = num2str(labelnum);
            if sum(labelchar == '.')
                position = find(labelchar == '.');
                maxdigit = max([maxdigit length(labelchar(position+1:end))]);
            end
        end
        digits = [digits maxdigit];
    end
end

for ii = 1:length(axis)
    AxisName = axis(ii);
    digitnum = digits(ii);
    newlabels = [];
    oldlabels = get(gca,[AxisName 'tick']);
    for label = oldlabels
        labelchar = num2str(label);
        if sum(labelchar == '.')
            position = find(labelchar == '.');
            digitlength = length(labelchar(position+1:end));
        else
            digitlength = 0;
        end      
        if label == 0
            newlabels = [newlabels sprintf('0\n')];
        elseif digitlength <= digitnum
            style = ['%.' num2str(digitnum) 'f\n'];
            newlabels = [newlabels sprintf(style,label)];
        else
            newlabels = [newlabels sprintf('\n')];
        end
    end
    set(gca,[AxisName 'ticklabel'],newlabels);
end

end

