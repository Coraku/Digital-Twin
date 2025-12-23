within EVRanger.Components;

model Battery

  import EVRanger.Interfaces.ElectricalPort;

parameter Real E_m = 360 "Nominal Voltage";
  parameter Real R_int = 0.05 "Internal Resistance";
  parameter Real Q_nom = 648000 "Capacity in Coulombs (180Ah * 3600)";
  
  Real SOC(start=1.0, min=0, max=1);
  Real V_t;
  Real I_batt;
  output Real SOC_out;
  
 Interfaces.ElectricalPort electricalPortOut annotation(
    Placement(transformation(origin = {68, 26}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {86, 4}, extent = {{-10, -10}, {10, 10}})));
equation
  I_batt = electricalPortOut.I;
  
  // Terminal Voltage calculation
  V_t = E_m - I_batt * R_int;
  electricalPortOut.V = V_t;
<<<<<<< Updated upstream
=======
 
>>>>>>> Stashed changes

  // SOC logic: must be negative for discharge
  der(SOC) = - I_batt / Q_nom;
  SOC_out = SOC;
  
annotation(
    Icon(graphics = {Rectangle(origin = {1, 0}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-53, 32}, {53, -32}}), Rectangle(origin = {1, 38}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-59, 4}, {59, -4}}), Rectangle(origin = {-35, 45}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-7, 3}, {7, -3}}), Rectangle(origin = {-35, 51}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-3, 1}, {3, -1}}), Rectangle(origin = {35, 45}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-7, 3}, {7, -3}}), Rectangle(origin = {35, 51}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-3, 1}, {3, -1}}), Rectangle( fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 22}, {40, -22}}), Ellipse(origin = {21, 1}, fillPattern = FillPattern.Solid, extent = {{-9, 9}, {9, -9}}), Ellipse(origin = {-23, 1}, fillPattern = FillPattern.Solid, extent = {{-9, 9}, {9, -9}}), Text(origin = {-22, 2}, textColor = {255, 255, 255}, extent = {{-16, 10}, {16, -10}}, textString = "+", textStyle = {TextStyle.Bold}), Text(origin = {22, 3}, textColor = {255, 255, 255}, extent = {{-34, 13}, {34, -13}}, textString = "-", textStyle = {TextStyle.Bold}), Rectangle(origin = {1, -39}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-59, 5}, {59, -5}}), Line(origin = {65, 2}, points = {{-11, 0}, {11, 0}}), Text(origin = {84, -15}, extent = {{-10, 5}, {10, -5}}, textString = "output")}),
 Diagram(graphics));
end Battery;
