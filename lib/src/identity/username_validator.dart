import '../../form_builder_validators.dart';

/// {@template username_validator_template}
/// [UsernameValidator] extends [BaseValidator] to validate if a string meets specified username requirements.
///
/// This validator checks the username for minimum length, maximum length, and the presence or absence of numbers,
/// underscores, dots, dashes, spaces, and special characters based on the provided constraints.
///
/// ## Parameters:
///
/// - [minLength] The minimum length of the username. Defaults to 3.
/// - [maxLength] The maximum length of the username. Defaults to 32.
/// - [allowNumbers] Whether to allow numbers in the username. Defaults to true.
/// - [allowUnderscore] Whether to allow underscores in the username. Defaults to false.
/// - [allowDots] Whether to allow dots in the username. Defaults to false.
/// - [allowDash] Whether to allow dashes in the username. Defaults to false.
/// - [allowSpace] Whether to allow spaces in the username. Defaults to false.
/// - [allowSpecialChar] Whether to allow special characters in the username. Defaults to false.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class UsernameValidator extends BaseValidator<String> {
  /// Constructor for the username validator.
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

  /// The minimum length of the username.
  final int minLength;

  /// The maximum length of the username.
  final int maxLength;

  /// Whether to allow numbers in the username.
  final bool allowNumbers;

  /// Whether to allow underscores in the username.
  final bool allowUnderscore;

  /// Whether to allow dots in the username.
  final bool allowDots;

  /// Whether to allow dashes in the username.
  final bool allowDash;

  /// Whether to allow spaces in the username.
  final bool allowSpace;

  /// Whether to allow special characters in the username.
  final bool allowSpecialChar;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.usernameErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (valueCandidate.length < minLength) {
      return errorText != FormBuilderLocalizations.current.usernameErrorText
          ? errorText
          : FormBuilderLocalizations.current.minLengthErrorText(minLength);
    }

    if (valueCandidate.length > maxLength) {
      return errorText != FormBuilderLocalizations.current.usernameErrorText
          ? errorText
          : FormBuilderLocalizations.current.maxLengthErrorText(maxLength);
    }

    if (!allowNumbers && RegExp('[0-9]').hasMatch(valueCandidate)) {
      return errorText != FormBuilderLocalizations.current.usernameErrorText
          ? errorText
          : FormBuilderLocalizations
              .current.usernameCannotContainNumbersErrorText;
    }

    if (!allowUnderscore && valueCandidate.contains('_')) {
      return errorText != FormBuilderLocalizations.current.usernameErrorText
          ? errorText
          : FormBuilderLocalizations
              .current.usernameCannotContainUnderscoreErrorText;
    }

    if (!allowDots && valueCandidate.contains('.')) {
      return errorText != FormBuilderLocalizations.current.usernameErrorText
          ? errorText
          : FormBuilderLocalizations.current.usernameCannotContainDotsErrorText;
    }

    if (!allowDash && valueCandidate.contains('-')) {
      return errorText != FormBuilderLocalizations.current.usernameErrorText
          ? errorText
          : FormBuilderLocalizations
              .current.usernameCannotContainDashesErrorText;
    }

    if (!allowSpace && valueCandidate.contains(' ')) {
      return errorText != FormBuilderLocalizations.current.usernameErrorText
          ? errorText
          : FormBuilderLocalizations
              .current.usernameCannotContainSpacesErrorText;
    }

    if (!allowSpecialChar &&
        RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(valueCandidate)) {
      return errorText != FormBuilderLocalizations.current.usernameErrorText
          ? errorText
          : FormBuilderLocalizations
              .current.usernameCannotContainSpecialCharErrorText;
    }

    return null;
  }
}
