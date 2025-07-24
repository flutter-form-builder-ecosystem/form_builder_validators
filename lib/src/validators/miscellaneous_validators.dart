import '../../form_builder_validators.dart';

/// {@macro validator_color_code}
Validator<String> colorCode({
  Set<ColorFormat> formats = const <ColorFormat>{
    ColorFormat.hex,
    ColorFormat.rgb,
    ColorFormat.hsl,
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

/// {@macro validator_isbn}
Validator<String> isbn({
  String Function(String input)? isbnMsg,
}) {
  return (String input) {
    return _isISBN(input)
        ? null
        : isbnMsg?.call(input) ??
            FormBuilderLocalizations.current.isbnErrorText;
  };
}

// Aux
/// {@template color_format}
/// Enumeration defining the supported color format types for color code validation.
/// This enum provides a standardized way to specify which color formats should be
/// accepted during validation operations.
///
/// The enum supports three primary web-standard color formats:
/// - Hexadecimal notation (e.g., #FF5733)
/// - RGB functional notation (e.g., rgb(255, 87, 51))
/// - HSL functional notation (e.g., hsl(14, 100%, 60%))
///
///
/// ## Examples
/// ```dart
/// // Using individual formats
/// final hexOnly = {ColorFormat.Hex};
/// final rgbOnly = {ColorFormat.Rgb};
///
/// // Using multiple formats
/// final webFormats = {ColorFormat.Hex, ColorFormat.Rgb};
/// final allFormats = {ColorFormat.Hex, ColorFormat.Rgb, ColorFormat.Hsl};
/// ```
/// {@endtemplate}
enum ColorFormat {
  /// Hexadecimal color format using # prefix followed by 6 hex digits
  hex,

  /// RGB color format using rgb() functional notation with comma-separated values
  rgb,

  /// HSL color format using hsl() functional notation with hue, saturation, and lightness
  hsl;

  String get _displayName {
    switch (this) {
      case ColorFormat.hex:
        return 'HEX';
      case ColorFormat.rgb:
        return 'RGB';
      case ColorFormat.hsl:
        return 'HSL';
    }
  }
}

String _toStringFormats(Set<ColorFormat> formats) {
  List<String> formatsBuilder = <String>[];
  for (final ColorFormat f in formats) {
    formatsBuilder.add(f._displayName);
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
      case ColorFormat.hex:
        if (_hex.hasMatch(value)) {
          return true;
        }
      case ColorFormat.rgb:
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

      case ColorFormat.hsl:
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

/// Checks if the string is a valid ISBN (either ISBN-10 or ISBN-13).
///
/// ## Parameters:
/// - [valueCandidate] The string to be checked.
///
/// ## Returns:
/// A boolean indicating whether the string is a valid ISBN.
bool _isISBN(String valueCandidate) {
  final String isbn = valueCandidate.replaceAll('-', '').replaceAll(' ', '');

  if (isbn.length == 10) {
    if (!RegExp(r'^\d{9}[\dX]$').hasMatch(isbn)) return false;

    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(isbn[i]) * (10 - i);
    }

    final int checkDigit = (isbn[9] == 'X') ? 10 : int.parse(isbn[9]);
    sum += checkDigit;

    return sum % 11 == 0;
  } else if (isbn.length == 13) {
    if (!RegExp(r'^\d{13}$').hasMatch(isbn)) return false;

    int sum = 0;
    for (int i = 0; i < 12; i++) {
      final int digit = int.parse(isbn[i]);
      sum += (i.isEven) ? digit : digit * 3;
    }

    final int checkDigit = int.parse(isbn[12]);
    final int calculatedCheckDigit = (10 - (sum % 10)) % 10;

    return checkDigit == calculatedCheckDigit;
  } else {
    return false;
  }
}
