within EVRanger.Functions;

function fHillClimbing
// neglected for now, so output = 0
// Compute hill climbing force: F_hc = m*g*sin(phi)

input Real m;
input Real slope;
input Real g;

output Real F_hc;

algorithm

F_hc := m*g*sin(slope);

end fHillClimbing;
