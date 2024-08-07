import '../../form_builder_validators.dart';

/// {@template time_zone_validator_template}
/// [TimeZoneValidator] extends [TranslatedValidator] to validate if a string represents a valid time zone identifier.
///
/// This validator checks if the string is in the list of valid time zone identifiers.
///
/// ## Parameters:
///
/// - [validTimeZones] The list of valid time zone identifiers. Defaults to a standard list of common time zones.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class TimeZoneValidator extends TranslatedValidator<String> {
  /// Constructor for the time zone string validator.
  TimeZoneValidator({
    List<String>? validTimeZones,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : validTimeZones = validTimeZones ?? timeZones;

  /// The list of valid time zone identifiers.
  final List<String> validTimeZones;

  /// A list of valid time zone identifiers.
  static final List<String> timeZones = <String>[
    'UTC',
    'GMT',
    'EST',
    'EDT',
    'CST',
    'CDT',
    'MST',
    'MDT',
    'PST',
    'PDT',
    'ECT',
    'EET',
    'ART',
    'AST',
    'EAT',
    'MET',
    'NET',
    'PLT',
    'IST',
    'BST',
    'VST',
    'CTT',
    'JST',
    'ACT',
    'AET',
    'SST',
    'NST',
    'MIT',
    'HST',
    'AST',
    'PNT',
    'PRT',
    'CNT',
    'AGT',
    'BET',
    'CAT',
  ];

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.timezoneErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (validTimeZones.contains(valueCandidate)) {
      return null;
    }

    return errorText;
  }
}
