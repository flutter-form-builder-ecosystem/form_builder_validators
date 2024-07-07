import 'dart:convert';

import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template base64_validator_template}
/// [Base64Validator] extends [BaseValidator] to validate if a string is a valid base64 encoded string.
///
/// This validator checks if the value can be successfully decoded from base64 format.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class Base64Validator extends BaseValidator<String> {
  /// Constructor for the base64 validator.
  const Base64Validator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.base64ErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return isBase64(valueCandidate) ? null : errorText;
  }

  /// Checks if the string is a valid base64 string.
  ///
  /// ## Parameters:
  /// - [value] The string to be checked.
  ///
  /// ## Returns:
  /// A boolean indicating whether the string is valid base64.
  bool isBase64(String value) {
    try {
      base64Decode(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
