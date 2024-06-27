import '../../localization/l10n.dart';
import '../base_validator.dart';

class MaxLengthValidator<T> extends BaseValidator<T> {
  const MaxLengthValidator(
    this.maxLength, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final int maxLength;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.equalLengthErrorText(maxLength);

  @override
  String? validateValue(T valueCandidate) {
    int valueLength = 0;

    if (valueCandidate is String) valueLength = valueCandidate.length;
    if (valueCandidate is Iterable) valueLength = valueCandidate.length;
    if (valueCandidate is Map) valueLength = valueCandidate.length;

    return valueLength > maxLength ? errorText : null;
  }
}
