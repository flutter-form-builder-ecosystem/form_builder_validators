// Composition validators
import '../constants.dart';

// TODO (ArturAssisComp): add the translated 'and' separator error message.
// Something like: FormBuilderLocalizations.current.andSeparator;
const String andSeparatorTemporary = ' and ';

/// This function returns a validator that is an AND composition of `validators`.
/// The composition is done following the order of validators from `validators`.
/// If `printErrorAsSoonAsPossible` is true, it prints the error of the first
/// validator in `validators` that returns an error message. Otherwise, the
/// failure message will be composed in the following way:
/// '$prefix<msg1>$separator<msg2>$separator<msg3>...$separator<msgN>$suffix'.
/// If every validator returns null, this validator also returns null.
///
/// # Parameters
/// - String? `separator`: the separator of each validator failure message when
/// `printErrorAsSoonAsPossible` is false. By default, it is
/// `FormBuilderLocalizations.current.andSeparator`,
///
/// # Errors
/// - Throws [AssertionError] if `validators` is empty.
Validator<T> and<T extends Object>(
  List<Validator<T>> validators, {
  String prefix = '',
  String suffix = '',
  String? separator,
  bool printErrorAsSoonAsPossible = true,
}) {
  assert(validators.isNotEmpty, 'The input validators may not be empty.');
  return (T value) {
    final List<String> errorMessageBuilder = <String>[];
    for (final Validator<T> validator in validators) {
      final String? errorMessage = validator(value);
      if (errorMessage != null) {
        if (printErrorAsSoonAsPossible) {
          return errorMessage;
        }
        errorMessageBuilder.add(errorMessage);
      }
    }
    if (errorMessageBuilder.isNotEmpty) {
      return '$prefix${errorMessageBuilder.join(separator ?? andSeparatorTemporary)}$suffix';
    }

    return null;
  };
}

Validator<T> or<T extends Object>(List<Validator<T>> validators) {
  return (T value) {
    final errorMessageBuilder = <String>[];
    for (final validator in validators) {
      final errorMessage = validator(value);
      if (errorMessage == null) {
        return null;
      }
      errorMessageBuilder.add(errorMessage);
    }
    return errorMessageBuilder.join(' OR ');
  };
}
