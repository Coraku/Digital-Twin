within EVRanger.Components;

model Environment
       // Here we will calculate the Slope and legal velocity Limit
  import EVRanger.Functions.*;
  // in Km/h, Govermentaly enforced Speed Limit
  input EVRanger.Interfaces.DistanceSignal distanceSignalIn annotation(
    Placement(visible = true,transformation(origin = {2, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  output EVRanger.Interfaces.SlopeSignal slopeSignal annotation(
    Placement(visible = true,transformation(origin = {-116, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output EVRanger.Interfaces.RollingResistanceSignal rollingResistanceSignal annotation(
    Placement(visible = true, transformation(origin = {100, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

slopeSignal.slope = fSlopeGenerator(distanceSignalIn.x);
rollingResistanceSignal.mu_rr = fFrictionGenerator(distanceSignalIn.x);

annotation(
    Icon(graphics = {Rectangle(fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 40}, {100, -40}}), Rectangle(origin = {-60, 0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}}), Rectangle(fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}}), Rectangle(origin = {60, 0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}})}, coordinateSystem(extent = {{-100, 40}, {100, -40}})),
  Documentation(info = "<html><head></head><body><h4><b>Description</b></h4><h4><div style=\"font-weight: normal;\"><b><br></b></div><div style=\"font-weight: normal;\"><!--StartFragment-->This model represents a simple road, consisting of slope and friction along its length. For simplicity, the road is assumed to be infinitely long. The variables passed from the environment to the vehicle dynamics model are crucial for determining the correct counterforce.<!--EndFragment-->&nbsp;&nbsp;</div><div style=\"font-weight: normal;\"><br></div><div style=\"font-weight: normal;\"><br></div><div style=\"font-weight: normal;\"><b>Process</b></div><div style=\"font-weight: normal;\"><b><br><br></b></div><div style=\"font-weight: normal;\"><!--StartFragment-->Both the slope and the friction are calculated by separate functions: the <em data-start=\"118\" data-end=\"135\">fSlopeGenerator</em> function and the <em data-start=\"153\" data-end=\"173\">fFrictionGenerator</em> function.<!--EndFragment-->&nbsp;&nbsp;</div></h4><div><br></div></body></html>"));
end Environment;
