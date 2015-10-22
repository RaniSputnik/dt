/// __interpolate(p1, p2)
/// Returns a value between 0 and 1 which corresponds 
/// the value 0.5 between p1 and p2.


var arg_p1 = argument0
var arg_p2 = argument1

if(arg_p2-arg_p1 == 0) return 0.5;

return (0.5-arg_p1)/(arg_p2-arg_p1);
