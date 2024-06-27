import '../../localization/l10n.dart';
import '../base_validator.dart';

class PhoneNumberValidator extends BaseValidator<String> {
  PhoneNumberValidator({
    /// {@macro phone_number_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _phoneNumber;

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
  static final RegExp _phoneNumber =
      RegExp(r'^\+?(\d{1,4}[\s-])?(?!0+\s+,?$)\d{1,15}$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.phoneErrorText;

  @override
  String? validateValue(String valueCandidate) {
    final String phoneNumber =
        valueCandidate.replaceAll(' ', '').replaceAll('-', '');

    if (!regex.hasMatch(phoneNumber)) {
      return errorText;
    }
    return null;
  }
}
