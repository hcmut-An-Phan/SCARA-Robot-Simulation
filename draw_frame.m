function draw_frame(handles,position,theta)
P = zeros(3,3);
P(:,1) = position;
P(:,2) = position;
P(:,3) = position;
% Default orientation when theta = 0, R = I*[x_length, y_length, z_length]'
R = [0.2 0   0;
     0   0.2 0;
     0   0   0.25];
% Rotation maxtrix around z axis
Rz = [cos(theta) -sin(theta) 0 ; 
      sin(theta)  cos(theta) 0 ; 
           0            0    1];
% Result orientation
R = R*Rz;
% draw 3 vector of the frame at coordinate P
for i = 1:3
    switch i
        case 1 
            quiver3(handles.axes1,P(1,i),P(2,i),P(3,i),R(1,i),R(2,i),R(3,i),'LineWidth',3,'Color','r');
            hold(handles.axes1,'on');
        case 2
            quiver3(handles.axes1,P(1,i),P(2,i),P(3,i),R(1,i),R(2,i),R(3,i),'LineWidth',3,'Color','g');
        case 3
            quiver3(handles.axes1,P(1,i),P(2,i),P(3,i),R(1,i),R(2,i),R(3,i),'LineWidth',3,'Color','b');
    end
end