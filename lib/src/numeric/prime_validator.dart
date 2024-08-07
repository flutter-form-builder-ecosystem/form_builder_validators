import '../../form_builder_validators.dart';

/// {@template prime_number_validator_template}
/// [PrimeNumberValidator] extends [TranslatedValidator] to validate if a value is a prime number.
///
/// This validator checks if the value is an integer or a string that can be parsed into an integer and ensures it is a prime number.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class PrimeNumberValidator<T> extends TranslatedValidator<T> {
  /// Constructor for the prime number validator.
  const PrimeNumberValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.primeNumberErrorText;

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

    if (!isPrime(value)) {
      return errorText;
    }

    return null;
  }

  /// Checks if the number is prime.
  ///
  /// ## Parameters:
  /// - [number] The number to be checked.
  ///
  /// ## Returns:
  /// A boolean indicating whether the number is prime.
  bool isPrime(int number) {
    if (number <= 1) return false;
    for (int i = 2; i * i <= number; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }
}
