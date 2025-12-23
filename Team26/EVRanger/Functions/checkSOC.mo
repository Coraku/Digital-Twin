within EVRanger.Functions;

function checkSOC


input Real SOC;
input Real I_batt;
input Real E_m;
input Real R_int;


output Real V_t;

algorithm

  if SOC > 0 then
    // Normal operation
    V_t := E_m - I_batt * R_int;
    
  else
    // Battery is dead
    V_t := 0;
    //der(SOC) = 0;
  end if;

end checkSOC;
