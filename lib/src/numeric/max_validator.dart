import '../../form_builder_validators.dart';

/// {@template max_validator_template}
/// [MaxValidator] extends [TranslatedValidator] to validate if a value is less than or equal to a specified maximum value.
///
/// This validator checks if the value is a number or a string that can be parsed into a number and ensures it does not exceed the specified maximum value.
///
/// ## Parameters:
///
/// - [max] The maximum allowable value.
/// - [inclusive] Whether the maximum value is inclusive. Defaults to true.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class MaxValidator<T> extends TranslatedValidator<T> {
  /// Constructor for the maximum value validator.
  const MaxValidator(
    this.max, {
    this.inclusive = true,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The maximum allowable value.
  final num max;

  /// Whether the maximum value is inclusive.
  final bool inclusive;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.maxErrorText(max);

  @override
  String? validateValue(T valueCandidate) {
    final num? value;

    final MaxElementaryValidator<num> maxValidator =
        MaxElementaryValidator<num>(
      max,
      inclusive: inclusive,
      errorText: errorText,
    );
    final IsRequiredElementaryValidator<Object> validator =
        IsRequiredElementaryValidator<Object>(
            withAndComposition: <BaseElementaryValidator<Object, dynamic>>[
          IsNumericElementaryValidator<Object>(
              withAndComposition: [maxValidator])
        ]);

    print(valueCandidate);
    print(validator.validate(valueCandidate));
    return validator.validate(valueCandidate) == null
        ? null
        : maxValidator.errorText;
    if (valueCandidate is String) {
      value = num.tryParse(valueCandidate);
    } else if (valueCandidate is num) {
      value = valueCandidate;
    } else {
      return errorText;
    }

    if (value == null) {
      return errorText;
    }

    if (inclusive) {
      if (value > max) {
        return errorText;
      }
    } else {
      if (value >= max) {
        return errorText;
      }
    }

    return null;
  }
}
