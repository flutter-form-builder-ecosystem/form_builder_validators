import '../../localization/l10n.dart';
import '../base_validator.dart';

class CityValidator extends BaseValidator<String> {
  CityValidator({
    /// {@macro city_template}
    RegExp? regex,
    this.citiesWhitelist = const <String>[],
    this.citiesBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _cities;

  final RegExp regex;

  List<String> citiesWhitelist;

  List<String> citiesBlacklist;

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

    if (citiesWhitelist.contains(valueCandidate)) {
      return null;
    }

    return errorText;
  }
}
