function draw_link_2(handles,theta1,theta2,alpha,ref2,varargin)
% Default args
inArgs = { ...
  [0.3 0.12 0.2]             , ... % Default edge sizes (x,y and z)
  [0.45 0 0.179+0.072+0.2/2] , ... % Default coordinates of the origin point of the cube
  [0 0.9 0.9]                , ... % Default Color for the cube
  [0 0 0]                          % Default coordinates of origin of reference frame 1
  };
% Input args
inArgs(1:nargin-5) = varargin;
[edges,origin,color,ref1] = deal(inArgs{:});

x0 = origin(1) - edges(1)/2 - ref1(1);
x1 = origin(1) + edges(1)/2 - ref1(1);
y0 = origin(2) - edges(2)/2 - ref1(2);
y1 = origin(2) + edges(2)/2 - ref1(2);
z0 = origin(3) - edges(3)/2 - ref1(3);
z1 = origin(3) + edges(3)/2 - ref1(3);
% Coordinates of 8 points of cube relative to reference frame 1
H=[x0 x1 x0 x1 x0 x1 x0 x1;
   y0 y0 y1 y1 y0 y0 y1 y1;
   z0 z0 z0 z0 z1 z1 z1 z1];
% Z1 axis rotation matrix
Rz1 = [cos(theta1) -sin(theta1) 0 ; 
       sin(theta1)  cos(theta1) 0 ; 
            0           0       1];
% Calcualte coordiantes of 8 points after rotated link2 around Z1
for j = 1 : size(H,2)
        H(:,j) = Rz1*H(:,j) + ref1' - ref2';       
end
% Z2 axis rotation matrix 
Rz2 = [cos(theta2) -sin(theta2) 0 ; 
       sin(theta2)  cos(theta2) 0 ; 
            0            0      1];
% Calcualte coordiantes of 8 points after rotated link1 around Z2
for j = 1 : size(H,2)
        H(:,j) = Rz2*H(:,j) + ref2';       
end
% Cube's 6 faces
S=[1 2 4 3; 1 2 6 5; 1 3 7 5; 3 4 8 7; 2 4 8 6; 5 6 8 7];
% Draw 6 faces of cube
for k=1:6    
        Si=S(k,:); 
        fill3(handles.axes1,H(1,Si),H(2,Si),H(3,Si),color,'facealpha',alpha,'LineWidth',2)
end