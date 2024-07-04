import '../../localization/l10n.dart';
import '../base_validator.dart';

class VinValidator extends BaseValidator<String> {
  VinValidator({
    /// {@macro vin_template}
    RegExp? regex,
    this.vinWhitelist = const <String>[],
    this.vinBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _vin;

  final RegExp regex;

  final List<String> vinWhitelist;

  final List<String> vinBlacklist;

  /// {@template vin_template}
  /// This regex matches a valid Vehicle Identification Number (VIN) format.
  ///
  /// - A VIN is exactly 17 characters long.
  /// - It allows alphanumeric characters, but excludes the letters I, O, and Q.
  ///
  /// Examples: 1HGCM82633A123456, JH4KA8260MC000000
  /// {@endtemplate}
  static final RegExp _vin = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.vinErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (vinBlacklist.contains(valueCandidate)) {
      return errorText;
    }

    if (!regex.hasMatch(valueCandidate)) {
      return errorText;
    }

    if (vinWhitelist.isEmpty || vinWhitelist.contains(valueCandidate)) {
      return null;
    }

    return errorText;
  }
}
