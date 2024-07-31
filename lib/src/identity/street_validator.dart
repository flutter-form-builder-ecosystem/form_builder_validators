import '../../form_builder_validators.dart';

/// {@template street_validator_template}
/// [StreetValidator] extends [TranslatedValidator] to validate if a string represents a valid street name.
///
/// This validator checks if the street name matches a specified regex pattern and is not in a blacklist,
/// and optionally checks if it is in a whitelist.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the street name format. Defaults to a standard street name regex.
/// - [streetWhitelist] A list of valid street names that are explicitly allowed.
/// - [streetBlacklist] A list of invalid street names that are explicitly disallowed.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class StreetValidator extends TranslatedValidator<String> {
  /// Constructor for the street name validator.
  StreetValidator({
    /// {@macro street_template}
    RegExp? regex,
    this.streetWhitelist = const <String>[],
    this.streetBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _street;

  /// The regular expression used to validate the street name format.
  final RegExp regex;

  /// A list of valid street names that are explicitly allowed.
  final List<String> streetWhitelist;

  /// A list of invalid street names that are explicitly disallowed.
  final List<String> streetBlacklist;

  /// {@template street_template}
  /// This regex matches a valid street name format.
  ///
  /// - It requires the first letter to be uppercase.
  /// - It allows alphanumeric characters and spaces.
  ///
  /// Examples: 123 Main St, Elm Street, 456 Oak Ave
  /// {@endtemplate}
  static final RegExp _street = RegExp(r'^[A-Z0-9][a-zA-Z0-9\s]*$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.streetErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (streetBlacklist.contains(valueCandidate)) {
      return errorText;
    }

    if (!regex.hasMatch(valueCandidate)) {
      return errorText;
    }

    if (streetWhitelist.isEmpty || streetWhitelist.contains(valueCandidate)) {
      return null;
    }

    return errorText;
  }
}
