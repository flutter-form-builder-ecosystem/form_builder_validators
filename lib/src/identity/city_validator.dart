import '../../form_builder_validators.dart';

/// {@template city_validator_template}
/// [CityValidator] extends [TranslatedValidator] to validate if a string represents a valid city name.
///
/// This validator checks if the city name matches a specified regex pattern and is not in a blacklist,
/// and optionally checks if it is in a whitelist.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the city name format. Defaults to a standard city name regex.
/// - [citiesWhitelist] A list of valid city names that are explicitly allowed.
/// - [citiesBlacklist] A list of invalid city names that are explicitly disallowed.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class CityValidator extends TranslatedValidator<String> {
  /// Constructor for the city name validator.
  CityValidator({
    /// {@macro city_template}
    RegExp? regex,
    this.citiesWhitelist = const <String>[],
    this.citiesBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _cities;

  /// The regular expression used to validate the city name format.
  final RegExp regex;

  /// A list of valid city names that are explicitly allowed.
  final List<String> citiesWhitelist;

  /// A list of invalid city names that are explicitly disallowed.
  final List<String> citiesBlacklist;

  /// {@template city_template}
  /// This regex matches a valid city name format.
  ///
  /// - It requires the first letter to be uppercase.
  /// - It allows only alphabetic characters and spaces.
  ///
  /// Examples: New York, Los Angeles, Chicago
  /// {@endtemplate}
  static final RegExp _cities = RegExp(r'^[A-Z][a-zA-Z\s]+$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.cityErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (citiesBlacklist.contains(valueCandidate)) {
      return errorText;
    }

    if (!regex.hasMatch(valueCandidate)) {
      return errorText;
    }

    if (citiesWhitelist.isEmpty || citiesWhitelist.contains(valueCandidate)) {
      return null;
    }

    return errorText;
  }
}
