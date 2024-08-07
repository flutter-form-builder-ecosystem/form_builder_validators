import '../../form_builder_validators.dart';

/// {@template date_past_validator_template}
/// [DatePastValidator] extends [TranslatedValidator] to validate if a date string represents a past date.
///
/// This validator checks if the date parsed from the string is before the current date and time.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class DatePastValidator extends TranslatedValidator<String> {
  /// Constructor for the past date validator.
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
  String? validateValue(String valueCandidate) {
    final DateTime? date = DateTime.tryParse(valueCandidate);
    return date != null && date.isBefore(DateTime.now()) ? null : errorText;
  }
}
