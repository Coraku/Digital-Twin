within EVRanger.Components;

model Consumer
  Interfaces.ElectricalPort electricalPortin annotation(
    Placement(transformation(origin = {-58, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-58, 0}, extent = {{-10, -10}, {10, 10}})));
    
  parameter Real ampere_pulled = -1000;
equation
  electricalPortin.I = ampere_pulled


annotation(
    Icon(graphics = {Ellipse(origin = {24, -2}, fillColor = {11, 42, 177}, fillPattern = FillPattern.CrossDiag, extent = {{-42, 42}, {42, -42}}), Line(origin = {-38, 0}, points = {{20, 0}, {-12, 0}, {-20, 0}})}));
annotation(
    Icon(graphics = {Ellipse(origin = {33, -10}, fillColor = {13, 17, 238}, fillPattern = FillPattern.CrossDiag, extent = {{-29, 30}, {29, -30}}), Line(origin = {-21, 0}, points = {{-29, 0}, {29, 0}})}));
end Consumer;
