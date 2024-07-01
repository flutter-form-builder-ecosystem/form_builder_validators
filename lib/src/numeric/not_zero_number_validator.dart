import '../../localization/l10n.dart';
import '../base_validator.dart';

class NotZeroNumberValidator<T> extends BaseValidator<T> {
  const NotZeroNumberValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.notZeroNumberErrorText;

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

    if (value == 0) {
      return errorText;
    }

    return null;
  }
}
