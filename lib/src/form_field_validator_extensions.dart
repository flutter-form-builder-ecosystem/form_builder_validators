import 'package:flutter/material.dart';
import '../form_builder_validators.dart';

extension FormFieldValidatorExtensions<T> on FormFieldValidator<T> {
  /// Combines the current validator with another validator using logical AND.
  FormFieldValidator<T> and(FormFieldValidator<T> other) {
    return FormBuilderValidators.compose([this, other]);
  }

  /// Combines the current validator with another validator using logical OR.
  FormFieldValidator<T> or(FormFieldValidator<T> other) {
    return FormBuilderValidators.or([this, other]);
  }

  /// Adds a condition to apply the validator only if the condition is met.
  FormFieldValidator<T> when(bool Function(T value) condition) {
    return FormBuilderValidators.conditional(condition, this);
  }
}
