import '../../form_builder_validators.dart';

/// {@template latitude_validator_template}
/// [LatitudeValidator] extends [TranslatedValidator] to validate if a string represents a valid latitude value.
///
/// This validator checks if the latitude value is a number within the range of -90 to 90 degrees.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class LatitudeValidator extends TranslatedValidator<String> {
  /// Constructor for the latitude validator.
  const LatitudeValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.latitudeErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return isLatitude(valueCandidate) ? null : errorText;
  }

  /// Check if the string is a valid latitude.
  ///
  /// ## Parameters:
  /// - [value] The string to be evaluated.
  ///
  /// ## Returns:
  /// A boolean indicating whether the value is a valid latitude.
  bool isLatitude(String value) {
    final String latitudeValue = value.replaceAll(',', '.');

    final double? latitude = double.tryParse(latitudeValue);
    if (latitude == null) {
      return false;
    }
    return latitude >= -90 && latitude <= 90;
  }
}
