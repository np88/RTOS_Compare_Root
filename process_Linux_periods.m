function process_Linux_periods(name, ylimit, reference, ymin, folder)

% find all directories which contain linux result files
dirs=dir(folder);
dirs=dirs([dirs.isdir]);
% iterate through all these directories
mkdir(name);
for i=1:size(dirs,1)
    % set flag in case a file does not exist for a measurement
    invalid = false;
    load = true;
    % find file of interest:
    % all files of current directory
    cd(dirs(i,1).name);
    if exist(strcat(name,'.log'),'file')
        filename = strcat(name,'.log');
    elseif exist(strcat(name,'.txt'),'file')
        filename = strcat(name,'.txt');
    else
        invalid = true;
    end;
    
    if exist(strcat(name,'_load','.log'),'file')
        loadname = strcat(name,'_load','.log');
    elseif exist(strcat(name,'_load','.txt'),'file')
        loadname = strcat(name,'_load','.txt');
    else
        load = false;
    end;
        
    if ~invalid
        figure_name = (strcat('f',num2str(i)));
        eval(figure_name) = figure('Name', strcat(name, '_', dirs(i,1).name));
        data = importdata(filename, ' ', 1);
        if ((ylimit ~= 0) && (ylimit < min(data.data(:)*1/666.666688)) || ylimit < max(data.data(:)*1/666.666688))
            yl = max(data.data(:))*1/666.666688
        else
            yl = ylimit
        end
        x_nl = unique(data.data(:));
        y_nl = hist(data.data(:), x_nl);
        subplot(3,1,1)
        plot(x_nl*1/666.666688,y_nl','--go','MarkerEdgeColor','g', 'Displayname', strcat(name, i))
        hold on
        plot(reference, 0, '--ro')
        xlabel('Latency [us]');
        ylabel('Occurence')
        subplot(3,1,2)
        plot(data.data(:)*1/666.666688,'Color','green')
        hold on
        plot([0 size(data.data, 1)], [reference reference], 'Color', 'red')
        ylim([ymin yl]);
        ylabel('Latency [us]');
        xlabel('Time [periods]');
        %print(eval(figure_name), strcat(name, '_', dirs(i,1).name), '-dpdf')
        if load
            loaddata=importdata(loadname, ' ', 1);
            subplot(3,1,3)
            plot(loaddata.data(:)*(1/666.666688),'Color','green')
            hold on
            plot([0 size(loaddata.data, 1)], [reference reference], 'Color', 'red')
            ylim([ymin yl]);
            ylabel('Latency [Clock Cycles]');
            xlabel('Time [periods]')
        end
    end
    cd('..');
end