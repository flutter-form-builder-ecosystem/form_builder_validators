import 'constants.dart';

/// Replaces any inner message with [errorMsg]. It is useful for changing
/// the message of direct validator implementations.
Validator<T> overrideErrorMsg<T extends Object?>(
  String errorMsg,
  Validator<T> v,
) {
  return (value) {
    final vErrorMessage = v(value);
    if (vErrorMessage != null) {
      return errorMsg;
    }
    return null;
  };
}
