// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mc_hub/theme/custom_color.dart';

class CustomTheme {
  ThemeData get darkTheme =>
      ThemeData(useMaterial3: true, colorScheme: CustomColorSchema().schema);
}
