import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template credit_card_expiration_date_validator_template}
/// [CreditCardExpirationDateValidator] extends [BaseValidator] to validate if a string represents a valid credit card expiration date.
///
/// This validator checks if the expiration date is in the format MM/YY, and optionally if the date is not expired.
///
/// ## Parameters:
///
/// - [checkForExpiration] Whether to check if the date is not expired. Defaults to true.
/// - [regex] The regular expression used to validate the expiration date format. Defaults to a standard expiration date regex.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class CreditCardExpirationDateValidator extends BaseValidator<String> {
  /// Constructor for the credit card expiration date validator.
  CreditCardExpirationDateValidator({
    this.checkForExpiration = true,

    /// {@macro credit_card_expiration_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _creditCardExpirationDate;

  /// Whether to check if the date is not expired.
  final bool checkForExpiration;

  /// The regular expression used to validate the expiration date format.
  final RegExp regex;

  /// {@template credit_card_expiration_template}
  /// This regex matches credit card expiration dates.
  ///
  /// - It checks for a valid month (01-12).
  /// - It checks for a valid year (two digits).
  ///
  /// Examples: 01/23, 12/25
  /// {@endtemplate}
  static final RegExp _creditCardExpirationDate = RegExp(r'^[0-1][0-9]/\d{2}$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.creditCardExpirationDateErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (!isCreditCardExpirationDate(valueCandidate)) {
      return errorText;
    }

    if (checkForExpiration && !isNotExpiredCreditCardDate(valueCandidate)) {
      return errorText;
    }

    return null;
  }

  /// Check if the string is a valid credit card expiration date.
  bool isCreditCardExpirationDate(String str) {
    // Check if the format matches MM/YY
    if (!regex.hasMatch(str)) {
      return false;
    }

    // Extract month and year from the value
    final List<int> parts = str.split('/').map(int.parse).toList();
    final int month = parts[0];
    final int year = parts[1];

    // Check for valid month (1-12)
    if (month < 1 || month > 12) {
      return false;
    }

    return year > 0;
  }

  /// Check if the string is not an expired credit card date.
  bool isNotExpiredCreditCardDate(String str) {
    final List<int> parts = str.split('/').map(int.parse).toList();
    final int month = parts[0];
    final int year = parts[1];

    final DateTime now = DateTime.now();
    final int currentYear = now.year % 100;
    final int currentMonth = now.month;

    if (year < currentYear) {
      return false;
    }

    if (year == currentYear && month < currentMonth) {
      return false;
    }

    return true;
  }
}
