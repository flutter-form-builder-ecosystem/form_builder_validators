import '../../form_builder_validators.dart';

/// {@template bic_validator_template}
/// [BicValidator] extends [TranslatedValidator] to validate if a string represents a valid BIC (Bank Identifier Code).
///
/// This validator checks if the string matches the specified regex pattern for valid BICs.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the BIC format. Defaults to a standard BIC regex.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class BicValidator extends TranslatedValidator<String> {
  /// Constructor for the BIC validator.
  BicValidator({
    /// {@macro bic_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _bic;

  /// The regular expression used to validate the BIC format.
  final RegExp regex;

  /// {@template bic_template}
  /// This regex matches BIC (Bank Identifier Code).
  ///
  /// - It consists of 8 or 11 characters.
  /// - It starts with four letters (bank code), followed by two letters (country code), two characters (location code), and optionally three characters (branch code).
  ///
  /// Examples: DEUTDEFF, NEDSZAJJXXX
  /// {@endtemplate}
  static final RegExp _bic = RegExp(r'^[A-Z]{4}[A-Z]{2}\w{2}(\w{3})?$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.bicErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return isBIC(valueCandidate) ? null : errorText;
  }

  /// Check if the string is a valid BIC string.
  ///
  /// ## Parameters:
  /// - [value] The string to be evaluated.
  ///
  /// ## Returns:
  /// A boolean indicating whether the value is a valid BIC.
  bool isBIC(String value) {
    final String bic = value.replaceAll(' ', '').toUpperCase();

    if (bic.length != 8 && bic.length != 11) {
      return false;
    }

    return regex.hasMatch(bic);
  }
}
