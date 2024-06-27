import '../../localization/l10n.dart';
import '../base_validator.dart';

class MaxValidator<T> extends BaseValidator<T> {
  MaxValidator(
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
    final num value;
    switch (T) {
      case String:
        value = num.tryParse(valueCandidate! as String)!;
      case num:
        value = valueCandidate! as num;
      default:
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
