within EVRanger.Functions;

function fLinearAcceleration
//Compute linear acceleration force: F_la = m * a

input Real m;
input Real a;

output Real F_la;

algorithm
F_la := m * a;

annotation(
    Documentation(info = "<html><head></head><body><!--StartFragment--><p data-start=\"66\" data-end=\"107\"><strong data-start=\"66\" data-end=\"107\">Linear Acceleration Force Calculation</strong></p>
<p data-start=\"109\" data-end=\"376\">This function computes the force required to linearly accelerate a vehicle based on its mass and acceleration.</p>
<p data-start=\"378\" data-end=\"390\"><strong data-start=\"378\" data-end=\"390\">Equation</strong></p><p data-start=\"378\" data-end=\"390\"><span data-start=\"378\" data-end=\"390\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span><i>F<sub>la</sub> = m*a</i></span></p><p data-start=\"418\" data-end=\"427\"><strong data-start=\"418\" data-end=\"427\">Input</strong></p>
<ul data-start=\"429\" data-end=\"498\">
<li data-start=\"429\" data-end=\"459\">
<p data-start=\"431\" data-end=\"459\"><span data-start=\"431\" data-end=\"436\">m</span>: vehicle mass [kg]</p>
</li>
<li data-start=\"460\" data-end=\"498\">
<p data-start=\"462\" data-end=\"498\">a: vehicle acceleration [m/s<sup>2</sup>]</p>
</li>
</ul>
<p data-start=\"500\" data-end=\"510\"><strong data-start=\"500\" data-end=\"510\">Output</strong></p>
<ul data-start=\"512\" data-end=\"554\">
<li data-start=\"512\" data-end=\"554\">
<p data-start=\"514\" data-end=\"554\">F<sub>la</sub>: linear acceleration force [N]</p></li></ul><!--EndFragment--></body></html>"));
end fLinearAcceleration;
