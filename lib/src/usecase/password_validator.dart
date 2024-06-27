import 'package:flutter/widgets.dart';

import '../../form_builder_validators.dart';
import '../base_validator.dart';

class PasswordValidator extends BaseValidator<String> {
  const PasswordValidator({
    this.minLength = 8,
    this.maxLength = 32,
    this.uppercase = 1,
    this.lowercase = 1,
    this.number = 1,
    this.specialChar = 1,

    /// {@macro password_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final int minLength;

  final int maxLength;

  final int uppercase;

  final int lowercase;

  final int number;

  final int specialChar;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.requiredErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    return FormBuilderValidators.compose<String>(
      <FormFieldValidator<String>>[
        FormBuilderValidators.minLength(minLength, errorText: errorText),
        FormBuilderValidators.maxLength(maxLength, errorText: errorText),
        if (uppercase > 0)
          FormBuilderValidators.hasUppercaseChars(
            atLeast: uppercase,
            errorText: errorText,
          ),
        if (lowercase > 0)
          FormBuilderValidators.hasLowercaseChars(
            atLeast: lowercase,
            errorText: errorText,
          ),
        if (number > 0)
          FormBuilderValidators.hasNumericChars(
            atLeast: number,
            errorText: errorText,
          ),
        if (specialChar > 0)
          FormBuilderValidators.hasSpecialChars(
            atLeast: specialChar,
            errorText: errorText,
          ),
      ],
    ).call(valueCandidate);
  }
}
