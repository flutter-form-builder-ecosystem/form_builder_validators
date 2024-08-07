import '../../form_builder_validators.dart';

/// {@template country_validator_template}
/// [CountryValidator] extends [TranslatedValidator] to validate if a string represents a valid country name.
///
/// This validator checks if the country name is not in a blacklist,
/// and optionally checks if it is in a whitelist.
///
/// ## Parameters:
///
/// - [countryWhitelist] A list of valid country names that are explicitly allowed.
/// - [countryBlacklist] A list of invalid country names that are explicitly disallowed.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class CountryValidator extends TranslatedValidator<String> {
  /// Constructor for the country name validator.
  CountryValidator({
    List<String>? countryWhitelist,
    List<String>? countryBlacklist,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  })  : countryWhitelist = countryWhitelist ?? <String>[],
        countryBlacklist = countryBlacklist ?? <String>[];

  /// A list of valid country names that are explicitly allowed.
  final List<String> countryWhitelist;

  /// A list of invalid country names that are explicitly disallowed.
  final List<String> countryBlacklist;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.countryErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (countryBlacklist.contains(valueCandidate)) {
      return errorText;
    }

    if (countryWhitelist.isEmpty || countryWhitelist.contains(valueCandidate)) {
      return null;
    }

    return errorText;
  }
}
