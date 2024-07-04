import '../../localization/l10n.dart';
import '../base_validator.dart';

class CountryValidator extends BaseValidator<String> {
  CountryValidator({
    List<String>? countryWhitelist,
    List<String>? countryBlacklist,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  })  : countryWhitelist = countryWhitelist ?? <String>[],
        countryBlacklist = countryBlacklist ?? <String>[];

  final List<String> countryWhitelist;

  final List<String> countryBlacklist;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.countryErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (countryBlacklist.contains(valueCandidate)) {
      return errorText;
    }

    if (countryWhitelist.contains(valueCandidate)) {
      return null;
    }

    return errorText;
  }
}
