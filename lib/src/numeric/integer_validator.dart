import '../../form_builder_validators.dart';

/// {@template integer_validator_template}
/// [IntegerValidator] extends [TranslatedValidator] to validate if a string represents a valid integer.
///
/// This validator checks if the provided string can be parsed into an integer with an optional radix.
///
/// ## Parameters:
///
/// - [radix] The base to use for parsing the integer. Defaults to 10 if not specified.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class IntegerValidator extends TranslatedValidator<String> {
  /// Constructor for the integer validator.
  const IntegerValidator({
    this.radix,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The base to use for parsing the integer.
  final int? radix;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.integerErrorText;

  @override
  String? validateValue(String valueCandidate) {
    final int? number = int.tryParse(valueCandidate, radix: radix);
    if (number == null) {
      return errorText;
    }
    return null;
  }
}
