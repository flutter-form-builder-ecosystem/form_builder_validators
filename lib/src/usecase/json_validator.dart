import 'dart:convert';

import '../../form_builder_validators.dart';

/// {@template json_validator_template}
/// [JsonValidator] extends [TranslatedValidator] to validate if a string is a valid JSON format.
///
/// This validator checks if the value can be successfully decoded as JSON.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class JsonValidator extends TranslatedValidator<String> {
  /// Constructor for the JSON validator.
  const JsonValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.jsonErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return isJSON(valueCandidate) ? null : errorText;
  }

  /// Checks if the string is a valid JSON format.
  ///
  /// ## Parameters:
  /// - [value] The string to be checked.
  ///
  /// ## Returns:
  /// A boolean indicating whether the string is valid JSON.
  bool isJSON(String value) {
    try {
      jsonDecode(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
