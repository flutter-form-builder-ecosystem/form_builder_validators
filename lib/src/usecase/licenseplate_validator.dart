import '../../form_builder_validators.dart';

/// {@template license_plate_validator_template}
/// [LicensePlateValidator] extends [TranslatedValidator] to validate if a string is a valid license plate.
///
/// This validator checks if the value matches the specified regex pattern for common license plate formats and optionally checks against whitelists and blacklists.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the license plate format. Defaults to a regex that matches common license plate formats.
/// - [licensePlateWhitelist] An optional list of allowed license plates.
/// - [licensePlateBlacklist] An optional list of disallowed license plates.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class LicensePlateValidator extends TranslatedValidator<String> {
  /// Constructor for the license plate validator.
  LicensePlateValidator({
    /// {@macro license_plate_template}
    RegExp? regex,
    this.licensePlateWhitelist = const <String>[],
    this.licensePlateBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _licensePlate;

  /// The regular expression used to validate the license plate format.
  final RegExp regex;

  /// An optional list of allowed license plates.
  final List<String> licensePlateWhitelist;

  /// An optional list of disallowed license plates.
  final List<String> licensePlateBlacklist;

  /// {@template license_plate_template}
  /// This regex matches a valid license plate format.
  ///
  /// - It allows alphanumeric characters.
  /// - It supports common formats used in various regions.
  ///
  /// Examples: ABC123, 123ABC, ABC-1234
  /// {@endtemplate}
  static final RegExp _licensePlate = RegExp(r'^[A-Z0-9-]+$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.licensePlateErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (licensePlateBlacklist.contains(valueCandidate)) {
      return errorText;
    }

    if (!regex.hasMatch(valueCandidate)) {
      return errorText;
    }

    if (licensePlateWhitelist.isEmpty ||
        licensePlateWhitelist.contains(valueCandidate)) {
      return null;
    }

    return errorText;
  }
}
