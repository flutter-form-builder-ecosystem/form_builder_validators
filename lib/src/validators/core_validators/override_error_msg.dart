import '../constants.dart';

/// Replaces any inner error message with [errorMsg]. It is useful for changing
/// the error message of direct validator implementations.
Validator<T> overrideErrorMsg<T extends Object?>(
  String errorMsg,
  Validator<T> v,
) {
  return (T value) {
    final String? vErrorMessage = v(value);
    if (vErrorMessage != null) {
      return errorMsg;
    }
    return null;
  };
}
