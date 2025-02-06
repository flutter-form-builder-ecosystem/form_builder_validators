import '../../../localization/l10n.dart';
import '../constants.dart';

/// {@macro validator_is_required}
Validator<T?> isRequired<T extends Object>([
  Validator<T>? next,
  String? isRequiredMsg,
]) {
  String? finalValidator(T? value) {
    final (bool isValid, T? transformedValue) =
        _isRequiredValidateAndConvert(value);
    if (!isValid) {
      return isRequiredMsg ??
          FormBuilderLocalizations.current.requiredErrorText;
    }
    return next?.call(transformedValue!);
  }

  return finalValidator;
}

/// {@macro validator_validate_with_default}
Validator<T?> validateWithDefault<T extends Object>(
    T defaultValue, Validator<T> next) {
  return (T? value) => next(value ?? defaultValue);
}

/// {@macro validator_is_optional}
Validator<T?> isOptional<T extends Object>([
  Validator<T>? next,
  String Function(T input, String nextErrorMsg)? isOptionalMsg,
]) {
  return (T? input) {
    final (bool isValid, T? transformedValue) =
        _isRequiredValidateAndConvert(input);
    if (!isValid) {
      // field not provided
      return null;
    }
    final String? nextErrorMessage = next?.call(transformedValue!);
    if (nextErrorMessage == null) {
      return null;
    }

    return isOptionalMsg?.call(input!, nextErrorMessage) ??
        FormBuilderLocalizations.current.isOptionalErrorText(nextErrorMessage);
  };
}

(bool, T?) _isRequiredValidateAndConvert<T extends Object>(T? value) {
  if (value != null &&
      (value is! String || value.trim().isNotEmpty) &&
      (value is! Iterable || value.isNotEmpty) &&
      (value is! Map || value.isNotEmpty)) {
    return (true, value);
  }
  return (false, null);
}
