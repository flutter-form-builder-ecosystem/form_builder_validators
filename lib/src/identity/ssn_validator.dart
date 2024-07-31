import '../../form_builder_validators.dart';

/// {@template ssn_validator_template}
/// [SsnValidator] extends [TranslatedValidator] to validate if a string represents a valid SSN (Social Security Number).
///
/// This validator checks if the SSN matches the specified regex pattern.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the SSN format. Defaults to a standard SSN regex.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class SsnValidator extends TranslatedValidator<String> {
  /// Constructor for the SSN validator.
  SsnValidator({
    /// {@macro ssn_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _ssn;

  /// The regular expression used to validate the SSN format.
  final RegExp regex;

  /// {@template ssn_template}
  /// This regex matches SSN (Social Security Number).
  /// - It consists of 9 characters.
  /// - It starts with three digits, followed by a hyphen, two digits,
  /// another hyphen, and four digits.
  /// Examples: 123-45-6789
  /// {@endtemplate}
  static final RegExp _ssn = RegExp(r'^\d{3}-\d{2}-\d{4}$');

  static final RegExp _ssnCleaned = RegExp(r'^\d{9}$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.ssnErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return isSSN(valueCandidate) ? null : errorText;
  }

  /// Check if the string is a valid SSN string.
  bool isSSN(String value) {
    final String ssn = value.replaceAll('-', '').replaceAll(' ', '');

    if (ssn.length != 9) {
      return false;
    }

    return regex == _ssn
        ? regex.hasMatch(value) || _ssnCleaned.hasMatch(ssn)
        : regex.hasMatch(value) || regex.hasMatch(ssn);
  }
}
