import '../../localization/l10n.dart';
import '../base_validator.dart';

class NumericValidator<T> extends BaseValidator<T> {
  const NumericValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.numericErrorText;

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

    return value == null ? errorText : null;
  }
}
