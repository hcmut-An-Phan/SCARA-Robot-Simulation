function theta = ikine(x,y,z,yaw)
% test value
%x = -20; y = -600; z = 13.5; yaw = 90;

% Lenght of first two links
a1 = 300; % mm
a2 = 300; % mm
% Solve for theta2
c2 = (x^2 + y^2 - a1^2 - a2^2)/(2*a1*a2);
if (c2^2 > 1)
    errordlg('OUT OF WORK SPACE!','OUT OF WORK SPACE');
    theta = [];
    return
end
s2 = sqrt(1 - c2^2); % +- 2 solutions
% if sin(theta2) = 0 ==> singularity!!
if (s2 < 8e-4)
    errordlg('destination is at a kinematic singularity','Singularity');
    theta = [];
    return;
end
% 2 solutions
theta2_1 = atan2(s2,c2);
theta2_2 = atan2(-s2,c2);
theta2_1_in_range = true;
theta2_2_in_range = true;

if (theta2_1 > 145/180*pi || theta2_1 < -145/180*pi)
    theta2_1_in_range = false;
    if (theta2_2 > 145/180*pi || theta2_2 < -145/180*pi)
        errordlg('Out of workspace','Out of workspace');
        theta = [];
        return;
    end
end
% Solve for theta1
s11 = ((a1 + a2*cos(theta2_1))*y - a2*sin(theta2_1)*x)/(x^2 + y^2);
c11 = ((a1 + a2*cos(theta2_1))*x + a2*sin(theta2_1)*y)/(x^2 + y^2);
theta1_1 = atan2(s11,c11);

s12 = ((a1 + a2*cos(theta2_2))*y - a2*sin(theta2_2)*x)/(x^2 + y^2);
c12 = ((a1 + a2*cos(theta2_2))*x + a2*sin(theta2_2)*y)/(x^2 + y^2);
theta1_2 = atan2(s12,c12);

theta1_1_in_range = true;
theta1_2_in_range = true;

if (theta1_1 > 125/180*pi || theta1_1 < -125/180*pi)
    theta1_1_in_range = false;
    if (theta1_2 > 125/180*pi || theta1_2 < -125/180*pi)
        errordlg('Out of workspace','Out of workspace');
        theta = [];
        return;
    end
end
% Solve for theta3
theta3 = (z - 13.5)/180*pi;
if (theta3 > 150/180*pi || theta3 < 0)
    errordlg('Out of workspace','Out of workspace');
    theta = [];
    return;
end
% Solve for theta4
theta4_1 = yaw/180*pi - theta1_1 - theta2_1;
theta4_2 = yaw/180*pi - theta1_2 - theta2_2;

theta4_1_in_range = true;
theta4_2_in_range = true;

if (theta4_1 > 360/180*pi || theta4_1 < -360/180*pi)
    theta4_1_in_range = true;
    if (theta4_2 > 360/180*pi || theta4_2 < -360/180*pi)
        errordlg('Out of workspace','Out of workspace');
        theta = [];
        return;
    end
end

% return 2 sets of solutions
if (~theta1_1_in_range || ~theta2_1_in_range || ~theta4_1_in_range)
    theta = [theta1_2 theta2_2 theta3 theta4_2]/pi*180;
else 
    theta = [theta1_1 theta2_1 theta3 theta4_1]/pi*180;
end

