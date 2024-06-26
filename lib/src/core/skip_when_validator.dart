import 'package:flutter/widgets.dart';

import '../../localization/l10n.dart';
import '../base_validator.dart';

class SkipWhenValidator<T> extends BaseValidator<T> {
  const SkipWhenValidator(
    this.condition,
    this.validator,
  );

  final bool Function(T? value) condition;

  final FormFieldValidator<T> validator;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.requiredErrorText;

  @override
  String? validateValue(T? valueCandidate) {
    if (condition(valueCandidate)) {
      return null;
    }
    return validator(valueCandidate);
  }
}
