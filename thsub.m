function thsub(sub_num,sub_num_h)
% thsub(sub_num_v, sub_num_h)
% generates subplot according to previous set subplot values:
%
% sub_x = 0.1;    % left border of sub_num_x = 0
% sub_y = 0.15;   % lower border of sub_num_y = 0
% sub_dx = 0.0;   % horizontal increment for next subplot border
% sub_dy = 0.20;  % vertical increment for next subplot border
% sub_w = 0.5;    % subplot width
% sub_h = 0.195;  % subplot height

subplot('Position',[sub_x+sub_num_h* sub_y+sub_num*sub_dy sub_w sub_h])
