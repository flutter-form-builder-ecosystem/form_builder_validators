import '../../localization/l10n.dart';
import '../base_validator.dart';

class HasLowercaseCharsValidator extends BaseValidator<String> {
  HasLowercaseCharsValidator({
    this.atLeast = 1,
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _lowerCase;

  final int atLeast;

  final RegExp? regex;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsLowercaseCharErrorText(atLeast);

  /// {@template lower_case_template}
  /// This regex matches any character that is not a lowercase letter (a-z) or ñ.
  ///
  /// - It includes special characters, digits, and uppercase letters.
  /// - It can be used to find non-lowercase characters.
  ///
  /// Examples: A, 1, @
  /// {@endtemplate}
  static final RegExp _lowerCase = RegExp('[^a-zñ]');

  @override
  String? validateValue(String? valueCandidate) {
    return lowercaseCharLength(valueCandidate!) >= atLeast ? null : errorText;
  }

  int lowercaseCharLength(String value) {
    return value.replaceAll(_lowerCase, '').length;
  }
}
