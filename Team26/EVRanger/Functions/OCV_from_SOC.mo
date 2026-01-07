within EVRanger.Functions;

function OCV_from_SOC

  input Real SOC;
  output Real V_oc;
algorithm
  if SOC <= 0 then
    V_oc := 300;
  elseif SOC >= 1 then
    V_oc := 420;
  else
    V_oc := 300 + 120*SOC - 40*SOC*SOC;
  end if;


end OCV_from_SOC;
