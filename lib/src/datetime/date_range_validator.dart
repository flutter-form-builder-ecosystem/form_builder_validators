import '../../localization/l10n.dart';
import '../base_validator.dart';

class DateRangeValidator extends BaseValidator<String> {
  const DateRangeValidator(
    this.minDate,
    this.maxDate, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final DateTime minDate;

  final DateTime maxDate;

  @override
  String get translatedErrorText => FormBuilderLocalizations.current
      .dateRangeErrorText(minDate.toString(), maxDate.toString());

  @override
  String? validateValue(String valueCandidate) {
    final DateTime? date = DateTime.tryParse(valueCandidate);
    if (date == null || date.isBefore(minDate) || date.isAfter(maxDate)) {
      return errorText;
    }

    return null;
  }
}
