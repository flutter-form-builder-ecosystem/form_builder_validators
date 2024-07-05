import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template port_number_validator_template}
/// [PortNumberValidator] extends [BaseValidator] to validate if a string represents a valid port number.
///
/// This validator checks if the port number is an integer within the specified range (0 to 65535 by default).
///
/// ## Parameters:
///
/// - [min] The minimum allowable port number. Defaults to 0.
/// - [max] The maximum allowable port number. Defaults to 65535.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class PortNumberValidator extends BaseValidator<String> {
  /// Constructor for the port number validator.
  PortNumberValidator({
    this.min = 0,
    this.max = 65535,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The minimum allowable port number.
  final int min;

  /// The maximum allowable port number.
  final int max;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.portNumberErrorText(min, max);

  @override
  String? validateValue(String valueCandidate) {
    final int? port = int.tryParse(valueCandidate);
    if (port == null || port < min || port > max) {
      return errorText;
    }
    return null;
  }
}
