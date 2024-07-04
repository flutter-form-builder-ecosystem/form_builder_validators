import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template date_future_validator_template}
/// [DateFutureValidator] extends [BaseValidator] to validate if a date string represents a future date.
///
/// This validator checks if the date parsed from the string is after the current date and time.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class DateFutureValidator extends BaseValidator<String> {
  /// Constructor for the future date validator.
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
