import '../../localization/l10n.dart';
import '../base_validator.dart';

class MacAddressValidator extends BaseValidator<String?> {
  MacAddressValidator({
    /// {@macro mac_address_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _macAddress;

  final RegExp regex;

  /// {@template mac_address_template}
  /// This regex matches MAC addresses.
  ///
  /// - It consists of six groups of two hexadecimal digits.
  /// - Each group is separated by a colon.
  ///
  /// Examples: 00:1A:2B:3C:4D:5E, 00:1A:2B:3C:4D:5E
  /// {@endtemplate}
  static final RegExp _macAddress =
      RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.macAddressErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    return !isMACAddress(valueCandidate!) ? errorText : null;
  }

  /// check if the string is a valid MAC address
  bool isMACAddress(String value) {
    final String splitChar = value.contains(':') ? ':' : '-';
    final List<String> parts = value.split(splitChar);
    if (parts.length != 6) {
      return false;
    }

    for (final String part in parts) {
      if (part.length != 2 || !regex.hasMatch(part)) {
        return false;
      }
    }
    return true;
  }
}
