import '../../localization/l10n.dart';
import '../base_validator.dart';

class PortNumberValidator extends BaseValidator<String> {
  PortNumberValidator({
    this.min = 0,
    this.max = 65535,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final int min;

  final int max;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.portNumberErrorText(min, max);

  @override
  String? validateValue(String? valueCandidate) {
    final int? port = int.tryParse(valueCandidate!);
    if (port == null || port < min || port > max) {
      return errorText;
    }
    return null;
  }
}
