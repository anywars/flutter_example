import 'package:flutter/material.dart';


class ExText extends Text {
  ExText(String data, {
    Key? key,
    TextStyle? style,
    double? fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
    TextOverflow? overflow,
  }): super(data, key: key, style: (style ?? TextStyle()).copyWith(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    overflow: overflow,
  ));

  factory ExText.bodySmall(BuildContext context, String data, {
    Key? key,
    double? fontSize,
  }) => ExText(data,
    style: Theme.of(context).textTheme.bodySmall,
    key: key,
    fontSize: fontSize,
  );

  factory ExText.bodyMedium(BuildContext context, String data, {
    Key? key,
    double? fontSize,
  }) => ExText(data,
    style: Theme.of(context).textTheme.bodyMedium,
    key: key,
    fontSize: fontSize,
  );

  factory ExText.bodyLarge(BuildContext context, String data, {
    Key? key,
    double? fontSize,
  }) => ExText(data,
    style: Theme.of(context).textTheme.bodyLarge,
    key: key,
    fontSize: fontSize,
  );

}