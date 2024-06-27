import '../../localization/l10n.dart';
import '../base_validator.dart';

class LatitudeValidator extends BaseValidator<String> {
  const LatitudeValidator({
    /// {@macro longitude_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.longitudeErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return isLatitude(valueCandidate) ? null : errorText;
  }

  /// check if the string is a valid latitude
  bool isLatitude(String value) {
    final String latitudeValue = value.replaceAll(',', '.');

    final double? latitude = double.tryParse(latitudeValue);
    if (latitude == null) {
      return false;
    }
    return latitude >= -90 && latitude <= 90;
  }
}
