function [mean_data, std_data] = process_data(name,column,factor,ylimit,folder,print_pdf,display_name,num_graph)

% find all directories which contain linux result files
dirs=dir(folder);
dirs=dirs([dirs.isdir]);
% iterate through all these directories
% mkdir(name);
for i=1:size(dirs,1)
    % set flag in case a file does not exist for a measurement
    invalid = false;
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
        
    if ~invalid
        h = figure;
        data = importdata(filename, ' ', 1);
        if ((ylimit ~= 0) && (ylimit < min(data.data(:,column))) || ylimit < max(data.data(:,column)))
            yl_t = max(data.data(:,column))*(1/666.666688)
            yl_p = max(data.data(:,column));
        else
            yl_t = ylimit;
            yl_p = max(data.data(:,column));
        end
         % caculate mean
        mean_data = mean(data.data(:,column)*(1/666.666688))
        %calculate standard deviation
        std_data = std(data.data(:,column)*(1/666.666688), 1)
        
        if num_graph > 1
            x_nl = unique(data.data(:,column));
            y_nl = hist(data.data(:,column), x_nl);
            subplot(num_graph,1,1)
            plot(x_nl*(1/666.666688),y_nl/factor','--kx','MarkerEdgeColor','k', 'Displayname', display_name)
            hold on
            plot(mean_data, 0, ':ro', 'Displayname', 'Mean value')
            hold on
            plot(mean_data-std_data, 0, ':go', 'Displayname', 'Standard deviation')
            hold on
            legend('show');
            plot(mean_data+std_data, 0, ':go')
            xlabel('Latency [us]');
        end

        if factor == 1
            ylabel('Occurence')
        else
            ylabel(strcat('Occurence x', int2str(factor)))
        end
        subplot(num_graph,1,2)
        % eliminate overrun errors
        time = find (data.data(1:end-1,2) > data.data(2:end,2));
        if ~isempty(time)
            time(end+1,1)=size(data.data,1);
            for j=1:size(time, 1)-1
                data.data(time(j,1)+1:time(j+1,1),2) = data.data(time(j,1)+1:time(j+1,1),2) + 2^32*j;
            end
        end
        plot((data.data(:,2)-data.data(1,2))*(1/666666688), data.data(:,column)*(1/666.666688),'Color','black','Displayname', display_name)
        hold on
        plot([0 ((data.data(end,2)-data.data(1,2))*(1/666666688))], [mean_data mean_data], 'Color', 'red', 'Displayname', 'Mean value')
        hold on
        ylim([0 yl_t]);
        ylabel('Latency [us]');
        xlabel('Time [s]')
        if num_graph < 2
            legend('show');
        end
%         subplot(3,1,3)
%         plot(data.data(:,column),'Color','red')
%         hold on
%         ylim([0 yl_p]);
%         ylabel('Latency [Clock Cycles]');
%         xlabel('Time [periods]')
        % adjust figure in output pdf
        if print_pdf
            figure_name = strcat(name, '_', dirs(i,1).name);
            set(h, 'Name', figure_name);
            set(h,'PaperOrientation','landscape');
            set(h,'PaperUnits','normalized');
            set(h,'PaperPosition', [0 0 1 1]);
            print(h, '-dpdf', strcat('C:\Users\Nadd\Documents\EI\MA\template-da-0.7\RTOS_Compare_Root\template-da-0.7\inputs\pictures_ch3\',figure_name));
        end
    end
    cd('..');
end