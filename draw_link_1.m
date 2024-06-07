function draw_link_1(handles,theta1,alpha,varargin)
% Default args
inArgs = { ...
  [0.3 0.12 0.072]       , ... % Default edge sizes (x,y and z)
  [0.15 0 0.179+0.072/2] , ... % Default coordinates of the origin point of the cube
  [0 0 0]                , ... % Default coordinates of the origin point of reference frame1
  [0 0 0.7]              , ... % Default Color for the cube
  };
% Input args
inArgs(1:nargin-3) = varargin;
[edges,origin,ref,color] = deal(inArgs{:});

x0 = origin(1) - edges(1)/2 - ref(1);
x1 = origin(1) + edges(1)/2 - ref(1);
y0 = origin(2) - edges(2)/2 - ref(2);
y1 = origin(2) + edges(2)/2 - ref(2);
z0 = origin(3) - edges(3)/2 - ref(3);
z1 = origin(3) + edges(3)/2 - ref(3);
% coordinates of 8 points of cube ralative to reference frame 1
H=[x0 x1 x0 x1 x0 x1 x0 x1;
   y0 y0 y1 y1 y0 y0 y1 y1;
   z0 z0 z0 z0 z1 z1 z1 z1];
% Z1 axis rotation matrix 
Rz1 = [cos(theta1) -sin(theta1) 0 ; 
       sin(theta1)  cos(theta1) 0 ; 
           0            0       1];
% Calcualte coordiantes of 8 points after rotated link1 around Z1
for j = 1 : size(H,2)
        H(:,j) = Rz1*H(:,j) + ref';       
end
% Cube's 6 faces
S=[1 2 4 3; 1 2 6 5; 1 3 7 5; 3 4 8 7; 2 4 8 6; 5 6 8 7];
% Draw 6 faces of cube
for k=1:6    
        Si=S(k,:); 
        fill3(handles.axes1,H(1,Si),H(2,Si),H(3,Si),color,'facealpha',alpha,'LineWidth',2)
end
