import '../localization/l10n.dart';
import 'constants.dart';

Validator<T?> isRequired<T extends Object>(
  Validator<T>? v, {
  String? isRequiredMsg,
}) {
  String? finalValidator(T? value) {
    final (isValid, transformedValue) = _isRequiredValidateAndConvert(value);
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
    final (isValid, transformedValue) = _isRequiredValidateAndConvert(value);
    if (!isValid) {
      // field not provided
      return null;
    }
    final vErrorMessage = v?.call(transformedValue!);
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
