import '../../localization/l10n.dart';
import '../constants.dart';

/// This function returns a transformer validator that checks if the user input
/// is neither null nor empty, in the case it is a collection, a string or a map.
/// If the condition was not satisfied, it returns the `isRequiredMsg` error message,
/// if provided, or ´FormBuilderLocalizations.current.requiredErrorText´ otherwise.
/// If the condition is satisfied, it returns the validation of the input with
/// `v` or null if `v` was not provided.
Validator<T?> isRequired<T extends Object>([
  Validator<T>? v,
  String? isRequiredMsg,
]) {
  String? finalValidator(T? value) {
    final (bool isValid, T? transformedValue) =
        _isRequiredValidateAndConvert(value);
    if (!isValid) {
      return isRequiredMsg ??
          FormBuilderLocalizations.current.requiredErrorText;
    }
    return v?.call(transformedValue!);
  }

  return finalValidator;
}

Validator<T?> isOptional<T extends Object>(
  Validator<T>? v, {
  String? isOptionalMsg,
}) {
  String? finalValidator(T? value) {
    final (bool isValid, T? transformedValue) =
        _isRequiredValidateAndConvert(value);
    if (!isValid) {
      // field not provided
      return null;
    }
    final String? vErrorMessage = v?.call(transformedValue!);
    if (vErrorMessage == null) {
      return null;
    }

    return 'The field is optional, otherwise, $vErrorMessage';
  }

  return finalValidator;
}

const isReq = isRequired;
const isOpt = isOptional;

(bool, T?) _isRequiredValidateAndConvert<T extends Object>(T? value) {
  if (value != null &&
      (value is! String || value.trim().isNotEmpty) &&
      (value is! Iterable || value.isNotEmpty) &&
      (value is! Map || value.isNotEmpty)) {
    return (true, value);
  }
  return (false, null);
}
