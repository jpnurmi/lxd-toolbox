import 'dart:ui';

import 'package:terminal_view/terminal_view.dart';

import 'terminal_colors.dart';

// TODO: configurable
TerminalThemeData getTerminalTheme(String? os) {
  switch (os?.toLowerCase()) {
    case 'ubuntu':
      return TerminalThemes.ubuntu;
    default:
      return TerminalThemes.fallback;
  }
}

const terminalThemes = {
  'ubuntu': TerminalThemes.ubuntu,
  'gnomeLight': TerminalThemes.gnomeLight,
  'gnomeDark': TerminalThemes.gnomeDark,
  'xterm': TerminalThemes.xterm,
};

abstract class TerminalThemes {
  const TerminalThemes._();

  static const ubuntu = TerminalThemeData(
    fontSize: 16,
    fontFamily: 'Ubuntu Mono',
    scheme: TerminalSchemes.ubuntu,
    palette: TerminalPalettes.ubuntu,
    brightPalette: TerminalPalettes.ubuntuBright,
    searchHitBackground: Color(0XFFFFFF2B),
    searchHitBackgroundCurrent: Color(0XFF31FF26),
    searchHitForeground: Color(0XFF000000),
  );

  static const fallback = TerminalThemeData(
    fontSize: 16,
    fontFamily: 'Monospace',
    scheme: TerminalSchemes.whiteOnBlack,
    palette: TerminalPalettes.ubuntu,
    brightPalette: TerminalPalettes.ubuntuBright,
    searchHitBackground: Color(0XFFFFFF2B),
    searchHitBackgroundCurrent: Color(0XFF31FF26),
    searchHitForeground: Color(0XFF000000),
  );

  static const gnomeLight = TerminalThemeData(
    fontSize: 16,
    fontFamily: 'Ubuntu Mono',
    scheme: TerminalSchemes.gnomeLight,
    palette: TerminalPalettes.gnome,
    brightPalette: TerminalPalettes.gnomeBright,
    searchHitBackground: Color(0XFFFFFF2B),
    searchHitBackgroundCurrent: Color(0XFF31FF26),
    searchHitForeground: Color(0XFF000000),
  );

  static const gnomeDark = TerminalThemeData(
    fontSize: 16,
    fontFamily: 'Liberation Mono',
    scheme: TerminalSchemes.gnomeDark,
    palette: TerminalPalettes.gnome,
    brightPalette: TerminalPalettes.gnomeBright,
    searchHitBackground: Color(0XFFFFFF2B),
    searchHitBackgroundCurrent: Color(0XFF31FF26),
    searchHitForeground: Color(0XFF000000),
  );

  static const xterm = TerminalThemeData(
    fontSize: 12,
    fontFamily: 'Liberation Mono',
    scheme: TerminalSchemes.whiteOnBlack,
    palette: TerminalPalettes.xterm,
    brightPalette: TerminalPalettes.xtermBright,
    searchHitBackground: Color(0xFFFFFF2B),
    searchHitBackgroundCurrent: Color(0xFF31FF26),
    searchHitForeground: Color(0xFF000000),
  );
}
