// Composition validators
import 'constants.dart';

Validator<T> and<T extends Object>(
  List<Validator<T>> validators, {
  bool printErrorAsSoonAsPossible = true,
}) {
  return (T value) {
    final errorMessageBuilder = <String>[];
    for (final validator in validators) {
      final errorMessage = validator(value);
      if (errorMessage != null) {
        if (printErrorAsSoonAsPossible) {
          return errorMessage;
        }
        errorMessageBuilder.add(errorMessage);
      }
    }
    if (errorMessageBuilder.isNotEmpty) {
      return errorMessageBuilder.join(' AND ');
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
