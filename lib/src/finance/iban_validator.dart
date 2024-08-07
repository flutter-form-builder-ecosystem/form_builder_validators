import '../../form_builder_validators.dart';

/// {@template iban_validator_template}
/// [IbanValidator] extends [TranslatedValidator] to validate if a string represents a valid IBAN (International Bank Account Number).
///
/// This validator checks if the IBAN matches the specified regex pattern and performs a checksum validation.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the IBAN format. Defaults to a standard IBAN regex.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class IbanValidator extends TranslatedValidator<String> {
  /// Constructor for the IBAN validator.
  IbanValidator({
    /// {@macro iban_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _iban;

  /// The regular expression used to validate the IBAN format.
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
  String? validateValue(String valueCandidate) {
    return isIBAN(valueCandidate) ? null : errorText;
  }

  /// Check if the string is a valid IBAN.
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
