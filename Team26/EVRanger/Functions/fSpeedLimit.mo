within EVRanger.Functions;

function fSpeedLimit
input Real position "distance traveled [m]";
output Real speed_limit "max legal velocity [m/s]";

algorithm
speed_limit := if position < 20000 then
50/3.6
else if position < 50000 then
100/3.6
else
120/3.6;
// The numerator represents the max velocity in km/h

end fSpeedLimit;
