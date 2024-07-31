import '../../form_builder_validators.dart';

/// {@template credit_card_validator_template}
/// [CreditCardValidator] extends [TranslatedValidator] to validate if a string represents a valid credit card number.
///
/// This validator checks if the credit card number matches the specified regex pattern and passes the Luhn algorithm.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the credit card number format. Defaults to a standard credit card regex.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class CreditCardValidator extends TranslatedValidator<String> {
  /// Constructor for the credit card number validator.
  CreditCardValidator({
    /// {@macro credit_card_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _creditCard;

  /// The regular expression used to validate the credit card number format.
  final RegExp regex;

  /// {@template credit_card_template}
  /// This regex matches credit card numbers from major brands.
  ///
  /// - It supports Visa, MasterCard, American Express, Diners Club, Discover, and JCB cards.
  /// - It validates the number of digits and prefixes for each card type.
  ///
  /// Examples: 4111111111111111, 5500000000000004, 340000000000009
  /// {@endtemplate}
  static final RegExp _creditCard = RegExp(
    r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$',
  );

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.creditCardErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return isCreditCard(valueCandidate) ? null : errorText;
  }

  /// Check if the string is a credit card number.
  bool isCreditCard(String value) {
    final String sanitized = value.replaceAll(RegExp('[^0-9]+'), '');
    if (!regex.hasMatch(sanitized)) {
      return false;
    }

    // Luhn algorithm
    int sum = 0;
    String digit;
    bool shouldDouble = false;

    for (int i = sanitized.length - 1; i >= 0; i--) {
      digit = sanitized.substring(i, i + 1);
      int tmpNum = int.parse(digit);

      if (shouldDouble) {
        tmpNum *= 2;
        if (tmpNum >= 10) {
          sum += (tmpNum % 10) + 1;
        } else {
          sum += tmpNum;
        }
      } else {
        sum += tmpNum;
      }
      shouldDouble = !shouldDouble;
    }

    return (sum % 10 == 0);
  }
}
