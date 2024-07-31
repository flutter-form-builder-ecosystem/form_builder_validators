import 'package:flutter/widgets.dart';

import '../../form_builder_validators.dart';

/// {@template transform_validator_template}
/// [TransformValidator] extends [TranslatedValidator] to transform a value before applying a validator.
///
/// ## Parameters:
///
/// - [transformer] A function that transforms the value before validation.
/// - [validator] The validator to apply to the transformed value.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty. This is set to false by default.
///
/// {@endtemplate}
class TransformValidator<T> extends BaseValidator<T> {
  /// Constructor for the transform validator.
  const TransformValidator(
    this.transformer,
    this.validator,
  ) : super(checkNullOrEmpty: false);

  /// A function that transforms the value before validation.
  final T? Function(T? value) transformer;

  /// The validator to apply to the transformed value.
  final FormFieldValidator<T> validator;

  @override
  String? validate(T? valueCandidate) {
    return validateValue(valueCandidate);
  }

  @override
  String? validateValue(T? valueCandidate) {
    final T? transformedValue = transformer(valueCandidate);
    return validator(transformedValue);
  }
}
