import 'package:flutter/material.dart';
import '../form_builder_validators.dart';

extension FormFieldValidatorExtensions<T> on FormFieldValidator<T> {
  /// Combines the current validator with another validator using logical AND.
  FormFieldValidator<T> and(FormFieldValidator<T> other) {
    return FormBuilderValidators.compose(<FormFieldValidator<T>>[this, other]);
  }

  /// Combines the current validator with another validator using logical OR.
  FormFieldValidator<T> or(FormFieldValidator<T> other) {
    return FormBuilderValidators.or(<FormFieldValidator<T>>[this, other]);
  }

  /// Negates the current validator.
  FormFieldValidator<T> not() {
    return FormBuilderValidators.notEqual(this);
  }

  /// Adds a condition to apply the validator only if the condition is met.
  FormFieldValidator<T> when(bool Function(T value) condition) {
    return FormBuilderValidators.conditional(condition, this);
  }

  /// Adds a condition to apply the validator only if the condition is not met.
  FormFieldValidator<T> unless(bool Function(T value) condition) {
    return FormBuilderValidators.conditional(
      (T value) => !condition(value),
      this,
    );
  }

  /// Transforms the value before applying the validator.
  FormFieldValidator<T> transform(T Function(T? value) transformer) {
    return FormBuilderValidators.transform(this, transformer);
  }

  /// Skips the validator if the condition is met.
  FormFieldValidator<T> skipWhen(bool Function(T? value) condition) {
    return FormBuilderValidators.skipWhen(condition, this);
  }

  /// Logs the value during the validation process.
  FormFieldValidator<T> log({String Function(T? value)? log}) {
    return FormBuilderValidators.log(log: log);
  }

  /// Overrides the error message of the current validator.
  FormFieldValidator<T> withErrorMessage(String errorMessage) {
    return (T? valueCandidate) {
      final String? result = this(valueCandidate);
      return result != null ? errorMessage : null;
    };
  }
}
