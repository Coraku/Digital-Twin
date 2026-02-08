within EVRanger.Components;

package Driver
extends EVRanger.Icons.Driver;
  model MinimalDriver
  // The Driver Model links the local maximal velocity (dependent on the current position) with the Motor Controller
    import EVRanger.Functions.*;
    import EVRanger.Components.Driver.DriverOperationModeTypes;
    input Interfaces.DistanceSignal distanceSignalIn annotation(
      Placement(visible = true, transformation(origin = {2, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    output Interfaces.VelocitySignal velocitySignal annotation(
      Placement(visible = true, transformation(origin = {118, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // The DriverOperationModeTypes differentiate between a Normal driver, following the maximal legal velocity, and a speeding one
    parameter DriverOperationModeTypes.DriverOperationMode operationMode = DriverOperationModeTypes.DriverOperationMode.Normal;
    // the speed_factor represents how much the Driver is speeding. A value of 1 represents a Driver driving at the legal speed limit
    parameter Real speed_factor = if operationMode == DriverOperationModeTypes.DriverOperationMode.Normal then 1 else 1.2;
  equation
    velocitySignal.vel = fSpeedLimit(distanceSignalIn.x)*speed_factor;
    annotation(
      Icon(graphics = {Ellipse(origin = {-0.0298526, 0.164625}, extent = {{-59.6203, 59.8636}, {59.6203, -59.8636}}, endAngle = 360), Ellipse(origin = {-26, 20}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Line(origin = {0, -1}, points = {{0, 9}, {0, -9}}), Line(origin = {-0.993283, -25.7958}, points = {{-33.0067, 5.7958}, {-19.0067, -4.2042}, {-13.0067, -6.2042}, {14.9933, -6.2042}, {20.9933, -4.2042}, {32.9933, 5.7958}}), Ellipse(origin = {-32, 24}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-2, 2}, {2, -2}}, endAngle = 360), Ellipse(origin = {22, 24}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-2, 2}, {2, -2}}, endAngle = 360), Ellipse(origin = {28, 20}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Ellipse(origin = {24, 24}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-2, 2}, {2, -2}}, endAngle = 360), Rectangle(origin = {0, -1}, lineThickness = 0.5, extent = {{-88, 89}, {88, -89}})}),
  Documentation(info = "<html><head></head><body><p style=\"font-size: 12px;\"><strong><u>Information</u></strong></p><div class=\"textDoc\"><p style=\"font-family: 'Courier New'; font-size: 12px;\"></p></div><div class=\"htmlDoc\" style=\"font-family: 'MS Shell Dlg 2';\"><h4><b>Description</b></h4><h4><div style=\"font-weight: normal;\"><b><br></b></div><div style=\"font-weight: normal;\"><!--StartFragment-->This model represents the driver. The driver observes the maximum legal velocity and decides, depending on its mode, whether the car should drive at the limit or above/below it. This signal is passed to the motor controller, which drives the motor accordingly. Since the driver is not the focus of the model, it is less complex than the other major elements and is therefore called<em data-start=\"118\" data-end=\"135\" style=\"font-family: -webkit-standard;\">&nbsp;MinimalDriver</em>.<!--EndFragment-->&nbsp;&nbsp;</div><div style=\"font-weight: normal;\"><br></div><div style=\"font-weight: normal;\"><br></div><div style=\"font-weight: normal;\"><b>Process</b></div><div style=\"font-weight: normal;\"><b><br><br></b></div><div style=\"font-weight: normal;\"><!--StartFragment-->The driver uses the current legal velocity, which it obtains from the function&nbsp;<em data-start=\"118\" data-end=\"135\" style=\"font-family: -webkit-standard;\">fSpeedLimit</em>, and multiplies it by&nbsp;<em data-start=\"118\" data-end=\"135\" style=\"font-family: -webkit-standard;\">speed_factor</em>, a variable that depends on the type of driver. A “Normal” driver uses a speed factor of 1, meaning it follows the legal speed limit exactly. A “Speeding” driver always drives 20% faster than the legal speed limit.<!--EndFragment-->

</div><div style=\"font-weight: normal;\"><b><br></b></div><div style=\"font-weight: normal;\"><b><br></b></div><div style=\"font-weight: normal;\">The Driver uses the current legal velocity, which it gets from the function&nbsp;<em data-start=\"118\" data-end=\"135\" style=\"font-family: -webkit-standard;\">fSpeedLimit</em>, and multiplies it with&nbsp;<em data-start=\"118\" data-end=\"135\" style=\"font-family: -webkit-standard;\">speed_factor</em>, a variable dependent on the type of the Driver. A \"Normal\" Driver will drive with a speed factor of 1, which means it follows the legal speed limit exactly. A \"Speeding\" Driver will allways be 20% faster than the legal speed limit.&nbsp;</div></h4></div></body></html>"));
  end MinimalDriver;
  
  package DriverOperationModeTypes
    type DriverOperationMode = enumeration(Normal "Code 00: Normal operation", Speeding "Code 10: Speeding Driver");
  end DriverOperationModeTypes;annotation(
    Documentation(info = "<html><head></head><body><h4 style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><b>Description</b></h4><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><b><br></b></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><!--StartFragment-->The driver represents the link between the speed limit and the actual speed signal provided to the motor controller.<!--EndFragment-->&nbsp;&nbsp;</div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><br></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><b>Subtypes</b></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><br></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">1. The \"Normal\" subtype represents a lawful driver, who drives only as fast as the speed limit allows.</div><!--StartFragment--><!--EndFragment-->

<div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><br></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">2. The \"Speeding\" subtype represents a driver who always tries to get from point A to B as quickly as possible, even if it means breaking the law. The \"Speeding\" subtype drives 20% faster than the speed limit.</div><!--StartFragment--><!--EndFragment-->

</body></html>"));
end Driver;
