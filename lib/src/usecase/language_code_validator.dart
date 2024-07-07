import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template language_code_validator_template}
/// [LanguageCodeValidator] extends [BaseValidator] to validate if a string is a valid language code.
///
/// This validator checks if the value matches the specified regex pattern that requires exactly 2 lowercase letters (ISO 639-1 standard).
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the language code format. Defaults to a regex that matches exactly 2 lowercase letters.
/// - [languageCodeWhitelist] An optional list of allowed language codes.
/// - [languageCodeBlacklist] An optional list of disallowed language codes.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class LanguageCodeValidator extends BaseValidator<String> {
  /// Constructor for the language code validator.
  LanguageCodeValidator({
    /// {@macro language_code_template}
    RegExp? regex,
    this.languageCodeWhitelist = const <String>[],
    this.languageCodeBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _languageCode;

  /// The regular expression used to validate the language code format.
  final RegExp regex;

  /// An optional list of allowed language codes.
  final List<String> languageCodeWhitelist;

  /// An optional list of disallowed language codes.
  final List<String> languageCodeBlacklist;

  /// {@template language_code_template}
  /// This regex matches a valid language code format.
  ///
  /// - It requires exactly 2 lowercase letters (ISO 639-1 standard).
  ///
  /// Examples: en, fr, es
  /// {@endtemplate}
  static final RegExp _languageCode = RegExp(r'^[a-z]{2}$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.languageCodeErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (languageCodeBlacklist.contains(valueCandidate)) {
      return errorText;
    }

    if (!regex.hasMatch(valueCandidate)) {
      return errorText;
    }

    if (languageCodeWhitelist.isEmpty ||
        languageCodeWhitelist.contains(valueCandidate)) {
      return null;
    }

    return errorText;
  }
}
