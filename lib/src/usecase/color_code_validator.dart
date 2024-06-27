import '../../localization/l10n.dart';
import '../base_validator.dart';

class ColorCodeValidator extends BaseValidator<String> {
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

  final List<String> formats;

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
  static final RegExp _hsl = RegExp(r'^hsl\(\d+,\s*\d+%,\s*\d+%\)$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.colorCodeErrorText(formats.join(', '));

  @override
  String? validateValue(String valueCandidate) {
    return !isColorCode(valueCandidate, formats: formats) ? errorText : null;
  }

  /// check if the string is a color
  /// * [formats] is a list of color formats to check
  bool isColorCode(
    String value, {
    List<String> formats = const <String>['hex', 'rgb', 'hsl'],
  }) {
    if (formats.contains('hex') && (regex != null && regex!.hasMatch(value)) ||
        _hex.hasMatch(value)) {
      return true;
    } else if (formats.contains('rgb') &&
            (regex != null && regex!.hasMatch(value)) ||
        _rgb.hasMatch(value)) {
      final List<String> parts =
          value.substring(4, value.length - 1).split(',');
      for (final String part in parts) {
        final int colorValue = int.tryParse(part.trim()) ?? -1;
        if (colorValue < 0 || colorValue > 255) {
          return false;
        }
      }
      return true;
    } else if (formats.contains('hsl') &&
            (regex != null && regex!.hasMatch(value)) ||
        _hsl.hasMatch(value)) {
      final List<String> parts =
          value.substring(4, value.length - 1).split(',');
      for (int i = 0; i < parts.length; i++) {
        final int colorValue = int.tryParse(parts[i].trim()) ?? -1;
        if (i == 0) {
          // Hue
          if (colorValue < 0 || colorValue > 360) {
            return false;
          }
        } else if (colorValue < 0 || colorValue > 100) {
          return false;
        }
      }
      return true;
    }
    return false;
  }
}
