function [position_t, velocity_t, accelaeration_t, path_length, toltal_time, time] = Trajectory(start_point,end_point,velocity_max,acceleration_max,time_segment)

% this function is used for Tool Trajectory Planning

%% test value
% start_point = [1 4 2];
% end_point = [5 2 5];
% velocity_max = 4;
% acceleration_max = 8;
%%

% the lenght of path in 3d space
path_length = sqrt( (end_point(1) - start_point(1))^2 + ...
                    (end_point(2) - start_point(2))^2 + ...
                    (end_point(3) - start_point(3))^2 );

acceleration_time = velocity_max/acceleration_max;
toltal_time = path_length/velocity_max + acceleration_time;

% Constraint 
if (toltal_time < 2*acceleration_time)
    errordlg('total time is less than acceleration_time','time out!');
    return
end

% Time line
time = linspace(0,toltal_time,time_segment);

% Generate Trajectory
position_t = zeros(1,time_segment);
velocity_t = zeros(1,time_segment);
accelaeration_t = zeros(1,time_segment);

for i = 1:length(time)
    if (time(i) <= acceleration_time)
        position_t(i) = 0.5*acceleration_max*time(i)^2;
        velocity_t(i) = acceleration_max*time(i);
        accelaeration_t(i) = acceleration_max;
    elseif (time(i) <= toltal_time - acceleration_time)
        position_t(i) = acceleration_max*acceleration_time*(time(i) - acceleration_time/2);
        velocity_t(i) = velocity_max;
        accelaeration_t(i) = 0;
    else
        position_t(i) = path_length - 0.5*acceleration_max*(toltal_time - time(i))^2;
        velocity_t(i) = velocity_max - acceleration_max*(time(i) - toltal_time + acceleration_time);
        accelaeration_t(i) = -acceleration_max;
    end
end