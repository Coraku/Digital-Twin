within EVRanger.Functions;

function fFrictionGenerator
input Real position "distance traveled [m]";
output Real friction "friction coefficient";
algorithm
friction := 0.0048;

// For future modifications: here a more complex friction function can be implemented
end fFrictionGenerator;
