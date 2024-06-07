function [x,y,z,yaw] = fkine(theta1,theta2,theta3,theta4)
% Convert to deg -> rad, mm -> m
theta1 = theta1/180*pi;
theta2 = theta2/180*pi;
theta3 = theta3/1000;
theta4 = theta4/180*pi;
% DH parameters
a     = [0.3   0.3    0                  0   ];
alpha = [0     0      0                  pi  ];
d     = [0.072 0    (-0.0875 + theta3)  -0.15];
theta = [theta1 theta2 0 theta4];
% Calculate DH matrixs
A01 = DHMatrix(a(1), alpha(1), d(1), theta(1));
A12 = DHMatrix(a(2), alpha(2), d(2), theta(2));
A23 = DHMatrix(a(3), alpha(3), d(3), theta(3));
A34 = DHMatrix(a(4), alpha(4), d(4), theta(4));

A04 = A01*A12*A23*A34;
% converts m -> mm, rad -> deg
x = A04(1,4)*1000;
y = A04(2,4)*1000;
z = A04(3,4)*1000 + 179;
yaw = (theta1 + theta2 + theta4)/pi*180;

end
                                                                              
