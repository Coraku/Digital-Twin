within EVRanger.Functions;

function fRollResistance
// Compute rolling resistance force: F_rr = mu_rr*m*g

input Real m;
input Real g;
input Real mu_rr "rolling resistance coefficient";
input Real vel;

output Real F_rr;

algorithm

if vel <= 0.0001 then
F_rr := 0;
else
F_rr := mu_rr*m*g;
end if;

end fRollResistance;
