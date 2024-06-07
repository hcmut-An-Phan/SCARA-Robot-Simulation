function draw_base(handles,alpha,varargin)
%% Default args
inArgs = { ...
  [0.21 0.18 0.179]  , ... % Default edge sizes (x,y and z)
  [-0.035 0 0.179/2] , ... % Default coordinates of the origin point of the cube
  [0.75 0.75 0.75]   , ... % Default Color for the cube
  "black"
  };
%% Input args
inArgs(1:nargin-2) = varargin;
[edges,origin,color,EdgeColor] = deal(inArgs{:});
%% define nomalized cube faces
X = [0 0 0 0 0 1; 1 0 1 1 1 1; 1 0 1 1 1 1; 0 0 0 0 0 1];
Y = [0 0 0 0 1 0; 0 1 0 0 1 1; 0 1 1 1 1 1; 0 0 1 1 1 0];
Z = [0 0 1 0 0 0; 0 0 1 0 0 0; 1 1 1 0 1 1; 1 1 1 0 1 1];
%% resize 
X = edges(1)*(X-0.5) + origin(1);
Y = edges(2)*(Y-0.5) + origin(2);
Z = edges(3)*(Z-0.5) + origin(3); 
%% draw cube
fill3(handles.axes1,X,Y,Z,color,'FaceAlpha',alpha,'Linewidth',2,'EdgeColor',EdgeColor);  
hold(handles.axes1,'on');
