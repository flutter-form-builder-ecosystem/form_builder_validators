import '../../../localization/l10n.dart';
import '../constants.dart';

/// This function returns a validator that checks if the user input is equal (using
/// the == operator) to `value`. If the condition is satisfied,
/// the validator returns null, otherwise, it returns
/// `FormBuilderLocalizations.current.equalErrorText(userInput.toString())`, if
/// `isEqualMsg` is not provided.
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

/// This function returns a validator that checks if the user input is not equal (using
/// the != operator) to `value`. If the condition is satisfied,
/// the validator returns null, otherwise, it returns
/// `FormBuilderLocalizations.current.notEqualErrorText(userInput.toString())`, if
/// `isNotEqualMsg` is not provided.
Validator<T> isNotEqual<T extends Object?>(
  T value, {
  String Function(String)? isNotEqualMsg,
}) {
  return (T input) {
    final String valueString = value.toString();
    return value != input
        ? null
        : isNotEqualMsg?.call(valueString) ??
            FormBuilderLocalizations.current.notEqualErrorText(valueString);
  };
}
