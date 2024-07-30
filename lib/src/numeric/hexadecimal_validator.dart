import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template hexadecimal_validator_template}
/// [HexadecimalValidator] extends [BaseValidator] to validate if a value is a hexadecimal string.
///
/// This validator checks if the value is a valid hexadecimal string using a regular expression.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [regex] The regular expression used to validate the hexadecimal string.
///
/// {@macro hexadecimal_regex_template}
/// {@endtemplate}
class HexadecimalValidator extends BaseValidator<String> {
  /// Constructor for the hexadecimal validator.
  HexadecimalValidator({
    /// {@macro hexadecimal_regex_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _hexadecimalRegex;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.hexadecimalErrorText;

  /// The regular expression used to validate the hexadecimal string.
  final RegExp regex;

  /// {@template hexadecimal_regex_template}
  /// The default regex matches a hexadecimal string.
  ///
  /// - It allows digits and letters from A-F (both lowercase and uppercase).
  /// - It supports optional prefixes "0x" or "0X".
  ///
  /// Examples: 1A3F, a1b2c3, 0x4faDA5
  /// {@endtemplate}
  static final RegExp _hexadecimalRegex = RegExp(
    r'^(0[xX])?[0-9a-fA-F]+$',
  );

  @override
  String? validateValue(String valueCandidate) {
    return regex.hasMatch(valueCandidate) ? null : errorText;
  }
}
