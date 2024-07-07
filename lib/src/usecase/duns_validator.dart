import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template duns_validator_template}
/// [DunsValidator] extends [BaseValidator] to validate if a string is a valid DUNS number.
///
/// This validator checks if the value matches the specified regex pattern that requires exactly 9 digits.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the DUNS number format. Defaults to a regex that matches exactly 9 digits.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class DunsValidator extends BaseValidator<String> {
  /// Constructor for the DUNS validator.
  DunsValidator({
    /// {@macro duns_template}
    RegExp? regex,
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _duns;

  /// The regular expression used to validate the DUNS number format.
  final RegExp regex;

  /// {@template duns_template}
  /// This regex matches a valid DUNS number format.
  ///
  /// - It requires exactly 9 digits.
  ///
  /// Examples: 123456789, 987654321
  /// {@endtemplate}
  static final RegExp _duns = RegExp(r'^\d{9}$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.dunsErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (!regex.hasMatch(valueCandidate)) {
      return errorText;
    }

    return null;
  }
}
