function J = JacobianMatrix(theta1,theta2,theta3,theta4)

a     = [0.3          0.3      0                  0   ];
%alpha = [0            0        0                  pi  ];
d     = [0.072+0.179  0      (-0.0875 + theta3)  -0.15];
%theta = [theta1       theta2   0                  theta4];

J = [-d(1)-d(3)-d(4)                           -a(2)*sin(theta1+theta2) 0 0
      a(1)*cos(theta1)+a(2)*cos(theta1+theta2)  a(2)*cos(theta1+theta2) 0 0
      0                                         0                       1 0
      0                                         0                       0 0
      0                                         0                       0 0
      1                                         1                       0 1];

