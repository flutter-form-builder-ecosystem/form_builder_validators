import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template date_range_validator_template}
/// [DateRangeValidator] extends [BaseValidator] to validate if a date string falls within a specified date range.
///
/// This validator checks if the date parsed from the string is between the specified minimum and maximum dates.
///
/// ## Parameters:
///
/// - [minDate] The minimum date of the range.
/// - [maxDate] The maximum date of the range.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class DateRangeValidator extends BaseValidator<String> {
  /// Constructor for the date range validator.
  const DateRangeValidator(
    this.minDate,
    this.maxDate, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The minimum date of the range.
  final DateTime minDate;

  /// The maximum date of the range.
  final DateTime maxDate;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.dateRangeErrorText(minDate, maxDate);

  @override
  String? validateValue(String valueCandidate) {
    final DateTime? date = DateTime.tryParse(valueCandidate);
    if (date == null || date.isBefore(minDate) || date.isAfter(maxDate)) {
      return errorText;
    }
    return null;
  }
}
