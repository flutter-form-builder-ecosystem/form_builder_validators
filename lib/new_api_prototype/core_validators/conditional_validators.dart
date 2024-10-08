import '../constants.dart';

/// This function returns a validator that conditionally validates the user input.
/// If `condition` applied to the user input evaluates to true, the user input is
/// validated by `v`. Otherwise, it is automatically considered valid.
Validator<T> validateIf<T extends Object?>(
    bool Function(T value) condition, Validator<T> v) {
  return (T value) => condition(value) ? v(value) : null;
}
