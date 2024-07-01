import '../../localization/l10n.dart';
import '../base_validator.dart';

class DateFutureValidator extends BaseValidator<String> {
  const DateFutureValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.dateMustBeInTheFutureErrorText;

  @override
  String? validateValue(String valueCandidate) {
    final DateTime? date = DateTime.tryParse(valueCandidate);
    return date != null && date.isAfter(DateTime.now()) ? null : errorText;
  }
}
