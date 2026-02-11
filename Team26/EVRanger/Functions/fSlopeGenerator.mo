within EVRanger.Functions;

function fSlopeGenerator
  input Real position "Longitudinal position [m]";
  output Real slope "Road slope (rise/run) [rad]";
algorithm

  if position < 50000 then
    slope := 0.01;
  else
    slope := 0.00;
  end if;

annotation(
    Documentation(info = "<html><head></head><body></body></html>"));
end fSlopeGenerator;
