import '../../form_builder_validators.dart';

/// {@template isbn_validator_template}
/// [IsbnValidator] extends [TranslatedValidator] to validate if a string is a valid ISBN (International Standard Book Number).
///
/// This validator checks if the value is a valid ISBN-10 or ISBN-13 format.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class IsbnValidator extends TranslatedValidator<String> {
  /// Constructor for the ISBN validator.
  const IsbnValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.isbnErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return isISBN(valueCandidate) ? null : errorText;
  }

  /// Checks if the string is a valid ISBN (either ISBN-10 or ISBN-13).
  ///
  /// ## Parameters:
  /// - [valueCandidate] The string to be checked.
  ///
  /// ## Returns:
  /// A boolean indicating whether the string is a valid ISBN.
  bool isISBN(String valueCandidate) {
    final String isbn = valueCandidate.replaceAll('-', '').replaceAll(' ', '');

    if (isbn.length == 10) {
      if (!RegExp(r'^\d{9}[\dX]$').hasMatch(isbn)) return false;

      int sum = 0;
      for (int i = 0; i < 9; i++) {
        sum += int.parse(isbn[i]) * (10 - i);
      }

      final int checkDigit = (isbn[9] == 'X') ? 10 : int.parse(isbn[9]);
      sum += checkDigit;

      return sum % 11 == 0;
    } else if (isbn.length == 13) {
      if (!RegExp(r'^\d{13}$').hasMatch(isbn)) return false;

      int sum = 0;
      for (int i = 0; i < 12; i++) {
        final int digit = int.parse(isbn[i]);
        sum += (i.isEven) ? digit : digit * 3;
      }

      final int checkDigit = int.parse(isbn[12]);
      final int calculatedCheckDigit = (10 - (sum % 10)) % 10;

      return checkDigit == calculatedCheckDigit;
    } else {
      return false;
    }
  }
}
