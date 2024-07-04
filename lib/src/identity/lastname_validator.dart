import '../../localization/l10n.dart';
import '../base_validator.dart';

class LastNameValidator extends BaseValidator<String> {
  LastNameValidator({
    /// {@macro last_name_template}
    RegExp? regex,
    this.lastNameWhitelist = const <String>[],
    this.lastNameBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _lastName;

  final RegExp regex;

  final List<String> lastNameWhitelist;

  final List<String> lastNameBlacklist;

  /// {@template last_name_template}
  /// This regex matches a valid last name format.
  ///
  /// - It requires the first letter to be uppercase.
  /// - It allows only alphabetic characters.
  ///
  /// Examples: Smith, Johnson, Brown
  /// {@endtemplate}
  static final RegExp _lastName = RegExp(r'^[A-Z][a-zA-Z]+$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.lastNameErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (lastNameBlacklist.contains(valueCandidate)) {
      return errorText;
    }

    if (!regex.hasMatch(valueCandidate)) {
      return errorText;
    }

    if (lastNameWhitelist.isEmpty ||
        lastNameWhitelist.contains(valueCandidate)) {
      return null;
    }

    return errorText;
  }
}
