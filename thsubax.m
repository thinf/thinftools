function axh = thsubax(sub_num_v,sub_num_h,subax)
% thsubax(sub_num_v, sub_num_h)
% generates axes according to previous set subaxes values:
%
sub_x = subax.x; %0.1;    % left border of sub_num_x = 0
sub_y = subax.y; %0.15;   % lower border of sub_num_y = 0
sub_dx = subax.dx; %0.0;   % horizontal increment for next subplot border
sub_dy = subax.dy; %0.20;  % vertical increment for next subplot border
sub_w = subax.w; %0.5;    % subplot width
sub_h = subax.h; %0.195;  % subplot height

axh = axes('Position',...
    [sub_x+(sub_num_h-1)*(sub_w+sub_dx) ...
     sub_y+(sub_num_v-1)*(sub_h+sub_dy) ...
     sub_w sub_h]);
