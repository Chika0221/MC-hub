// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mc_hub/theme/custom_color.dart';

class CustomTheme {
  ThemeData get mainTheme => ThemeData(
    useMaterial3: true,
    colorScheme: CustomColorSchema().schema,
    fontFamily: Fonts.WDXLLubrifont.name,
  );
  ThemeData get titleTheme => ThemeData(
    useMaterial3: true,
    colorScheme: CustomColorSchema().schema,
    fontFamily: Fonts.LunaChord.name,
  );
}

enum Fonts { WDXLLubrifont, LunaChord }
