import 'package:flutter/widgets.dart';

import '../../form_builder_validators.dart';

/// {@template password_validator_template}
/// [PasswordValidator] extends [BaseValidator] to validate if a string meets specified password requirements.
///
/// This validator checks the password for minimum length, maximum length, and the presence of uppercase, lowercase, numeric,
/// and special characters based on the provided constraints.
///
/// ## Parameters:
///
/// - [minLength] The minimum length of the password. Defaults to 8.
/// - [maxLength] The maximum length of the password. Defaults to 32.
/// - [minUppercaseCount] The minimum number of uppercase characters required. Defaults to 1.
/// - [minLowercaseCount] The minimum number of lowercase characters required. Defaults to 1.
/// - [minNumberCount] The minimum number of numeric characters required. Defaults to 1.
/// - [minSpecialCharCount] The minimum number of special characters required. Defaults to 1.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class PasswordValidator extends BaseValidator<String> {
  /// Constructor for the password validator.
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

  /// The minimum length of the password.
  final int minLength;

  /// The maximum length of the password.
  final int maxLength;

  /// The minimum number of uppercase characters required.
  final int minUppercaseCount;

  /// The minimum number of lowercase characters required.
  final int minLowercaseCount;

  /// The minimum number of numeric characters required.
  final int minNumberCount;

  /// The minimum number of special characters required.
  final int minSpecialCharCount;

  @override
  String? validateValue(String valueCandidate) {
    final String? result =
        FormBuilderValidators.compose<String>(<FormFieldValidator<String>>[
          FormBuilderValidators.minLength(minLength),
          FormBuilderValidators.maxLength(maxLength),
          if (minUppercaseCount > 0)
            FormBuilderValidators.hasUppercaseChars(atLeast: minUppercaseCount),
          if (minLowercaseCount > 0)
            FormBuilderValidators.hasLowercaseChars(atLeast: minLowercaseCount),
          if (minNumberCount > 0)
            FormBuilderValidators.hasNumericChars(atLeast: minNumberCount),
          if (minSpecialCharCount > 0)
            FormBuilderValidators.hasSpecialChars(atLeast: minSpecialCharCount),
        ]).call(valueCandidate);
    return result != null ? errorText ?? result : null;
  }
}
