function updateProgressBar(data, numTasks, ~)
    persistent progressBars
    if isempty(progressBars)
        progressBars = zeros(2, numTasks);
    end

    % 更新对应任务的进度
    taskId = data(1);
    progressBars(1,taskId) = data(2);
    progressBars(2,taskId) = data(3);

    % 移动光标到进度条区域顶部
    fprintf(repmat('\b', 1, 39*(numTasks)));

    % 生成并显示所有进度条
    progress_names = {'H_CP','H_XP','V_CP','V_XP'};
    for idx = 1:numTasks
        barLength = 20;
        progress = progressBars(:,idx);
        completed = round(progress(1)/progress(2)*barLength);
        remaining = barLength - completed;

        bar = ['[', repmat('=', 1, completed), ...
               repmat(' ', 1, remaining), '] ', ...
               sprintf('%4d/%-4d', progress(1),progress(2))];
        fprintf('%s: %s\n',progress_names{idx}, bar);
    end
end