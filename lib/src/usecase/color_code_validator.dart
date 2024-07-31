import '../../form_builder_validators.dart';

/// {@template color_code_validator_template}
/// [ColorCodeValidator] extends [TranslatedValidator] to validate if a string is a valid color code in specified formats.
///
/// This validator checks if the value matches the specified color formats, such as hex, rgb, or hsl.
///
/// ## Parameters:
///
/// - [formats] The list of color formats to check against. Defaults to ['hex', 'rgb', 'hsl'].
/// - [regex] An optional custom regular expression to validate the color code.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class ColorCodeValidator extends TranslatedValidator<String> {
  /// Constructor for the color code validator.
  ColorCodeValidator({
    this.formats = const <String>['hex', 'rgb', 'hsl'],

    /// {@macro hex_template}
    /// {@macro rgb_template}
    /// {@macro hsl_template}
    this.regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The list of color formats to check against.
  final List<String> formats;

  /// An optional custom regular expression to validate the color code.
  final RegExp? regex;

  /// {@template hex_template}
  /// This regex matches hexadecimal color codes.
  ///
  /// - It starts with a # character.
  /// - It is followed by exactly six characters, each of which is a hexadecimal digit (0-9, a-f, or A-F).
  ///
  /// Examples: #1a2b3c, #ABCDEF
  /// {@endtemplate}
  static final RegExp _hex = RegExp(r'^#[0-9a-fA-F]{6}$');

  /// {@template rgb_template}
  /// This regex matches RGB color values.
  ///
  /// - It checks for the rgb() format.
  /// - It allows up to three digits for each color value (0-255).
  ///
  /// Examples: rgb(255, 0, 0), rgb(123, 123, 123)
  /// {@endtemplate}
  static final RegExp _rgb = RegExp(r'^rgb\(\d{1,3},\s*\d{1,3},\s*\d{1,3}\)$');

  /// {@template hsl_template}
  /// This regex matches HSL color values.
  ///
  /// - It checks for the hsl() format.
  /// - It allows integers for hue and percentages for saturation and lightness.
  ///
  /// Examples: hsl(360, 100%, 50%), hsl(120, 75%, 25%)
  /// {@endtemplate}
  static final RegExp _hsl = RegExp(
    r'^hsl\(\s*(\d{1,3})\s*,\s*(\d{1,3})%\s*,\s*(\d{1,3})%\s*\)$',
  );

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.colorCodeErrorText(formats.join(', '));

  @override
  String? validateValue(String valueCandidate) {
    if (regex != null && regex!.hasMatch(valueCandidate)) {
      return null;
    }
    return isColorCode(valueCandidate, formats: formats) ? null : errorText;
  }

  /// Checks if the string is a valid color code in specified formats.
  ///
  /// ## Parameters:
  /// - [value] The string to be checked.
  /// - [formats] The list of color formats to check against.
  ///
  /// ## Returns:
  /// A boolean indicating whether the string is a valid color code.
  bool isColorCode(
    String value, {
    List<String> formats = const <String>['hex', 'rgb', 'hsl'],
  }) {
    for (final String format in formats) {
      if (format == 'hex' && _hex.hasMatch(value)) {
        return true;
      } else if (format == 'rgb' && _rgb.hasMatch(value)) {
        final List<String> parts =
            value.substring(4, value.length - 1).split(',');
        for (final String part in parts) {
          final int colorValue = int.tryParse(part.trim()) ?? -1;
          if (colorValue < 0 || colorValue > 255) {
            return false;
          }
        }
        return true;
      } else if (format == 'hsl' && _hsl.hasMatch(value)) {
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
    return false;
  }
}
