import '../../form_builder_validators.dart';

/// {@template phone_number_validator_template}
/// [PhoneNumberValidator] extends [TranslatedValidator] to validate if a string represents a valid international phone number.
///
/// This validator checks if the phone number matches the specified regex pattern.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the phone number format. Defaults to a standard international phone number regex.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class PhoneNumberValidator extends TranslatedValidator<String> {
  /// Constructor for the phone number validator.
  PhoneNumberValidator({
    /// {@macro phone_number_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _phoneNumber;

  /// The regular expression used to validate the phone number format.
  final RegExp regex;

  /// {@template phone_number_template}
  /// This regex matches international phone numbers.
  ///
  /// - It supports optional country codes.
  /// - It allows spaces, dashes, and dots as separators.
  /// - It validates the number of digits in the phone number.
  ///
  /// Examples: +1-800-555-5555, 1234567890
  /// {@endtemplate}
  static final RegExp _phoneNumber = RegExp(
    r'^\+?(\d{1,4}[\s.-]?)?(\(?\d{1,4}\)?[\s.-]?)?(\d{1,4}[\s.-]?)?(\d{1,4}[\s.-]?)?(\d{1,9})$',
  );

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.phoneErrorText;

  @override
  String? validateValue(String valueCandidate) {
    final String phoneNumber = valueCandidate
        .replaceAll(' ', '')
        .replaceAll('-', '');

    if (!regex.hasMatch(phoneNumber)) {
      return errorText;
    }
    return null;
  }
}
