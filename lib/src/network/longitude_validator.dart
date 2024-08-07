import '../../form_builder_validators.dart';

/// {@template longitude_validator_template}
/// [LongitudeValidator] extends [TranslatedValidator] to validate if a string represents a valid longitude value.
///
/// This validator checks if the longitude value is a number within the range of -180 to 180 degrees.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class LongitudeValidator extends TranslatedValidator<String> {
  /// Constructor for the longitude validator.
  const LongitudeValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.longitudeErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return isLongitude(valueCandidate) ? null : errorText;
  }

  /// Check if the string is a valid longitude.
  ///
  /// ## Parameters:
  /// - [value] The string to be evaluated.
  ///
  /// ## Returns:
  /// A boolean indicating whether the value is a valid longitude.
  bool isLongitude(String value) {
    final String longitudeValue = value.replaceAll(',', '.');

    final double? longitude = double.tryParse(longitudeValue);
    if (longitude == null) {
      return false;
    }
    return longitude >= -180 && longitude <= 180;
  }
}
