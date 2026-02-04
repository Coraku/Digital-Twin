within EVRanger.Interfaces;

connector AmbientTemperatureSignal
  Real T_amb "Ambient temperature (°C)";
  annotation(
    Icon(graphics = {Ellipse(origin = {-2, 2}, lineColor = {255, 255, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-94, 94}, {94, -94}}), Text(origin = {-13, 5}, extent = {{-117, 71}, {117, -71}}, textString = "°C")}));
end AmbientTemperatureSignal;
