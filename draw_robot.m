function draw_robot(handles,theta,alpha,frame,workspace,view_)

% convert theta to radian
theta(1) = theta(1)/180*pi;
theta(2) = theta(2)/180*pi;
theta(3) = theta(3)/1000;
theta(4) = theta(4)/180*pi;

p1x = 0.3*cos(theta(1));
p1y = 0.3*sin(theta(1));
p2x = 0.3*(cos(theta(1))+cos(theta(1)+theta(2)));
p2y = 0.3*(sin(theta(1))+sin(theta(1)+theta(2)));

if (workspace == 1)
    show_work_space_2(handles)
end

if (frame(1) == 1)
    draw_frame(handles,[0 0 0.179],theta(1));
end
if (frame(2) == 1)
    draw_frame(handles,[p1x p1y 0.251],theta(1)+theta(2));
end
if (frame(3) == 1)
    draw_frame(handles,[p2x p2y 0.251],theta(1)+theta(2)+theta(4));
end
if (frame(4) == 1)
    draw_frame(handles,[p2x p2y 0.1635+theta(3)],theta(1)+theta(2)+theta(4));
end
if (frame(5) == 1)
    draw_end_effector_frame(handles,[p2x p2y 0.0135+theta(3)],theta(1)+theta(2)+theta(4));
end
% draw base
draw_base(handles,alpha) 
draw_link_1(handles,theta(1),alpha)
% draw_link_2(theta1, theta2, alpha, ref2)
draw_link_2(handles,theta(1),theta(2),alpha,[p1x p1y 0.251])
%% draw_joint(radius, length origin, alpha, color, theta)
% joint_1
draw_joint(handles,0.06,0.072,[0 0 0.179],alpha,[0 0 0.7],theta(1))
% joint_2_bot
draw_joint(handles,0.06,0.072,[p1x p1y 0.179],alpha,[0 0 0.7],theta(1)+pi)
% joint_2_top
draw_joint(handles,0.06,0.2  ,[p1x p1y 0.251],alpha,[0 0.9 0.9],theta(1)+theta(2))
%joint_4
draw_joint(handles,0.06,0.2  ,[p2x p2y 0.251],alpha,[0 0.9 0.9],theta(1)+theta(2)+pi)
% draw_link3(radius, length, origin, alpha, color, theta)
draw_link_3(handles,0.012,0.5 ,[p2x p2y 0.0135],alpha,[1 0 1],theta(3))
% draw_end_effector(origin,alpha,theta)
draw_end_effector(handles,[p2x p2y 0.0335+theta(3)],alpha,theta(4));

lt1 = light(handles.axes1,Position=[0.3 -0.5 1],Style="local");
lt2 = light(handles.axes1,Position=[0.3 0.5 1],Style="local");
lt3 = light(handles.axes1,Position=[0.3 -0.5 0],Style="local");
lt4 = light(handles.axes1,Position=[0.3 0.5 0],Style="local");

axis(handles.axes1,[-0.7 0.7 -0.7 0.7 0 0.7]) 
grid(handles.axes1,'on')
rotate3d(handles.axes1,'on')
view(handles.axes1,view_)
xlabel(handles.axes1,'X(m)'), ylabel(handles.axes1,'Y(m)'), zlabel(handles.axes1,'Z(m)')
hold(handles.axes1,'off');

