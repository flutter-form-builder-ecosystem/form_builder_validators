import '../../localization/l10n.dart';
import '../base_validator.dart';

class LicensePlateValidator extends BaseValidator<String> {
  LicensePlateValidator({
    /// {@macro license_plate_template}
    RegExp? regex,
    this.licensePlateWhitelist = const <String>[],
    this.licensePlateBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _licensePlate;

  final RegExp regex;

  final List<String> licensePlateWhitelist;

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
