// Compose validators
import '../../../localization/l10n.dart';
import '../constants.dart';

/// {@macro validator_and}
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

/// {@macro validator_or}
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
