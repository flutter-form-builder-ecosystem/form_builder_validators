import '../../form_builder_validators.dart';

/// {@template contains_element_validator_template}
/// [ContainsElementValidator] extends [TranslatedValidator] to validate if a value is
/// contained within a specified list of values.
///
/// ## Parameters:
///
/// - [values] The list of values to check against.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class ContainsElementValidator<T> extends TranslatedValidator<T> {
  /// Constructor for the contains element validator.
  const ContainsElementValidator(
    this.values, {

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The list of values to check against.
  final List<T> values;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsElementErrorText;

  @override
  String? validateValue(T valueCandidate) {
    return values.contains(valueCandidate) ? null : errorText;
  }
}
