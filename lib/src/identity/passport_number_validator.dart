import '../../form_builder_validators.dart';

/// {@template passport_number_validator_template}
/// [PassportNumberValidator] extends [TranslatedValidator] to validate if a string represents a valid passport number.
///
/// This validator checks if the passport number matches a specified regex pattern and is not in a blacklist,
/// and optionally checks if it is in a whitelist.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the passport number format. Defaults to a standard passport number regex.
/// - [passportNumberWhitelist] A list of valid passport numbers that are explicitly allowed.
/// - [passportNumberBlacklist] A list of invalid passport numbers that are explicitly disallowed.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class PassportNumberValidator extends TranslatedValidator<String> {
  /// Constructor for the passport number validator.
  PassportNumberValidator({
    /// {@macro passport_number_template}
    RegExp? regex,
    this.passportNumberWhitelist = const <String>[],
    this.passportNumberBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _passportNumber;

  /// The regular expression used to validate the passport number format.
  final RegExp regex;

  /// A list of valid passport numbers that are explicitly allowed.
  final List<String> passportNumberWhitelist;

  /// A list of invalid passport numbers that are explicitly disallowed.
  final List<String> passportNumberBlacklist;

  /// {@template passport_number_template}
  /// This regex matches a valid passport number format.
  ///
  /// - It requires alphanumeric characters.
  /// - The length of the passport number can vary but typically falls between 6 to 9 characters.
  ///
  /// Examples: A1234567, 123456789, AB123456
  /// {@endtemplate}
  static final RegExp _passportNumber = RegExp(r'^[A-Za-z0-9]{6,9}$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.passportNumberErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (passportNumberBlacklist.contains(valueCandidate)) {
      return errorText;
    }

    if (!regex.hasMatch(valueCandidate)) {
      return errorText;
    }

    if (passportNumberWhitelist.isEmpty ||
        passportNumberWhitelist.contains(valueCandidate)) {
      return null;
    }

    return errorText;
  }
}
