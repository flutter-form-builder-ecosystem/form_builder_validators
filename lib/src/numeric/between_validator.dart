import '../../localization/l10n.dart';
import '../base_validator.dart';

class BetweenValidator extends BaseValidator<num> {
  const BetweenValidator(
    this.min,
    this.max, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final num min;
  final num max;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.betweenErrorText(min, max);

  @override
  String? validateValue(num valueCandidate) {
    final num value = valueCandidate;
    if (value < min || value > max) {
      return errorText;
    }

    return null;
  }
}
