function [ ] = figsave(Filename)
%FIGSAVE 根据设置存储当前绘图为 .fig .eps 等格式。
%        Save the figure to multiple formats your predefined in this
%        function in one step.
%
%   注意：使用此函数在 m 文件中需要设置默认参数。
%   WARNING: the formats you want to save as need to be defined in this
%   function file.
%
%   参数设置可参考 SAVEAS
%   See Also SAVEAS
%

formatset = {'fig','epsc'};

for ii = 1:length(formatset)
    fprintf(['Saving:' Filename '\t' 'Format:' formatset{ii} '\n']);
    saveas(gcf,Filename,formatset{ii});
end
fprintf('Your figure has been successfully saved!!!\n');
end

