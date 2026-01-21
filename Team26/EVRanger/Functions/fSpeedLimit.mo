within EVRanger.Functions;

function fSpeedLimit
input Real position;
output Real speed_limit;

algorithm
speed_limit := if position < 5000 then
50/3.6
else if position < 25000 then
100/3.6
else
120/3.6;
// TODO: implement real formula

end fSpeedLimit;
