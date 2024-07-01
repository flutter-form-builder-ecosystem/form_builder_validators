import '../../localization/l10n.dart';
import '../base_validator.dart';

class DateTimeValidator extends BaseValidator<DateTime?> {
  const DateTimeValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.dateStringErrorText;

  @override
  String? validateValue(DateTime? valueCandidate) {
    if (valueCandidate == null) {
      return errorText;
    }

    return null;
  }
}
