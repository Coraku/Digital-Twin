within EVRanger.Functions;

function fSlopeGenerator
  input Real position "Longitudinal position [m]";
  output Real slope "Road slope (rise/run)";
algorithm
  if position < 500 then
    slope := 0.0;              // flat
  elseif position < 1200 then
    slope := 0.05;             // 5% uphill
  elseif position < 2000 then
    slope := -0.03;            // 3% downhill
  else
    slope := 0.0;
  end if;
end fSlopeGenerator;


