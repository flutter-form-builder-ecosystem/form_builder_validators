import 'package:flutter/widgets.dart';

import '../../localization/l10n.dart';
import '../base_validator.dart';

class TransformValidator<T> extends BaseValidator<T> {
  const TransformValidator(
    this.transformer,
    this.validator,
  );

  final T Function(T? value) transformer;

  final FormFieldValidator<T> validator;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.requiredErrorText;

  @override
  String? validateValue(T? valueCandidate) {
    final T transformedValue = transformer(valueCandidate);
    return validator(transformedValue);
  }
}
