import '../../form_builder_validators.dart';

/// {@template not_equal_validator_template}
/// [NotEqualValidator] extends [TranslatedValidator] to validate if a value is not equal to a specified value.
///
/// ## Parameters:
///
/// - [value] The value to compare against.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class NotEqualValidator<T> extends TranslatedValidator<T> {
  /// Constructor for the not equal value validator.
  const NotEqualValidator(
    this.value, {

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The value to compare against.
  final Object value;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.notEqualErrorText(value.toString());

  @override
  String? validateValue(T valueCandidate) {
    return valueCandidate == value ? errorText : null;
  }
}
