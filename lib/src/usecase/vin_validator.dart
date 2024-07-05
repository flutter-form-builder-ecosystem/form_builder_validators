import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template vin_validator_template}
/// [VinValidator] extends [BaseValidator] to validate if a string is a valid Vehicle Identification Number (VIN).
///
/// This validator checks if the value matches the specified regex pattern for VIN format and optionally checks against whitelists and blacklists.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the VIN format. Defaults to a regex that matches common VIN formats.
/// - [vinWhitelist] An optional list of allowed VINs.
/// - [vinBlacklist] An optional list of disallowed VINs.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class VinValidator extends BaseValidator<String> {
  /// Constructor for the VIN validator.
  VinValidator({
    /// {@macro vin_template}
    RegExp? regex,
    this.vinWhitelist = const <String>[],
    this.vinBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _vin;

  /// The regular expression used to validate the VIN format.
  final RegExp regex;

  /// An optional list of allowed VINs.
  final List<String> vinWhitelist;

  /// An optional list of disallowed VINs.
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
