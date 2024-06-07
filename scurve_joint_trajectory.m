function [position_t, velocity_t, accelaeration_t, v_max, a_max, time] = scurve_joint_trajectory(start_point,end_point,velocity_max,toltal_time,time_segment,joint_id)
% this function is used for Joint Trajectory Planing 

%% Test value
% start_point = 90;
% end_point = 50;
% velocity_max = 30;
% time_segment = 100;
% toltal_time = 2;
% joint_id = 1;
%% 

% If there is no movement of joints
if (end_point == start_point)
    position_t = ones(1,time_segment)*start_point;
    velocity_t = zeros(1,time_segment);
    accelaeration_t = zeros(1,time_segment);
    v_max = 0;
    a_max = 0;
    time = linspace(0,toltal_time,time_segment); 
    return
end

if (end_point < start_point)
    velocity_max = -velocity_max;
end

v_max = velocity_max;

% Constraint of v max
v_limit = abs(end_point - start_point)/toltal_time;

if (abs(velocity_max) > 2*v_limit || abs(velocity_max) <= v_limit)
    switch joint_id
        case 1
            msg = sprintf('choose v1_max in range %.2f to %.2f', v_limit, 2*v_limit);
            errordlg(msg,'time out!','\fontsize{100} text');
        case 2
            msg = sprintf('choose v2_max in range %.2f to %.2f', v_limit, 2*v_limit);
            errordlg(msg,'time out!','\fontsize{20} text');
        case 3
            msg = sprintf('choose v3_max in range %.2f to %.2f', v_limit, 2*v_limit);
            errordlg(msg,'time out!','\fontsize{20} text');
        case 4
            msg = sprintf('choose v4_max in range %.2f - %.2f', v_limit, 2*v_limit);
            errordlg(msg,'time out!','\fontsize{20} text');
    end
    return
end

% Calculate acceleration_time and acceleration_max
acceleration_time = (start_point - end_point + velocity_max*toltal_time)/(2*velocity_max);
acceleration_max = (2*velocity_max^2)/(start_point - end_point + velocity_max*toltal_time);
a_max = acceleration_max;
K = acceleration_max/acceleration_time;
% time line
time = linspace(0,toltal_time,time_segment);

% Generate Trajectory
position_t = zeros(1,time_segment);
velocity_t = zeros(1,time_segment);
accelaeration_t = zeros(1,time_segment);

for i = 1:length(time)
    if (time(i) <= acceleration_time)
    position_t(i) = start_point + (1/6)*K*time(i)^3;
    velocity_t(i) = (1/2)*K*time(i)^2;
    accelaeration_t(i) = K*time(i);
    elseif ((acceleration_time < time(i)) && (time(i) <= 2*acceleration_time))
    position_t(i) = start_point + (-1/6)*K*(time(i) - 2*acceleration_time)^3 + K*acceleration_time^2*time(i) - K*acceleration_time^3;
    velocity_t(i) = (-1/2)*K*(time(i) - 2*acceleration_time)^2 + K*acceleration_time^2;
    accelaeration_t(i) =  -K*(time(i) - 2*acceleration_time);
    elseif ((2*acceleration_time < time(i)) && (time(i) <= toltal_time - 2*acceleration_time))
    position_t(i) = start_point + K*acceleration_time^2*time(i) - K*acceleration_time^3;
    velocity_t(i) = K*acceleration_time^2;
    accelaeration_t(i) =  0;
    elseif ((toltal_time - 2*acceleration_time < time(i)) && (time(i) <= toltal_time - acceleration_time))
    position_t(i) = start_point + (-1/6)*K*(time(i) - (toltal_time - 2*acceleration_time))^3 + K*acceleration_time^2*time(i) - K*acceleration_time^3;
    velocity_t(i) = (-1/2)*K*(time(i) - (toltal_time - 2*acceleration_time))^2 + K*acceleration_time^2;
    accelaeration_t(i) =  -K*(time(i) - (toltal_time - 2*acceleration_time));
    else 
    position_t(i) = start_point + (1/6)*K*(time(i) - toltal_time)^3 - 2*K*acceleration_time^3 + K*acceleration_time^2*toltal_time;
    velocity_t(i) = (1/2)*K*(time(i) - toltal_time)^2;
    accelaeration_t(i) =  K*(time(i) - toltal_time);
    end
end

%% Test graph
% subplot(3,1,1)
% plot(time,position_t,'LineWidth',2), grid on
% subplot(3,1,2)
% plot(time,velocity_t,'LineWidth',2), grid on
% subplot(3,1,3)
% plot(time,accelaeration_t,'LineWidth',2), grid on
%%