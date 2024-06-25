import '../../localization/l10n.dart';
import '../base_validator.dart';

class MinLengthValidator<T> extends BaseValidator<T> {
  MinLengthValidator(
    this.minLength, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final int minLength;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.minLengthErrorText(minLength);

  @override
  String? validateValue(T? valueCandidate) {
    int valueLength = 0;

    if (valueCandidate is String) valueLength = valueCandidate.length;
    if (valueCandidate is Iterable) valueLength = valueCandidate.length;
    if (valueCandidate is Map) valueLength = valueCandidate.length;

    return valueLength < minLength ? errorText : null;
  }
}
