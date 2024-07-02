import 'package:flutter/widgets.dart';

import '../../localization/l10n.dart';
import '../base_validator.dart';

class DefaultValueValidator<T> extends BaseValidator<T> {
  const DefaultValueValidator(this.defaultValue, this.validator)
      : super(checkNullOrEmpty: false);

  final T defaultValue;
  final FormFieldValidator<T> validator;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.requiredErrorText;

  @override
  String? validate(T? valueCandidate) {
    return validateValue(valueCandidate);
  }

  @override
  String? validateValue(T? valueCandidate) {
    return validator.call(valueCandidate ?? defaultValue);
  }
}
