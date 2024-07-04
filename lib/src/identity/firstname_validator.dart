import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template first_name_validator_template}
/// [FirstNameValidator] extends [BaseValidator] to validate if a string represents a valid first name.
///
/// This validator checks if the first name matches a specified regex pattern and is not in a blacklist,
/// and optionally checks if it is in a whitelist.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the first name format. Defaults to a standard first name regex.
/// - [firstNameWhitelist] A list of valid first names that are explicitly allowed.
/// - [firstNameBlacklist] A list of invalid first names that are explicitly disallowed.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class FirstNameValidator extends BaseValidator<String> {
  /// Constructor for the first name validator.
  FirstNameValidator({
    /// {@macro first_name_template}
    RegExp? regex,
    this.firstNameWhitelist = const <String>[],
    this.firstNameBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _firstName;

  /// The regular expression used to validate the first name format.
  final RegExp regex;

  /// A list of valid first names that are explicitly allowed.
  final List<String> firstNameWhitelist;

  /// A list of invalid first names that are explicitly disallowed.
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
