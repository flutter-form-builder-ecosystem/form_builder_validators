import 'package:flutter/widgets.dart';

import '../../localization/l10n.dart';
import '../base_validator.dart';

class ComposeValidator<T> extends BaseValidator<T> {
  const ComposeValidator(this.validators);

  final List<FormFieldValidator<T>> validators;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.requiredErrorText;

  @override
  String? validateValue(T valueCandidate) {
    for (final FormFieldValidator<T> validator in validators) {
      final String? validatorResult = validator.call(valueCandidate);
      if (validatorResult != null) {
        return validatorResult;
      }
    }
    return null;
  }
}
