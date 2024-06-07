function position_t = end_effector_trajectory(start_point,end_point,velocity_max,toltal_time,time_segment )

% this function is used for x,y,z trajectory 

% start_point = 300;
% end_point = 700;
% velocity_max = 400;
% time_segment = 100;
% toltal_time = 1.5;

if (end_point == start_point)
    position_t = ones(1,time_segment)*start_point;
    return
end

% Constraint
% if (abs(velocity_max) > 2*abs(end_point - start_point)/toltal_time || abs(velocity_max) <= abs(end_point - start_point)/toltal_time)
%     errordlg('choose v_max or a_max again','time out!');
%     return
% end

velocity_max = 1.5*abs(end_point - start_point)/toltal_time; % choose appropriate velocity 

if (end_point < start_point)
    velocity_max = -velocity_max;
end

acceleration_time = (start_point - end_point + velocity_max*toltal_time)/velocity_max;
acceleration_max = velocity_max^2/(start_point - end_point + velocity_max*toltal_time);

time = linspace(0,toltal_time,time_segment);

position_t = zeros(1,time_segment);
velocity_t = zeros(1,time_segment);
accelaeration_t = zeros(1,time_segment);

for i = 1:length(time)
    if (time(i) <= acceleration_time)
        position_t(i) = start_point + 0.5*acceleration_max*time(i)^2;
        velocity_t(i) = acceleration_max*time(i);
        accelaeration_t(i) = acceleration_max;
    elseif (time(i) <= toltal_time - acceleration_time)
        position_t(i) = start_point + acceleration_max*acceleration_time*(time(i) - acceleration_time/2);
        velocity_t(i) = velocity_max;
        accelaeration_t(i) = 0;
    else
        position_t(i) = end_point - 0.5*acceleration_max*(toltal_time - time(i))^2;
        velocity_t(i) = velocity_max - acceleration_max*(time(i) - toltal_time + acceleration_time);
        accelaeration_t(i) = -acceleration_max;
    end
end