import '../../localization/l10n.dart';
import '../base_validator.dart';

class EqualLengthValidator<T> extends BaseValidator<T> {
  const EqualLengthValidator(
    this.length, {
    this.allowEmpty = false,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final int length;

  final bool allowEmpty;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.equalLengthErrorText(length);

  @override
  String? validateValue(T? valueCandidate) {
    int valueLength = 0;

    if (valueCandidate is String) valueLength = valueCandidate.length;
    if (valueCandidate is Iterable) valueLength = valueCandidate.length;
    if (valueCandidate is Map) valueLength = valueCandidate.length;

    return valueLength != length && (!allowEmpty || valueLength > 0)
        ? errorText
        : null;
  }
}
