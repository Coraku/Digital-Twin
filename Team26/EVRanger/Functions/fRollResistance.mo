within EVRanger.Functions;

function fRollResistance
// Compute rolling resistance force: F_rr = mu_rr*m*g

input Real m;
input Real g;
input Real mu_rr "rolling resistance coefficient";

output Real F_rr;

algorithm

F_rr := mu_rr*m*g;

end fRollResistance;
