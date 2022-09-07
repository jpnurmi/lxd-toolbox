/*
 * Most color schemes and palettes copied from GNOME Terminal:
 * https://gitlab.gnome.org/GNOME/gnome-terminal/-/blob/master/src/profile-editor.cc
 *
 * Copyright © 2002 Havoc Pennington
 * Copyright © 2002 Mathias Hasselmann
 * Copyright © 2008, 2011, 2017 Christian Persch
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:ui';

import 'package:terminal_view/terminal_view.dart';

abstract class TerminalSchemes {
  const TerminalSchemes._();

  static const ubuntu = TerminalScheme(
    foreground: Color(0xffffffff),
    background: Color(0xff380c2a),
  );

  static const blackOnLightYellow = TerminalScheme(
    foreground: Color(0xff000000),
    background: Color(0xffffffdd),
  );

  static const blackOnWhite = TerminalScheme(
    foreground: Color(0xff000000),
    background: Color(0xffffffff),
  );

  static const grayOnBlack = TerminalScheme(
    foreground: Color(0xffaaaaaa),
    background: Color(0xff000000),
  );

  static const greenOnBlack = TerminalScheme(
    foreground: Color(0xff00ff00),
    background: Color(0xff000000),
  );

  static const whiteOnBlack = TerminalScheme(
    foreground: Color(0xffffffff),
    background: Color(0xff000000),
  );

  static const gnomeLight = TerminalScheme(
    foreground: Color(0xff171421),
    background: Color(0xffffffff),
  );

  static const gnomeDark = TerminalScheme(
    foreground: Color(0xffd0cfcc),
    background: Color(0xff171421),
  );

  static const tangoLight = TerminalScheme(
    foreground: Color(0xff2e3436),
    background: Color(0xffeeeeec),
  );

  static const tangoDark = TerminalScheme(
    foreground: Color(0xffd3d7cf),
    background: Color(0xff2e3436),
  );

  static const solarizedLight = TerminalScheme(
    foreground: Color(0xff657b83),
    background: Color(0xfffdf6e3),
  );

  static const solarizedDark = TerminalScheme(
    foreground: Color(0xff839496),
    background: Color(0xff002b36),
  );
}

abstract class TerminalPalettes {
  const TerminalPalettes._();

  static const ubuntu = TerminalPalette(
    black: Color(0xFF000000),
    red: Color(0xFFCD3131),
    green: Color(0xFF0DBC79),
    yellow: Color(0xFFE5E510),
    blue: Color(0xFF2472C8),
    magenta: Color(0xFFBC3FBC),
    cyan: Color(0xFF11A8CD),
    white: Color(0xFFE5E5E5),
  );

  static const ubuntuBright = TerminalPalette(
    black: Color(0xFF666666),
    red: Color(0xFFF14C4C),
    green: Color(0xFF23D18B),
    yellow: Color(0xFFF5F543),
    blue: Color(0xFF3B8EEA),
    magenta: Color(0xFFD670D6),
    cyan: Color(0xFF29B8DB),
    white: Color(0xFFFFFFFF),
  );

  static const gnome = TerminalPalette(
    black: Color(0xff171421),
    red: Color(0xffc01c28),
    green: Color(0xff26a269),
    yellow: Color(0xffa2734c),
    blue: Color(0xff12488b),
    magenta: Color(0xffa347ba),
    cyan: Color(0xff2aa1b3),
    white: Color(0xffd0cfcc),
  );

  static const gnomeBright = TerminalPalette(
    black: Color(0xff5e5c64),
    red: Color(0xfff66151),
    green: Color(0xff33d17a),
    yellow: Color(0xffe9ad0c),
    blue: Color(0xff2a7bde),
    magenta: Color(0xffc061cb),
    cyan: Color(0xff33c7de),
    white: Color(0xffffffff),
  );

  static const tango = TerminalPalette(
    black: Color(0xff2e3436),
    red: Color(0xffcc0000),
    green: Color(0xff4e9a06),
    yellow: Color(0xffc4a000),
    blue: Color(0xff3465a4),
    magenta: Color(0xff75507b),
    cyan: Color(0xff06989a),
    white: Color(0xffd3d7cf),
  );

  static const tangoBright = TerminalPalette(
    black: Color(0xff555753),
    red: Color(0xffef2929),
    green: Color(0xff8ae234),
    yellow: Color(0xfffce94f),
    blue: Color(0xff729fcf),
    magenta: Color(0xffad7fa8),
    cyan: Color(0xff34e2e2),
    white: Color(0xffeeeeec),
  );

  static const linux = TerminalPalette(
    black: Color(0xff000000),
    red: Color(0xffaa0000),
    green: Color(0xff00aa00),
    yellow: Color(0xffaa5500),
    blue: Color(0xff0000aa),
    magenta: Color(0xffaa00aa),
    cyan: Color(0xff00aaaa),
    white: Color(0xffaaaaaa),
  );

  static const linuxBright = TerminalPalette(
    black: Color(0xff555555),
    red: Color(0xffff5555),
    green: Color(0xff55ff55),
    yellow: Color(0xffffff55),
    blue: Color(0xff5555ff),
    magenta: Color(0xffff55ff),
    cyan: Color(0xff55ffff),
    white: Color(0xffffffff),
  );

  static const xterm = TerminalPalette(
    black: Color(0xff000000),
    red: Color(0xffcd0000),
    green: Color(0xff00cd00),
    yellow: Color(0xffcdcd00),
    blue: Color(0xff0000ee),
    magenta: Color(0xffcd00cd),
    cyan: Color(0xff00cdcd),
    white: Color(0xffe5e5e5),
  );

  static const xtermBright = TerminalPalette(
    black: Color(0xff7f7f7f),
    red: Color(0xffff0000),
    green: Color(0xff00ff00),
    yellow: Color(0xffffff00),
    blue: Color(0xff5c5cff),
    magenta: Color(0xffff00ff),
    cyan: Color(0xff00ffff),
    white: Color(0xffffffff),
  );

  static const rxvt = TerminalPalette(
    black: Color(0xff000000),
    red: Color(0xffcd0000),
    green: Color(0xff00cd00),
    yellow: Color(0xffcdcd00),
    blue: Color(0xff0000cd),
    magenta: Color(0xffcd00cd),
    cyan: Color(0xff00cdcd),
    white: Color(0xfffaebd7),
  );

  static const rxvtBright = TerminalPalette(
    black: Color(0xff404040),
    red: Color(0xffff0000),
    green: Color(0xff00ff00),
    yellow: Color(0xffffff00),
    blue: Color(0xff0000ff),
    magenta: Color(0xffff00ff),
    cyan: Color(0xff00ffff),
    white: Color(0xffffffff),
  );

  static const solarized = TerminalPalette(
    black: Color(0xff073642),
    red: Color(0xffdc322f),
    green: Color(0xff859900),
    yellow: Color(0xffb58900),
    blue: Color(0xff268bd2),
    magenta: Color(0xffd33682),
    cyan: Color(0xff2aa198),
    white: Color(0xffeee8d5),
  );

  static const solarizedBright = TerminalPalette(
    black: Color(0xff002b36),
    red: Color(0xffcb4b16),
    green: Color(0xff586e75),
    yellow: Color(0xff657b83),
    blue: Color(0xff839496),
    magenta: Color(0xff6c71c4),
    cyan: Color(0xff93a1a1),
    white: Color(0xfffdf6e3),
  );
}
