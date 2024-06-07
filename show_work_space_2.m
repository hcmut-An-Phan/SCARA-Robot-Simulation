function show_work_space_2(handles)
alpha = 0.3;
clr = [1 0 1];

draw_workspace(handles,60,0.6,0.15,[0 0 0.0135],alpha,clr,-125,125,"black")
hold(handles.axes1,'on');
draw_workspace(handles,60,0.3,0.15, ...
    [0.3*cos(125/180*pi) 0.3*sin(125/180*pi) 0.0135],alpha, ...
    clr,125,125+110,"black")

draw_workspace(handles,60,0.3,0.15, ...
    [0.3*cos(-125/180*pi) 0.3*sin(-125/180*pi) 0.0135], ...
    alpha,clr,-125,-125-110,"black")

r = 0.3*sin(35/180*pi)/sin(145/360*pi);
draw_workspace(handles,60,r,0.15, ...
    [0 0 0.014],1,[1 1 1],0,360,"black")


    