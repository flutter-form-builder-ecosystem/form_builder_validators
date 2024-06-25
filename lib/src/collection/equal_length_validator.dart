import '../../localization/l10n.dart';
import '../base_validator.dart';

class EqualLengthValidator<T> extends BaseValidator<T> {
  EqualLengthValidator(
    this.length, {
    this.allowEmpty = false,
    super.errorText,
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

    if (valueCandidate is String) {
      valueLength = valueCandidate.length;
    } else if (valueCandidate is Iterable) {
      valueLength = valueCandidate.length;
    } else if (valueCandidate is Map) {
      valueLength = valueCandidate.length;
    }

    return valueLength != length && (!allowEmpty || valueLength > 0)
        ? errorText
        : null;
  }
}
