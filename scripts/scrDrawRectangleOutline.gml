///scrDrawRectangleOutline(x1,y1,x2,y2,color,alpha)

var alpha = draw_get_alpha();
var color = draw_get_color();

draw_set_color(argument4);
draw_set_alpha(argument5);

draw_rectangle(argument0,argument1,argument2,argument3,1);

draw_set_alpha(alpha);
draw_set_color(color);
