import '../../localization/l10n.dart';
import '../constants.dart';

/// This function returns a validator that checks if the user input is equal (using
/// the == operator) to either `value` or `dynValue()`. If the condition is satisfied,
/// the validator returns null, otherwise, it returns
/// `FormBuilderLocalizations.current.equalErrorText(userInput.toString())`, if
/// `equalMsg` is not provided.
///
/// # Parameters
/// Exactly one of the inputs `value` or `dynValue` must be provided. If the value
/// to be compared with is static, provide `value`. Otherwise, provide `dynValue`.
///
/// # Error
/// - Throws [AssertionError] if not exactly one of `value` or `dynValue` was
/// provided.
Validator<T> isEqual<T extends Object?>(
  T? value, {
  T Function()? dynValue,
  String Function(String)? equalMsg,
}) {
  assert(
      (value != null && dynValue == null) ||
          (value == null && dynValue != null),
      'Exactly one of "value" or "dynValue" must be provided');
  return (T input) {
    final T? currentValue = value ?? dynValue?.call();
    final String valueString = currentValue!.toString();
    return currentValue == input
        ? null
        : equalMsg?.call(valueString) ??
            FormBuilderLocalizations.current.equalErrorText(valueString);
  };
}
