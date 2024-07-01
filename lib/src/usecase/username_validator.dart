import 'package:flutter/widgets.dart';

import '../../form_builder_validators.dart';

class UsernameValidator extends BaseValidator<String> {
  const UsernameValidator({
    this.minLength = 3,
    this.maxLength = 32,
    this.allowNumbers = true,
    this.allowUnderscore = false,
    this.allowDots = false,
    this.allowDash = false,
    this.allowSpace = false,
    this.allowSpecialChar = false,

    /// {@macro username_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final int minLength;

  final int maxLength;

  final bool allowNumbers;

  final bool allowUnderscore;

  final bool allowDots;

  final bool allowDash;

  final bool allowSpace;

  final bool allowSpecialChar;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.requiredErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return FormBuilderValidators.compose<String>(
      <FormFieldValidator<String>>[
        FormBuilderValidators.minLength(minLength, errorText: errorText),
        FormBuilderValidators.maxLength(maxLength, errorText: errorText),
        if (!allowNumbers)
          FormBuilderValidators.matchNot(
            RegExp('[0-9]'),
            errorText: errorText,
          ),
        if (!allowUnderscore)
          FormBuilderValidators.matchNot(
            RegExp('_'),
            errorText: errorText,
          ),
        if (!allowDots)
          FormBuilderValidators.matchNot(
            RegExp(r'\.'),
            errorText: errorText,
          ),
        if (!allowDash)
          FormBuilderValidators.matchNot(
            RegExp('-'),
            errorText: errorText,
          ),
        if (!allowSpace)
          FormBuilderValidators.matchNot(
            RegExp(r'\s'),
            errorText: errorText,
          ),
        if (!allowSpecialChar)
          FormBuilderValidators.matchNot(
            RegExp(r'[!@#\$%^&*(),.?":{}|<>]'),
            errorText: errorText,
          ),
      ],
    ).call(valueCandidate);
  }
}
