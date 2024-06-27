import '../../localization/l10n.dart';
import '../base_validator.dart';

class SsnValidator extends BaseValidator<String> {
  SsnValidator({
    /// {@macro ssn_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _ssn;

  final RegExp regex;

  /// {@template ssn_template}
  /// This regex matches SSN (Social Security Number).
  /// - It consists of 9 characters.
  /// - It starts with three digits, followed by a hyphen, two digits, another hyphen, and four digits.
  /// Examples: 123-45-6789
  /// {@endtemplate}
  static final RegExp _ssn = RegExp(r'^\d{3}-\d{2}-\d{4}$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.ssnErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    return isSSN(valueCandidate!) ? null : errorText;
  }

  /// check if the string is a valid SSN string
  bool isSSN(String value) {
    final String ssn = value.replaceAll('-', '').replaceAll(' ', '');

    if (ssn.length != 9) {
      return false;
    }

    return regex.hasMatch(ssn);
  }
}
