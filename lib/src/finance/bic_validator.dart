import '../../localization/l10n.dart';
import '../base_validator.dart';

class BicValidator extends BaseValidator<String> {
  BicValidator({
    /// {@macro bic_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _bic;

  final RegExp regex;

  /// {@template bic_template}
  /// This regex matches BIC (Bank Identifier Code).
  ///
  /// - It consists of 8 or 11 characters.
  /// - It starts with four letters (bank code), followed by two letters (country code), two characters (location code), and optionally three characters (branch code).
  ///
  /// Examples: DEUTDEFF, NEDSZAJJXXX
  /// {@endtemplate}
  static final RegExp _bic = RegExp(r'^[A-Z]{4}[A-Z]{2}\w{2}(\w{3})?$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.bicErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return isBIC(valueCandidate) ? null : errorText;
  }

  /// check if the string is a valid BIC string
  bool isBIC(String value) {
    final String bic = value.replaceAll(' ', '').toUpperCase();

    if (bic.length != 8 && bic.length != 11) {
      return false;
    }

    return regex.hasMatch(bic);
  }
}
