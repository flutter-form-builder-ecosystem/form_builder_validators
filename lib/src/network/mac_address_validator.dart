import '../../form_builder_validators.dart';

/// {@template mac_address_validator_template}
/// [MacAddressValidator] extends [TranslatedValidator] to validate if a string represents a valid MAC address.
///
/// This validator checks if the MAC address matches the specified regex pattern.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the MAC address format. Defaults to a standard MAC address regex.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class MacAddressValidator extends TranslatedValidator<String> {
  /// Constructor for the MAC address validator.
  MacAddressValidator({
    /// {@macro mac_address_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _macAddress;

  /// The regular expression used to validate the MAC address format.
  final RegExp regex;

  /// {@template mac_address_template}
  /// This regex matches MAC addresses.
  ///
  /// - It consists of six groups of two hexadecimal digits.
  /// - Each group is separated by a colon or hyphen.
  ///
  /// Examples: 00:1A:2B:3C:4D:5E, 00-1A-2B-3C-4D-5E
  /// {@endtemplate}
  static final RegExp _macAddress = RegExp(
    r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$|^([0-9A-Fa-f]{4}\.){2}([0-9A-Fa-f]{4})$',
  );

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.macAddressErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return regex.hasMatch(valueCandidate) ? null : errorText;
  }
}
