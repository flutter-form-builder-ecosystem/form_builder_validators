import 'package:flutter/widgets.dart';

import '../../form_builder_validators.dart';

/// {@template skip_when_validator_template}
/// [SkipWhenValidator] extends [TranslatedValidator] to conditionally skip validation based on a provided condition.
///
/// ## Parameters:
///
/// - [condition] A function that returns a boolean indicating whether the validator should be skipped.
/// - [validator] The validator to apply if the condition is not met.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty. This is set to false by default.
///
/// {@endtemplate}
class SkipWhenValidator<T> extends BaseValidator<T> {
  /// Constructor for the skip when validator.
  const SkipWhenValidator(
    this.condition,
    this.validator,
  ) : super(checkNullOrEmpty: false);

  /// A function that returns a boolean indicating whether the validator should be skipped.
  final bool Function(T? value) condition;

  /// The validator to apply if the condition is not met.
  final FormFieldValidator<T> validator;

  @override
  String? validate(T? valueCandidate) {
    return validateValue(valueCandidate);
  }

  @override
  String? validateValue(T? valueCandidate) {
    if (condition(valueCandidate)) {
      return null;
    }
    return validator(valueCandidate);
  }
}
