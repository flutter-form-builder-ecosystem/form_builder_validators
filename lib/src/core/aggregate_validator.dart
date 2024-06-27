import 'package:flutter/widgets.dart';

import '../../localization/l10n.dart';
import '../base_validator.dart';

class AggregateValidator<T> extends BaseValidator<T> {
  const AggregateValidator(this.validators);

  final List<FormFieldValidator<T>> validators;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.requiredErrorText;

  @override
  String? validateValue(T valueCandidate) {
    final List<String> errors = <String>[];
    for (final FormFieldValidator<T> validator in validators) {
      final String? error = validator(valueCandidate);
      if (error != null) {
        errors.add(error);
      }
    }
    return errors.isNotEmpty ? errors.join('\n') : null;
  }
}
