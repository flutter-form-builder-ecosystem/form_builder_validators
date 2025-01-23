// Compose validators
import '../../../localization/l10n.dart';
import '../constants.dart';

/// {@template validator_and}
/// Creates a composite validator that applies multiple validation rules from
/// `validators` using AND logic.
///
/// The validator executes each validation rule in sequence and handles errors
/// in one of two modes:
///
/// 1. Fast-fail mode (`printErrorAsSoonAsPossible = true`):
///    - Returns the first encountered error message
///    - Stops validation after first failure
///
/// 2. Aggregate mode (`printErrorAsSoonAsPossible = false`):
///    - Collects all error messages
///    - Combines them as: `prefix + msg1 + separator + msg2 + ... + msgN + suffix`
///
/// Returns `null` if all validations pass.
///
/// ## Example
/// ```dart
/// final validator = and([
///   isEmail,
///   fromGmail,
/// ], separator: ' * ');
/// ```
///
/// ## Parameters
/// - `validators`: List of validation functions to apply
/// - `prefix`: String to prepend to combined error message (default: '')
/// - `suffix`: String to append to combined error message (default: '')
/// - `separator`: String between error messages
/// (default: FormBuilderLocalizations.current.andSeparator)
/// - `printErrorAsSoonAsPossible`: Whether to return first error or combine all
/// (default: true)
///
/// ## Returns
/// - `null` if all validation passes
/// - Validation failure message, otherwise
///
/// ## Throws
/// - [ArgumentError] if `validators` is empty
/// {@endtemplate}
Validator<T> and<T extends Object>(
  List<Validator<T>> validators, {
  String prefix = '',
  String suffix = '',
  String? separator,
  bool printErrorAsSoonAsPossible = true,
}) {
  if (validators.isEmpty) {
    throw ArgumentError.value(
        '[]', 'validators', 'The list of validators must not be empty');
  }
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
      return '$prefix${errorMessageBuilder.join(separator ?? FormBuilderLocalizations.current.andSeparator)}$suffix';
    }

    return null;
  };
}

/// {@template validator_or}
/// Creates a composite validator that applies multiple validation rules from
/// `validators` using OR logic.
///
/// The validator executes each validation rule in sequence until one passes
/// (returns null) or all fail. If all validators fail, their error messages
/// are combined as: `prefix + msg1 + separator + msg2 + ... + msgN + suffix`
///
/// ## Example
/// ```dart
/// final validator = or([
///   isGmail,
///   isYahoo,
/// ], separator: ' + ');
/// ```
///
/// ## Parameters
/// - `validators`: List of validation functions to apply
/// - `prefix`: String to prepend to combined error message (default: '')
/// - `suffix`: String to append to combined error message (default: '')
/// - `separator`: String between error messages
/// (default: FormBuilderLocalizations.current.orSeparator)
///
/// ## Returns
/// - `null` if any validation passes
/// - Combined error message if all validations fail
///
/// ## Throws
/// - [ArgumentError] if `validators` is empty
/// {@endtemplate}
Validator<T> or<T extends Object>(
  List<Validator<T>> validators, {
  String prefix = '',
  String suffix = '',
  String? separator,
}) {
  if (validators.isEmpty) {
    throw ArgumentError.value(
        '[]', 'validators', 'The list of validators must not be empty');
  }
  return (T value) {
    final List<String> errorMessageBuilder = <String>[];
    for (final Validator<T> validator in validators) {
      final String? errorMessage = validator(value);
      if (errorMessage == null) {
        return null;
      }
      errorMessageBuilder.add(errorMessage);
    }
    return '$prefix${errorMessageBuilder.join(separator ?? FormBuilderLocalizations.current.orSeparator)}$suffix';
  };
}
