function draw_joint(handles,varargin)
% Get input args
inArgs(1:nargin-1) = varargin;
[radius,length,origin,alpha,color,theta] = deal(inArgs{:});

nCS= 2; %number of cross sections, default 2 bot and top
nNodes = 30; % number of nodes, The more nodes, the rounder

r = radius * ones(1,nNodes);
th = linspace(pi/2 + theta, 1.5*pi + theta, nNodes); % draw a half circle
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
x_lid = zeros(2,nNodes) + origin(1);
y_lid = zeros(2,nNodes) + origin(2);
z_lid = repmat([origin(3);origin(3)+length],1,nNodes);
% append bot and top face to cylinder
x = [x_lid(1,:); x; x_lid(2,:)];
y = [y_lid(1,:); y; y_lid(2,:)];
z = [z_lid(1,:); z; z_lid(2,:)];
% draw cylinder
h = surf(handles.axes1,x,y,z);
h.FaceColor = color;
h.FaceAlpha = alpha;
h.MeshStyle = 'row';
h.LineWidth = 2;
