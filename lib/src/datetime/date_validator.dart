import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template date_validator_template}
/// [DateValidator] extends [BaseValidator] to validate if a string can be parsed into a valid [DateTime] object.
///
/// This validator ensures that the value is a valid date string.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class DateValidator extends BaseValidator<String> {
  /// Constructor for the date string validator.
  const DateValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.dateStringErrorText;

  @override
  String? validateValue(String valueCandidate) {
    final DateTime? date = DateTime.tryParse(valueCandidate);
    if (date == null) {
      return errorText;
    }
    return null;
  }
}
