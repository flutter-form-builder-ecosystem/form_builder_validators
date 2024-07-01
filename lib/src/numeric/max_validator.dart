import '../../localization/l10n.dart';
import '../base_validator.dart';

class MaxValidator<T> extends BaseValidator<T> {
  const MaxValidator(
    this.max, {
    this.inclusive = true,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final num max;

  final bool inclusive;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.maxErrorText(max);

  @override
  String? validateValue(T valueCandidate) {
    final num? value;

    if (valueCandidate is String) {
      value = num.tryParse(valueCandidate);
    } else if (valueCandidate is num) {
      value = valueCandidate;
    } else {
      return errorText;
    }

    if (value == null) {
      return errorText;
    }

    if (inclusive) {
      if (value > max) {
        return errorText;
      }
    } else {
      if (value >= max) {
        return errorText;
      }
    }

    return null;
  }
}
