import '../../localization/l10n.dart';
import '../base_validator.dart';

class NumericValidator<T> extends BaseValidator<T> {
  NumericValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.numericErrorText;

  @override
  String? validateValue(T? valueCandidate) {
    final num? value;
    switch (T) {
      case String:
        value = num.tryParse(valueCandidate! as String);
      case num:
        value = valueCandidate! as num;
      default:
        return errorText;
    }

    return value == null ? errorText : null;
  }
}
