import '../../form_builder_validators.dart';

/// {@template date_time_validator_template}
/// [DateTimeValidator] extends [TranslatedValidator] to validate if a value is a valid [DateTime] object.
///
/// This validator ensures that the value is not null and is a valid [DateTime] instance.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class DateTimeValidator extends TranslatedValidator<DateTime?> {
  /// Constructor for the DateTime validator.
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
