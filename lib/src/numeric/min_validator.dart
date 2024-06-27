import '../../localization/l10n.dart';
import '../base_validator.dart';

class MinValidator<T> extends BaseValidator<T> {
  MinValidator(
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
  String? validateValue(T? valueCandidate) {
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
