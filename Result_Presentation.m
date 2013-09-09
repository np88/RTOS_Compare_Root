% Script for result presentation of FreeRTOS/LinuxRT measurements

disp('Comparison of Rhealstone parameters:') 
disp('FreeRTOS: Debug or Release, depending whether it was working or not')
disp('LinuxRT: RAM lock, no custom interrupts, data stored in huge array')
disp('Standard Linux: ')
% Task switching
disp('Task Switching')
disp('FreeRTOS Debug')
process_data('task_switching_results', 3, 1000, 0, '*measurements_cfg6_int_saves*', 1, 'Task switching',2);           
process_data('task_switching_debug', 3, 1000, 0, '*FreeRTOS_start_end*', 1, 'Task switching',2 );
process_data('task_switching_results', 3, 1000, 0, '*measurement_cfg_normal_linux_int*', 0, 'Task switching',2); 
disp('wait....')            
pause         
close all

% Single mutex
disp('Mutex Single: Simply take and release mutex')

process_data('mutex_single', 3, 1000, 0, '*measurements_cfg6_int_saves*', 1, 'Mutex single', 2);
process_data('mutex_single', 3, 1000, 0, '*measurement_cfg_normal_linux_int*', 0, 'Mutex single' ,2);            
process_data('mutex_single', 3, 1, 0, '*FreeRTOS_start_end*', 1, 'Mutex single',2);

disp('wait....')            
pause          
close all

% Mutex shuffling
disp('Mutex Shuffle: Mutex with interfering task')

process_data('mutex_shuffle', 3, 1000, 0, '*measurements_cfg6_int_saves*', 1, 'Mutex shuffle',2);
process_data('mutex_shuffle', 3, 1000, 0, '*measurement_cfg_normal_linux_int*', 0, 'Mutex shuffle',2);            
process_data('mutex_shuffle', 3, 1, 0, '*FreeRTOS_start_end*', 1, 'Mutex shuffle',2);

disp('Measurement error in FreeRTOS') 
disp('wait....')            
pause          
close all

% Signal: Condition variable and binary semaphore
disp('Signal: Condition variable and binary semaphore')

process_data('cond_var_results', 3, 1000, 0, '*measurements_cfg6_int_saves*', 1, 'Condition variable',2);
process_data('cond_var_results', 3, 1000, 0, '*measurement_cfg_normal_linux_int*', 0, 'Condition variable',2);            
process_data('bin_semaphore', 3, 1, 0, '*FreeRTOS_start_end*', 1, 'Binary Semaphore',2);
disp('wait....')            
pause          
close all

% Message Passing Latency
disp('Message Passing Latency')

process_data('message_passing_latency', 3, 1000, 0, '*measurements_cfg6_int_saves*', 1, 'Message passing', 2);
process_data('message_passing_latency', 3, 1000, 0, '*measurement_cfg_normal_linux_int*', 0, 'Message passing', 2);            
process_data('message_passing_latency', 3, 1, 0, '*FreeRTOS_start_end*', 1, 'Message passing', 2);
disp('wait....')            
pause          
close all

% Deadlock Breaking Time
disp('Deadlock breaking time')

process_data('deadlock_results', 3, 1, 0, '*measurements_cfg6_int_saves*', 1, 'Deadlock breaking', 2);
process_data('deadlock_results', 3, 1, 0, '*measurement_cfg_normal_linux_int*', 0, 'Deadlock breaking', 2);            
process_data('deadlock_results', 3, 1, 0, '*FreeRTOS_start_end*', 1, 'Deadlock breaking', 2);

disp('check FreeRTOS algorithm') 
disp('wait....')            
pause          
close all


% Preemption time
disp('Preemption time')

process_data('preemption_time', 3, 1, 0, '*measurements_cfg6_int_saves*', 1, 'Preemption', 2);
process_data('preemption_time', 3, 1, 0, '*measurements_cfg_ramdisk*', 0, 'Preemption', 2);
process_data('preemption_time', 3, 1, 0, '*FreeRTOS_start_end*', 1, 'Preemption', 2);            

disp('Linux normal without Ethernet interrupts') 
disp('Ramdisk') 
disp('wait....')            
pause          
close all


disp('Ethernet load preemption time')

process_data('preemption_time', 3, 1, 0, '*measurements_cfg6_int_saves*', 0, 'Preemption');
process_data('preemption_time_eth', 3, 1, 0, '*measurements_cfg6_int_saves*', 0, 'Preemption with load');

disp('wait....')            
pause  
close all

disp('Semaphore shuffling with ethernet load')
process_data('mutex_shuffle', 3, 1, 0, '*measurements_cfg6_int_saves*', 0, 'Semaphore shuffling');
process_data('mutex_shuffle_eth', 3, 1, 0, '*measurements_cfg6_int_saves*', 0);

disp('wait....')            
pause  
close all

disp('Deadlock with ethernet load')
process_data('deadlock_results', 3, 1, 0, '*measurements_cfg6_int_saves*', 0);
process_data('deadlock_results_eth', 3, 1, 0, '*measurements_cfg6_int_saves*', 0);
process_data('deadlock_results_eth2', 3, 1, 0, '*measurements_cfg6_int_saves*', 0);
process_data('deadlock_results_eth3', 3, 1, 0, '*measurements_cfg6_int_saves*', 0);            

disp('wait....')            
pause  
close all


disp('RAM lock vs. no RAM lock')
process_data('mutex_shuffle', 3, 1000, 0, '*measurements_cfg6_int_saves*', 0);
process_data('mutex_shuffle', 3, 1000, 0, '*measurements_cfg2_linux_printf_release*', 1);

disp('wait....')            
pause  
close all

process_data('deadlock_results', 3, 1000, 0, '*measurements_cfg6_int_saves*', 0);

process_data('deadlock_results', 3, 1000, 0, '*measurements_cfg2_linux_printf_release*', 1);
disp('wait....')            
pause  
close all            
            
process_data('task_switching_results', 3, 1000, 0, '*measurements_cfg6_int_saves*', 0); 
process_data('task_switching_results', 3, 1000, 0, '*measurements_cfg2_linux_printf_release*', 1);
            
disp('wait....')            
pause  
close all       

% Signal Timer
disp('Posix Timer 100us')   
process_Linux_periods('rt_task_posix_results_100us', 0, 100, 30, '*measurements_cfg6_int_saves*')
process_Linux_periods('rt_task_posix_results_100us', 0, 100, 30, '*measurements_cfg2_linux_printf_release*')
process_Linux_periods('rt_task_posix_results_100us', 0, 100, 30, '*measurements_cfg3_linux_printf_release_no_array*')
disp('wait....')            
pause  
close all            
            