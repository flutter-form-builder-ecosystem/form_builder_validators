import '../../localization/l10n.dart';
import '../base_validator.dart';

class LongitudeValidator extends BaseValidator<String> {
  const LongitudeValidator({
    /// {@macro longitude_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.longitudeErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    return isLongitude(valueCandidate!) ? null : errorText;
  }

  /// check if the string is a valid longitude
  bool isLongitude(String value) {
    final String longitudeValue = value.replaceAll(',', '.');

    final double? longitude = double.tryParse(longitudeValue);
    if (longitude == null) {
      return false;
    }
    return longitude >= -180 && longitude <= 180;
  }
}
