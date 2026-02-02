within EVRanger.Components;

package Driver
extends EVRanger.Icons.Driver;
  model MinimalDriver
    import EVRanger.Functions.*;
    import EVRanger.Components.Driver.DriverOperationModeTypes;
    input Interfaces.DistanceSignal distanceSignalIn annotation(
      Placement(visible = true, transformation(origin = {2, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    output Interfaces.VelocitySignal velocitySignal annotation(
      Placement(visible = true, transformation(origin = {118, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
    parameter DriverOperationModeTypes.DriverOperationMode operationMode = DriverOperationModeTypes.DriverOperationMode.Normal;
    parameter Real speed_factor = if operationMode == DriverOperationModeTypes.DriverOperationMode.Normal then 1 else 1.2;
  equation
    velocitySignal.vel = fSpeedLimit(distanceSignalIn.x)*speed_factor;
    annotation(
      Icon(graphics = {Ellipse(origin = {-0.0298526, 0.164625}, extent = {{-59.6203, 59.8636}, {59.6203, -59.8636}}, endAngle = 360), Ellipse(origin = {-26, 20}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Line(origin = {0, -1}, points = {{0, 9}, {0, -9}}), Line(origin = {-0.993283, -25.7958}, points = {{-33.0067, 5.7958}, {-19.0067, -4.2042}, {-13.0067, -6.2042}, {14.9933, -6.2042}, {20.9933, -4.2042}, {32.9933, 5.7958}}), Ellipse(origin = {-32, 24}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-2, 2}, {2, -2}}, endAngle = 360), Ellipse(origin = {22, 24}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-2, 2}, {2, -2}}, endAngle = 360), Ellipse(origin = {28, 20}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Ellipse(origin = {24, 24}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-2, 2}, {2, -2}}, endAngle = 360), Rectangle(origin = {0, -1}, lineThickness = 0.5, extent = {{-88, 89}, {88, -89}})}));
  end MinimalDriver;
  
  package DriverOperationModeTypes
    type DriverOperationMode = enumeration(Normal "Code 00: Normal operation", Speeding "Code 10: Speeding Driver");
  end DriverOperationModeTypes;annotation(
    Documentation(info = "<html><head></head><body><h4 style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><b>Description</b></h4><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><b><br></b></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><!--StartFragment-->The driver represents the link between the speed limit and the actual speed signal provided to the motor controller.<!--EndFragment-->&nbsp;&nbsp;</div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><br></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><b>Subtypes</b></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><br></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">1. The \"Normal\" subtype represents a lawful driver, who drives only as fast as the speed limit allows.</div><!--StartFragment--><!--EndFragment-->

<div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><br></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">2. The \"Speeding\" subtype represents a driver who always tries to get from point A to B as quickly as possible, even if it means breaking the law. The \"Speeding\" subtype drives 20% faster than the speed limit.</div><!--StartFragment--><!--EndFragment-->

</body></html>"));
end Driver;
