import 'package:flutter/widgets.dart';

import '../../form_builder_validators.dart';

class PasswordValidator extends BaseValidator<String> {
  const PasswordValidator({
    this.minLength = 8,
    this.maxLength = 32,
    this.minUppercaseCount = 1,
    this.minLowercaseCount = 1,
    this.minNumberCount = 1,
    this.minSpecialCharCount = 1,

    /// {@macro password_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final int minLength;

  final int maxLength;

  final int minUppercaseCount;

  final int minLowercaseCount;

  final int minNumberCount;

  final int minSpecialCharCount;

  @override
  String get translatedErrorText => '';

  @override
  String? validateValue(String valueCandidate) {
    final String? result = FormBuilderValidators.compose<String>(
      <FormFieldValidator<String>>[
        FormBuilderValidators.minLength(minLength),
        FormBuilderValidators.maxLength(maxLength),
        if (minUppercaseCount > 0)
          FormBuilderValidators.hasUppercaseChars(
            atLeast: minUppercaseCount,
          ),
        if (minLowercaseCount > 0)
          FormBuilderValidators.hasLowercaseChars(
            atLeast: minLowercaseCount,
          ),
        if (minNumberCount > 0)
          FormBuilderValidators.hasNumericChars(
            atLeast: minNumberCount,
          ),
        if (minSpecialCharCount > 0)
          FormBuilderValidators.hasSpecialChars(
            atLeast: minSpecialCharCount,
          ),
      ],
    ).call(valueCandidate);
    return result != null && errorText != '' ? errorText : result;
  }
}
