import 'package:flutter/widgets.dart';

import '../../localization/l10n.dart';
import '../base_validator.dart';

class OrValidator<T> extends BaseValidator<T> {
  const OrValidator(
    this.validators, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final List<FormFieldValidator<T>> validators;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.requiredErrorText;

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
