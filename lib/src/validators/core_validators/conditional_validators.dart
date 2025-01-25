import '../constants.dart';

/// {@macro validator_validate_if}
Validator<T> validateIf<T extends Object?>(
    bool Function(T value) condition, Validator<T> v) {
  return (T value) => condition(value) ? v(value) : null;
}

/// {@macro validator_skip_if}
Validator<T> skipIf<T extends Object?>(
    bool Function(T value) condition, Validator<T> v) {
  return (T value) => condition(value) ? null : v(value);
}
