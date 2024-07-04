import 'package:flutter/widgets.dart';

import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template compose_validator_template}
/// [ComposeValidator] extends [BaseValidator] to validate a value using a list of validators,
/// returning the first validation error encountered.
///
/// ## Parameters:
///
/// - [validators] The list of validators to apply to the value.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty. This is set to false by default.
///
/// {@endtemplate}
class ComposeValidator<T> extends BaseValidator<T> {
  /// Constructor for the compose validator.
  const ComposeValidator(this.validators) : super(checkNullOrEmpty: false);

  /// The list of validators to apply to the value.
  final List<FormFieldValidator<T>> validators;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.requiredErrorText;

  @override
  String? validate(T? valueCandidate) {
    return validateValue(valueCandidate);
  }

  @override
  String? validateValue(T? valueCandidate) {
    for (final FormFieldValidator<T> validator in validators) {
      final String? validatorResult = validator.call(valueCandidate);
      if (validatorResult != null) {
        return validatorResult;
      }
    }
    return null;
  }
}
