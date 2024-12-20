import 'package:flutter/widgets.dart';

import '../constants.dart';

/// {@template debug_print_validator}
/// Creates a validator that logs input values to stdout before optionally applying
/// another validator.
///
/// ## Example
/// ```dart
/// final validator = debugPrintValidator<String>(
///   next: validateEmail,
///   logOnInput: (value) => 'Email input: $value',
/// );
/// ```
///
/// ## Parameters
/// - `next`: Optional validator to apply after logging
/// - `logOnInput`: Optional function to customize log message format
///
/// ## Returns
/// - `null` if no `next` validator or if validation passes
/// - Validation failure from `next` validator if validation fails
///
/// ## Type Parameters
/// - `T`: Type of value being validated, may be a nullable Object
/// {@endtemplate}
Validator<T> debugPrintValidator<T extends Object?>(
    {Validator<T>? next, String Function(T)? logOnInput}) {
  return (T value) {
    debugPrint(logOnInput?.call(value) ?? value.toString());
    return next?.call(value);
  };
}
