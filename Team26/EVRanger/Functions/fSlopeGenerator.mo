within EVRanger.Functions;

function fSlopeGenerator
  input Real position "Longitudinal position [m]";
  output Real slope "Road slope (rise/run)";
algorithm
  /*if position < 5000 then
    slope := 0.0;              // flat
  elseif position < 10000 then
    slope := 0.02;             // 2% uphill
  elseif position < 11000 then
    slope := 0.08;            // 8% uphill
  elseif position < 20000 then
    slope := 0.01;
  else */
  if position < 50000 then
    slope := 0.01;
  else
    slope := 0.00;
  end if;
  //end if;
end fSlopeGenerator;


