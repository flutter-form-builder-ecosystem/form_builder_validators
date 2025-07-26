import 'package:flutter/widgets.dart';

import '../../form_builder_validators.dart';

/// {@template conditional_validator_template}
/// [ConditionalValidator] extends [BaseValidator] to conditionally validate a value based on a provided condition.
///
/// ## Parameters:
///
/// - [condition] A function that returns a boolean indicating whether the validator should be applied.
/// - [validator] The validator to apply if the condition is met.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty. This is set to false by default.
///
/// {@endtemplate}
class ConditionalValidator<T> extends BaseValidator<T> {
  /// Constructor for the conditional validator.
  const ConditionalValidator(this.condition, this.validator)
    : super(checkNullOrEmpty: false);

  /// A function that returns a boolean indicating whether the validator should be applied.
  final bool Function(T? value) condition;

  /// The validator to apply if the condition is met.
  final FormFieldValidator<T> validator;

  @override
  String? validate(T? valueCandidate) {
    return validateValue(valueCandidate);
  }

  @override
  String? validateValue(T? valueCandidate) {
    if (condition(valueCandidate)) {
      return validator.call(valueCandidate);
    }
    return null;
  }
}
