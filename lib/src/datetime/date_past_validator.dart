import '../../localization/l10n.dart';
import '../base_validator.dart';

class DatePastValidator extends BaseValidator<String> {
  const DatePastValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.dateMustBeInThePastErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    final DateTime? date = DateTime.tryParse(valueCandidate!);
    return date != null && date.isBefore(DateTime.now()) ? null : errorText;
  }
}
