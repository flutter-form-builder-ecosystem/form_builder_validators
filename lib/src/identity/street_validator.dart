import '../../localization/l10n.dart';
import '../base_validator.dart';

class StreetValidator extends BaseValidator<String> {
  StreetValidator({
    /// {@macro street_template}
    RegExp? regex,
    this.streetWhitelist = const <String>[],
    this.streetBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _street;

  final RegExp regex;

  final List<String> streetWhitelist;

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
