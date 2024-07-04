import '../../localization/l10n.dart';
import '../base_validator.dart';

class TimeZoneValidator extends BaseValidator<String> {
  TimeZoneValidator({
    List<String>? validTimeZones,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : validTimeZones = validTimeZones ?? timeZones;

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
