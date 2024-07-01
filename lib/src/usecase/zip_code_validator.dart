import '../../localization/l10n.dart';
import '../base_validator.dart';

class ZipCodeValidator extends BaseValidator<String> {
  ZipCodeValidator({
    /// {@macro zip_code_template}
    RegExp? regex,

    /// {@macro zip_code_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _zipCode;

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
