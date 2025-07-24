import '../../form_builder_validators.dart';

/// {@macro validator_color_code}
Validator<String> colorCode({
  Set<ColorFormat> formats = const <ColorFormat>{
    ColorFormat.Hex,
    ColorFormat.Rgb,
    ColorFormat.Hsl,
  },
  bool Function(String)? customColorCode,
  String Function(String input)? colorCodeMsg,
}) {
  if (formats.isEmpty) {
    throw ArgumentError.value(
        '[]', 'formats', 'The set of formats allowed must not be empty');
  }

  return (String input) {
    return customColorCode?.call(input) ?? _isColorCode(input, formats: formats)
        ? null
        : colorCodeMsg?.call(input) ??
            FormBuilderLocalizations.current
                .colorCodeErrorText(_toStringFormats(formats));
  };
}

// Aux
enum ColorFormat {
  Hex,
  Rgb,
  Hsl;

  // You can also add instance methods, constructors, etc.
  String get displayName {
    switch (this) {
      case ColorFormat.Hex:
        return 'HEX';
      case ColorFormat.Rgb:
        return 'RGB';
      case ColorFormat.Hsl:
        return 'HSL';
    }
  }
}

String _toStringFormats(Set<ColorFormat> formats) {
  List<String> formatsBuilder = <String>[];
  for (final ColorFormat f in formats) {
    formatsBuilder.add(f.displayName);
  }
  return formatsBuilder.join(', ');
}

/// {@template hex_template}
/// This regex matches hexadecimal color codes.
///
/// - It starts with a # character.
/// - It is followed by exactly six characters, each of which is a hexadecimal digit (0-9, a-f, or A-F).
///
/// Examples: #1a2b3c, #ABCDEF
/// {@endtemplate}
final RegExp _hex = RegExp(r'^#[0-9a-fA-F]{6}$');

/// {@template rgb_template}
/// This regex matches RGB color values.
///
/// - It checks for the rgb() format.
/// - It allows up to three digits for each color value (0-255).
///
/// Examples: rgb(255, 0, 0), rgb(123, 123, 123)
/// {@endtemplate}
final RegExp _rgb = RegExp(r'^rgb\(\d{1,3},\s*\d{1,3},\s*\d{1,3}\)$');

/// {@template hsl_template}
/// This regex matches HSL color values.
///
/// - It checks for the hsl() format.
/// - It allows integers for hue and percentages for saturation and lightness.
///
/// Examples: hsl(360, 100%, 50%), hsl(120, 75%, 25%)
/// {@endtemplate}
final RegExp _hsl = RegExp(
  r'^hsl\(\s*(\d{1,3})\s*,\s*(\d{1,3})%\s*,\s*(\d{1,3})%\s*\)$',
);

/// Checks if the string is a valid color code in specified formats.
///
/// ## Parameters:
/// - [value] The string to be checked.
/// - [formats] The list of color formats to check against.
///
/// ## Returns:
/// A boolean indicating whether the string is a valid color code.
bool _isColorCode(
  String value, {
  required Set<ColorFormat> formats,
}) {
  for (final ColorFormat format in formats) {
    switch (format) {
      case ColorFormat.Hex:
        if (_hex.hasMatch(value)) {
          return true;
        }
      case ColorFormat.Rgb:
        if (_rgb.hasMatch(value)) {
          final List<String> parts =
              value.substring(4, value.length - 1).split(',');
          for (final String part in parts) {
            final int colorValue = int.tryParse(part.trim()) ?? -1;
            if (colorValue < 0 || colorValue > 255) {
              return false;
            }
          }
          return true;
        }

      case ColorFormat.Hsl:
        if (_hsl.hasMatch(value)) {
          final List<String?> parts =
              _hsl.firstMatch(value)!.groups(<int>[1, 2, 3]);
          final int hue = int.tryParse(parts[0]!) ?? -1;
          final int saturation = int.tryParse(parts[1]!) ?? -1;
          final int lightness = int.tryParse(parts[2]!) ?? -1;
          if (hue < 0 ||
              hue > 360 ||
              saturation < 0 ||
              saturation > 100 ||
              lightness < 0 ||
              lightness > 100) {
            return false;
          }
          return true;
        }
    }
  }
  return false;
}
