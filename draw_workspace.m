function draw_workspace(handles,varargin)

nCS= 2; %number of cross sections, default 2 bot and top
%nNodes = 60; % number of nodes, The more nodes, the rounder

inArgs(1:nargin-1) = varargin;
[nNodes,radius,length,origin,alpha,color,t1,t2,EdgeColor] = deal(inArgs{:});

r = radius*ones(1,nNodes);
th = linspace(t1/180*pi,t2/180*pi, nNodes); 
% transform polar cylindrical coordinates to castersian coordiantes
[x,y] = pol2cart(th,r);
% translate to origin
x = x + origin(1);
y = y + origin(2);
z = linspace(origin(3),origin(3)+length,nCS)';
%  Replication
x = repmat(x,nCS,1);
y = repmat(y,nCS,1);
z = repmat(z,1,nNodes);
% bot and top face
%x_lid = zeros(2,nNodes) + origin(1);
%y_lid = zeros(2,nNodes) + origin(2);
%z_lid = repmat([origin(3);origin(3)+length],1,nNodes);

x_lid = zeros(2,nNodes);
y_lid = zeros(2,nNodes);
z_lid = repmat([origin(3);origin(3)+length],1,nNodes);
% append bot and top face to cylinder
x = [x_lid(1,:); x; x_lid(2,:)];
y = [y_lid(1,:); y; y_lid(2,:)];
z = [z_lid(1,:); z; z_lid(2,:)];

%x = [x_lid(1,:); x];
%y = [y_lid(1,:); y];
%z = [z_lid(1,:); z];
% draw cylinder
h = surf(handles.axes1,x,y,z);
h.FaceColor = color;
h.FaceAlpha = alpha;
h.MeshStyle = 'row';
h.LineWidth = 2;
h.EdgeColor = EdgeColor;
hold on

