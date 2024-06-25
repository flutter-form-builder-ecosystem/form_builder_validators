import '../../localization/l10n.dart';
import '../base_validator.dart';

class MaxLengthValidator<T> extends BaseValidator<T> {
  MaxLengthValidator(
    this.maxLength, {
    super.errorText,
    super.checkNullOrEmpty,
  });

  final int maxLength;

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

    return valueLength > maxLength
        ? errorText ??
            FormBuilderLocalizations.current.maxLengthErrorText(maxLength)
        : null;
  }
}
