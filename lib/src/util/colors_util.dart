import 'package:flutter/material.dart';

class ColorUtil {
  /// 根据十六进制颜色值字符串，转颜色
  static Color getColorWithHexString(String hexColor,
      {Color defaultColor = Colors.transparent}) {
    if (hexColor.isEmpty) return defaultColor;
    Color? color = colorsDic[hexColor];
    if (color != null) return color;
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    hexColor = hexColor.replaceAll('0X', '');
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length != 8) return defaultColor;
    return Color(int.tryParse(hexColor, radix: 16) ?? 0x00000000);
  }

  static Color changeColor(Color color, int changeValue) {
    assert(changeValue.abs() < 256);
    int r = color.red + changeValue;
    r = r > 255 ? 255 : (r < 0 ? 0 : r);
    int g = color.green + changeValue;
    g = g > 255 ? 255 : (g < 0 ? 0 : g);
    int b = color.blue + changeValue;
    b = b > 255 ? 255 : (b < 0 ? 0 : b);
    return Color.fromRGBO(r, g, b, 1);
  }
}

const Map<String, Color> colorsDic = {
  "AliceBlue": Color(0xFFF0F8FF),
  "AntiqueWhite": Color(0xFFFAEBD7),
  "Aqua": Color(0xFF00FFFF),
  "Aquamarine": Color(0xFF7FFFD4),
  "Azure": Color(0xFFF0FFFF),
  "Beige": Color(0xFFF5F5DC),
  "Bisque": Color(0xFFFFE4C4),
  "Black": Color(0xFF000000),
  "BlanchedAlmond": Color(0xFFFFEBCD),
  "Blue": Color(0xFF0000FF),
  "BlueViolet": Color(0xFF8A2BE2),
  "Brown": Color(0xFFA52A2A),
  "BurlyWood": Color(0xFFDEB887),
  "CadetBlue": Color(0xFF5F9EA0),
  "Chartreuse": Color(0xFF7FFF00),
  "Chocolate": Color(0xFFD2691E),
  "Coral": Color(0xFFFF7F50),
  "CornflowerBlue": Color(0xFF6495ED),
  "Cornsilk": Color(0xFFFFF8DC),
  "Crimson": Color(0xFFDC143C),
  "Cyan": Color(0xFF00FFFF),
  "DarkBlue": Color(0xFF00008B),
  "DarkCyan": Color(0xFF008B8B),
  "DarkGoldenRod": Color(0xFFB8860B),
  "DarkGray": Color(0xFFA9A9A9),
  "DarkGreen": Color(0xFF006400),
  "DarkKhaki": Color(0xFFBDB76B),
  "DarkMagenta": Color(0xFF8B008B),
  "DarkOliveGreen": Color(0xFF556B2F),
  "Darkorange": Color(0xFFFF8C00),
  "DarkOrchid": Color(0xFF9932CC),
  "DarkRed": Color(0xFF8B0000),
  "DarkSalmon": Color(0xFFE9967A),
  "DarkSeaGreen": Color(0xFF8FBC8F),
  "DarkSlateBlue": Color(0xFF483D8B),
  "DarkSlateGray": Color(0xFF2F4F4F),
  "DarkTurquoise": Color(0xFF00CED1),
  "DarkViolet": Color(0xFF9400D3),
  "DeepPink": Color(0xFFFF1493),
  "DeepSkyBlue": Color(0xFF00BFFF),
  "DimGray": Color(0xFF696969),
  "DodgerBlue": Color(0xFF1E90FF),
  "Feldspar": Color(0xFFD19275),
  "FireBrick": Color(0xFFB22222),
  "FloralWhite": Color(0xFFFFFAF0),
  "ForestGreen": Color(0xFF228B22),
  "Fuchsia": Color(0xFFFF00FF),
  "Gainsboro": Color(0xFFDCDCDC),
  "GhostWhite": Color(0xFFF8F8FF),
  "Gold": Color(0xFFFFD700),
  "GoldenRod": Color(0xFFDAA520),
  "Gray": Color(0xFF808080),
  "Green": Color(0xFF008000),
  "GreenYellow": Color(0xFFADFF2F),
  "HoneyDew": Color(0xFFF0FFF0),
  "HotPink": Color(0xFFFF69B4),
  "IndianRed": Color(0xFFCD5C5C),
  "Indigo": Color(0xFF4B0082),
  "Ivory": Color(0xFFFFFFF0),
  "Khaki": Color(0xFFF0E68C),
  "Lavender": Color(0xFFE6E6FA),
  "LavenderBlush": Color(0xFFFFF0F5),
  "LawnGreen": Color(0xFF7CFC00),
  "LemonChiffon": Color(0xFFFFFACD),
  "LightBlue": Color(0xFFADD8E6),
  "LightCoral": Color(0xFFF08080),
  "LightCyan": Color(0xFFE0FFFF),
  "LightGoldenRodYellow": Color(0xFFFAFAD2),
  "LightGrey": Color(0xFFD3D3D3),
  "LightGreen": Color(0xFF90EE90),
  "LightPink": Color(0xFFFFB6C1),
  "LightSalmon": Color(0xFFFFA07A),
  "LightSeaGreen": Color(0xFF20B2AA),
  "LightSkyBlue": Color(0xFF87CEFA),
  "LightSlateBlue": Color(0xFF8470FF),
  "LightSlateGray": Color(0xFF778899),
  "LightSteelBlue": Color(0xFFB0C4DE),
  "LightYellow": Color(0xFFFFFFE0),
  "Lime": Color(0xFF00FF00),
  "LimeGreen": Color(0xFF32CD32),
  "Linen": Color(0xFFFAF0E6),
  "Magenta": Color(0xFFFF00FF),
  "Maroon": Color(0xFF800000),
  "MediumAquaMarine": Color(0xFF66CDAA),
  "MediumBlue": Color(0xFF0000CD),
  "MediumOrchid": Color(0xFFBA55D3),
  "MediumPurple": Color(0xFF9370D8),
  "MediumSeaGreen": Color(0xFF3CB371),
  "MediumSlateBlue": Color(0xFF7B68EE),
  "MediumSpringGreen": Color(0xFF00FA9A),
  "MediumTurquoise": Color(0xFF48D1CC),
  "MediumVioletRed": Color(0xFFC71585),
  "MidnightBlue": Color(0xFF191970),
  "MintCream": Color(0xFFF5FFFA),
  "MistyRose": Color(0xFFFFE4E1),
  "Moccasin": Color(0xFFFFE4B5),
  "NavajoWhite": Color(0xFFFFDEAD),
  "Navy": Color(0xFF000080),
  "OldLace": Color(0xFFFDF5E6),
  "Olive": Color(0xFF808000),
  "OliveDrab": Color(0xFF6B8E23),
  "Orange": Color(0xFFFFA500),
  "OrangeRed": Color(0xFFFF4500),
  "Orchid": Color(0xFFDA70D6),
  "PaleGoldenRod": Color(0xFFEEE8AA),
  "PaleGreen": Color(0xFF98FB98),
  "PaleTurquoise": Color(0xFFAFEEEE),
  "PaleVioletRed": Color(0xFFD87093),
  "PapayaWhip": Color(0xFFFFEFD5),
  "PeachPuff": Color(0xFFFFDAB9),
  "Peru": Color(0xFFCD853F),
  "Pink": Color(0xFFFFC0CB),
  "Plum": Color(0xFFDDA0DD),
  "PowderBlue": Color(0xFFB0E0E6),
  "Purple": Color(0xFF800080),
  "Red": Color(0xFFFF0000),
  "RosyBrown": Color(0xFFBC8F8F),
  "RoyalBlue": Color(0xFF4169E1),
  "SaddleBrown": Color(0xFF8B4513),
  "Salmon": Color(0xFFFA8072),
  "SandyBrown": Color(0xFFF4A460),
  "SeaGreen": Color(0xFF2E8B57),
  "SeaShell": Color(0xFFFFF5EE),
  "Sienna": Color(0xFFA0522D),
  "Silver": Color(0xFFC0C0C0),
  "SkyBlue": Color(0xFF87CEEB),
  "SlateBlue": Color(0xFF6A5ACD),
  "SlateGray": Color(0xFF708090),
  "Snow": Color(0xFFFFFAFA),
  "SpringGreen": Color(0xFF00FF7F),
  "SteelBlue": Color(0xFF4682B4),
  "Tan": Color(0xFFD2B48C),
  "Teal": Color(0xFF008080),
  "Thistle": Color(0xFFD8BFD8),
  "Tomato": Color(0xFFFF6347),
  "Turquoise": Color(0xFF40E0D0),
  "Violet": Color(0xFFEE82EE),
  "VioletRed": Color(0xFFD02090),
  "Wheat": Color(0xFFF5DEB3),
  "White": Color(0xFFFFFFFF),
  "WhiteSmoke": Color(0xFFF5F5F5),
  "Yellow": Color(0xFFFFFF00),
  "YellowGreen": Color(0xFF9ACD32),
};
