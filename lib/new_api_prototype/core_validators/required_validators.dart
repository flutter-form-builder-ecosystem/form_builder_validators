import '../../localization/l10n.dart';
import '../constants.dart';

/// This function generates a validator that enforces a required field rule. If
/// the input is not provided (i.e., null or empty), the function returns an
/// error message indicating that the field is required. If the input is
/// provided, the function applies an additional validator v (if supplied) to
/// further validate the input.
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

/// This function returns a validator that validates the user input with `v`,
/// replacing null/empty input with `defaultValue`.
Validator<T?> validateWithDefault<T extends Object>(
    T defaultValue, Validator<T> v) {
  return (T? value) => v(value ?? defaultValue);
}

String errorIsOptionalTemporary(String vErrorMessage) {
  return 'The field is optional, otherwise, $vErrorMessage';
}

/// This function generates a validator that marks a field as optional. If the
/// user input is not provided (i.e., it's null or empty), the validator will
/// return null, indicating no validation error. If the input is provided, the
/// function applies an additional validator v (if provided) to further validate
/// the input.
Validator<T?> isOptional<T extends Object>([
  Validator<T>? v,
  String Function(String)? isOptionalMsg,
]) {
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

    return isOptionalMsg?.call(vErrorMessage) ??
        errorIsOptionalTemporary(vErrorMessage);
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
