import '../../localization/l10n.dart';
import '../constants.dart';

/// This function returns a validator that checks if the user input is equal (using
/// the == operator) to either `value`. If the condition is satisfied,
/// the validator returns null, otherwise, it returns
/// `FormBuilderLocalizations.current.equalErrorText(userInput.toString())`, if
/// `equalMsg` is not provided.
///
/// # Error
/// - Throws [AssertionError] if not exactly one of `value` or `dynValue` was
/// provided.
Validator<T> isEqual<T extends Object?>(
  T value, {
  String Function(String)? isEqualMsg,
}) {
  return (T input) {
    final String valueString = value.toString();
    return value == input
        ? null
        : isEqualMsg?.call(valueString) ??
            FormBuilderLocalizations.current.equalErrorText(valueString);
  };
}
