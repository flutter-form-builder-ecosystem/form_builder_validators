import 'package:flutter/widgets.dart';

import '../base_validator.dart';

/// {@template aggregate_validator_template}
/// [AggregateValidator] extends [BaseValidator] to validate a value using a list of multiple validators.
///
/// ## Parameters:
///
/// - [validators] The list of validators to apply to the value.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty. This is set to false by default.
///
/// {@endtemplate}
class AggregateValidator<T> extends BaseValidator<T> {
  /// Constructor for the aggregate validator.
  const AggregateValidator(this.validators) : super(checkNullOrEmpty: false);

  /// The list of validators to apply to the value.
  final List<FormFieldValidator<T>> validators;

  // coverage:ignore-start
  @override
  String get translatedErrorText => '';
  // coverage:ignore-end

  @override
  String? validate(T? valueCandidate) {
    return validateValue(valueCandidate);
  }

  @override
  String? validateValue(T? valueCandidate) {
    final List<String> errors = <String>[];
    for (final FormFieldValidator<T?> validator in validators) {
      final String? error = validator(valueCandidate);
      if (error != null) {
        errors.add(error);
      }
    }
    return errors.isNotEmpty ? errors.join('\n') : null;
  }
}
