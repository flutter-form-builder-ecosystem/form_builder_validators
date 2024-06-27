import '../../localization/l10n.dart';
import '../base_validator.dart';

class CreditCardExpirationDateValidator extends BaseValidator<String> {
  CreditCardExpirationDateValidator({
    this.checkForExpiration = true,

    /// {@macro credit_card_expiration_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _creditCardExpirationDate;

  final bool checkForExpiration;

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

  /// check if the string is a valid credit card expiration date
  bool isCreditCardExpirationDate(String str) {
    // Check if the format matches MM/YY
    if (!_creditCardExpirationDate.hasMatch(str)) {
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

  /// check if the string is not a expired credit card date
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
