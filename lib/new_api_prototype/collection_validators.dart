import '../localization/l10n.dart';
import 'constants.dart';

Validator<T> minLength<T extends Object>(int minLength,
    {String Function(int)? minLengthMsg}) {
  return (value) {
    // I think it makes more sense to say that scalar objects has length 1 instead of 0.
    int valueLength = 1;

    if (value is String) valueLength = value.length;
    if (value is Iterable) valueLength = value.length;
    if (value is Map) valueLength = value.length;

    return valueLength < minLength
        ? minLengthMsg?.call(minLength) ??
            FormBuilderLocalizations.current.minLengthErrorText(minLength)
        : null;
  };
}

Validator<T> maxLength<T extends Object>(int maxLength,
    {String Function(int)? maxLengthMsg}) {
  return (value) {
    // I think it makes more sense to say that scalar objects has length 1 instead of 0.
    int valueLength = 1;

    if (value is String) valueLength = value.length;
    if (value is Iterable) valueLength = value.length;
    if (value is Map) valueLength = value.length;

    return valueLength > maxLength
        ? maxLengthMsg?.call(maxLength) ??
            FormBuilderLocalizations.current.maxLengthErrorText(maxLength)
        : null;
  };
}
