import '../../localization/l10n.dart';
import '../base_validator.dart';

class IbanValidator extends BaseValidator<String> {
  IbanValidator({
    /// {@macro iban_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _iban;

  final RegExp regex;

  /// {@template iban_template}
  /// This regex matches IBAN (International Bank Account Number).
  ///
  /// - It consists of two letters (country code), two digits (check digits),
  /// and up to 30 alphanumeric characters (account number).
  ///
  /// Examples: DE89370400440532013000, FR1420041010050500013M02606
  /// {@endtemplate}
  static final RegExp _iban = RegExp(r'^[A-Z]{2}\d{2}\w{1,30}$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.ibanErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    return isIBAN(valueCandidate!) ? null : errorText;
  }

  /// check if the string is a valid IBAN
  bool isIBAN(String value) {
    final String iban = value.replaceAll(' ', '').toUpperCase();

    if (iban.length < 15) {
      return false;
    }

    final String rearranged = iban.substring(4) + iban.substring(0, 4);
    final String numericIban = rearranged.split('').map((String char) {
      final int charCode = char.codeUnitAt(0);
      return charCode >= 65 && charCode <= 90
          ? (charCode - 55).toString()
          : char;
    }).join();

    int remainder = int.parse(numericIban.substring(0, 9)) % 97;
    for (int i = 9; i < numericIban.length; i += 7) {
      remainder = int.parse(
            remainder.toString() +
                numericIban.substring(
                  i,
                  i + 7 < numericIban.length ? i + 7 : numericIban.length,
                ),
          ) %
          97;
    }

    return remainder == 1;
  }
}
