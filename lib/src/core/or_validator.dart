import 'package:flutter/widgets.dart';

import '../base_validator.dart';

/// {@template or_validator_template}
/// [OrValidator] extends [BaseValidator] to validate a value using multiple validators,
/// returning null if at least one of the validators passes.
///
/// ## Parameters:
///
/// - [validators] The list of validators to apply to the value.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty. This is set to false by default.
///
/// {@endtemplate}
class OrValidator<T> extends BaseValidator<T> {
  /// Constructor for the OR validator.
  const OrValidator(this.validators) : super(checkNullOrEmpty: false);

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
    String? errorResult;
    for (final FormFieldValidator<T> validator in validators) {
      final String? validatorResult = validator.call(valueCandidate);
      if (validatorResult == null) {
        return null;
      } else {
        errorResult = validatorResult;
      }
    }
    return errorResult;
  }
}
