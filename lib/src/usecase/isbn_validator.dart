import '../../localization/l10n.dart';
import '../base_validator.dart';

class IsbnValidator extends BaseValidator<String> {
  IsbnValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.isbnErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    return isISBN(valueCandidate!) ? null : errorText;
  }

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
