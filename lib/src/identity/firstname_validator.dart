import '../../localization/l10n.dart';
import '../base_validator.dart';

class FirstNameValidator extends BaseValidator<String> {
  FirstNameValidator({
    /// {@macro first_name_template}
    RegExp? regex,
    this.firstNameWhitelist = const <String>[],
    this.firstNameBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _firstName;

  final RegExp regex;

  final List<String> firstNameWhitelist;

  final List<String> firstNameBlacklist;

  /// {@template first_name_template}
  /// This regex matches a valid first name format.
  ///
  /// - It requires the first letter to be uppercase.
  /// - It allows only alphabetic characters.
  ///
  /// Examples: John, Alice, Bob
  /// {@endtemplate}
  static final RegExp _firstName = RegExp(r'^[A-Z][a-zA-Z]+$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.firstNameErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (firstNameBlacklist.contains(valueCandidate)) {
      return errorText;
    }

    if (!regex.hasMatch(valueCandidate)) {
      return errorText;
    }

    if (firstNameWhitelist.isEmpty ||
        firstNameWhitelist.contains(valueCandidate)) {
      return null;
    }

    return errorText;
  }
}
