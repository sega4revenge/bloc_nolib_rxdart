import 'package:flutter/cupertino.dart';

class FontConfig {
  static const String FONT_FAMILY = "yoongothic";
}


extension TextExt on Text {
  static Text text(String text,double size, FontWeight fontWeight, Color color, {TextAlign textAlign = TextAlign.start}) {
    return Text(text, style: TextStyleExt.textStyle(size, fontWeight, color), textAlign: textAlign);
  }
}

extension TextStyleExt on TextStyle {
  static TextStyle textStyle(double size, FontWeight fontWeight, Color color) {
    return TextStyle(fontFamily: FontConfig.FONT_FAMILY, fontWeight: FontWeight.w400, fontSize: size, color: color);
  }
}