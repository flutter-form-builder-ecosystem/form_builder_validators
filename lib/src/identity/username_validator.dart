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
