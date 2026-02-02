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
rollingResistanceSignal.mu_rr = 0.0048;

annotation(
    Icon(graphics = {Rectangle(fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 40}, {100, -40}}), Rectangle(origin = {-60, 0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}}), Rectangle(fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}}), Rectangle(origin = {60, 0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}})}, coordinateSystem(extent = {{-100, 40}, {100, -40}})),
  Documentation(info = "<html><head></head><body><h4><b>Description</b></h4><h4><div style=\"font-weight: normal;\"><b><br></b></div><div style=\"font-weight: normal;\">This model represents a simple Road, consisting of the slope and the friction across the length. For simplicity reasons, the Road can be seen as infinitely long. The Variables passed from the Environment to the Dynamics Model of the Vehicle are crucial to determine the correct counterforce.</div><div style=\"font-weight: normal;\"><br></div><div style=\"font-weight: normal;\"><br></div><div style=\"font-weight: normal;\"><b>Process</b></div><div style=\"font-weight: normal;\"><b><br><br></b></div><div style=\"font-weight: normal;\">Both the Slope and the friction are calculated by separat functions, the fSlopeGenerator-Function and the fFrictionGenerator-Function.</div></h4><div><br></div></body></html>"));
end Environment;
