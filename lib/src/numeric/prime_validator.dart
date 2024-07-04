import '../../localization/l10n.dart';
import '../base_validator.dart';

class PrimeNumberValidator<T> extends BaseValidator<T> {
  const PrimeNumberValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.primeNumberErrorText;

  bool _isPrime(int number) {
    if (number <= 1) return false;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  @override
  String? validateValue(T valueCandidate) {
    final int? value;
    if (valueCandidate is String) {
      value = int.tryParse(valueCandidate);
    } else if (valueCandidate is int) {
      value = valueCandidate;
    } else {
      return errorText;
    }

    if (value == null) {
      return errorText;
    }

    if (!_isPrime(value)) {
      return errorText;
    }

    return null;
  }
}
