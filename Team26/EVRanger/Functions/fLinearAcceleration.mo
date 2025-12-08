within EVRanger.Functions;

function fLinearAcceleration
"Compute linear acceleration force: F_la = m * a"

input Real m;
input Real a;

output Real F_la;

algorithm
F_la := m * a;

end fLinearAcceleration;
