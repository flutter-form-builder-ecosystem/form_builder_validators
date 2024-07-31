import '../../form_builder_validators.dart';

/// {@template unique_validator_template}
/// [UniqueValidator] extends [TranslatedValidator] to validate if a value is unique within a specified list of values.
///
/// ## Parameters:
///
/// - [values] The list of values to check against for uniqueness.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class UniqueValidator<T> extends TranslatedValidator<T> {
  /// Constructor for the unique value validator.
  const UniqueValidator(
    this.values, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The list of values to check against for uniqueness.
  final List<T> values;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.uniqueErrorText;

  @override
  String? validateValue(T valueCandidate) {
    return values.where((T element) => element == valueCandidate).length != 1
        ? errorText
        : null;
  }
}
