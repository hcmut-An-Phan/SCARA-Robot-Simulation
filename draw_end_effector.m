function draw_end_effector(handles,origin,alpha,theta)        
%% Coordiantes of 8 points
H=[-0.03  0.03 -0.03  0.03 -0.03  0.03 -0.03 0.03;
   -0.02 -0.02  0.02  0.02 -0.02 -0.02  0.02 0.02;
   -0.02 -0.02 -0.02 -0.02  0     0     0    0  ];
%% Z4 axis rotate matrix
Rz4 = [cos(theta) -sin(theta) 0 ; 
       sin(theta)  cos(theta) 0 ; 
            0           0     1];
%% points after rotated
for j = 1:size(H,2)
        H(:,j) = Rz4*H(:,j) + origin';       
end
%% 6 faces of cube
S=[1 2 4 3; 1 2 6 5; 1 3 7 5; 3 4 8 7; 2 4 8 6; 5 6 8 7];
%% draw 6 faces of cube
for k=1:6    
        Si=S(k,:); 
        fill3(handles.axes1,H(1,Si),H(2,Si),H(3,Si),[1 0 1],'facealpha',alpha,'LineWidth',1.5)
end
