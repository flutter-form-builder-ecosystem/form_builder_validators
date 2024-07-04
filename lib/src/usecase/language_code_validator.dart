import '../../localization/l10n.dart';
import '../base_validator.dart';

class LanguageCodeValidator extends BaseValidator<String> {
  LanguageCodeValidator({
    /// {@macro language_code_template}
    RegExp? regex,
    this.languageCodeWhitelist = const <String>[],
    this.languageCodeBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _languageCode;

  final RegExp regex;

  final List<String> languageCodeWhitelist;

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
