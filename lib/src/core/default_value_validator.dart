import 'package:flutter/widgets.dart';

import '../../form_builder_validators.dart';

/// {@template default_value_validator_template}
/// [DefaultValueValidator] extends [TranslatedValidator] to validate a value using a default value if the value is null.
///
/// ## Parameters:
///
/// - [defaultValue] The default value to use if the valueCandidate is null.
/// - [validator] The validator to apply to the value or the default value.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty. This is set to false by default.
///
/// {@endtemplate}
class DefaultValueValidator<T> extends BaseValidator<T> {
  /// Constructor for the default value validator.
  const DefaultValueValidator(this.defaultValue, this.validator)
      : super(checkNullOrEmpty: false);

  /// The default value to use if the valueCandidate is null.
  final T defaultValue;

  /// The validator to apply to the value or the default value.
  final FormFieldValidator<T> validator;

  @override
  String? validate(T? valueCandidate) {
    return validateValue(valueCandidate);
  }

  @override
  String? validateValue(T? valueCandidate) {
    return validator.call(valueCandidate ?? defaultValue);
  }
}
