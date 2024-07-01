import '../../localization/l10n.dart';
import '../base_validator.dart';

class MinValidator<T> extends BaseValidator<T> {
  const MinValidator(
    this.min, {
    this.inclusive = true,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final num min;

  final bool inclusive;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.minErrorText(min);

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
      if (value < min) {
        return errorText;
      }
    } else {
      if (value <= min) {
        return errorText;
      }
    }

    return null;
  }
}
