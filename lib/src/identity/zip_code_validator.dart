import '../../form_builder_validators.dart';

/// {@template zip_code_validator_template}
/// [ZipCodeValidator] extends [TranslatedValidator] to validate if a string represents a valid USA ZIP code.
///
/// This validator checks if the ZIP code matches the specified regex pattern.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the ZIP code format. Defaults to a standard USA ZIP code regex.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class ZipCodeValidator extends TranslatedValidator<String> {
  /// Constructor for the ZIP code validator.
  ZipCodeValidator({
    /// {@macro zip_code_template}
    RegExp? regex,

    /// {@macro zip_code_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _zipCode;

  /// The regular expression used to validate the ZIP code format.
  final RegExp regex;

  /// {@template zip_code_template}
  /// This regex matches a valid USA ZIP code.
  ///
  /// Examples: 12345, 12345-6789
  /// {@endtemplate}
  static final RegExp _zipCode = RegExp(r'^\d{5}(?:[-\s]\d{4})?$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.zipCodeErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return regex.hasMatch(valueCandidate) ? null : errorText;
  }
}
