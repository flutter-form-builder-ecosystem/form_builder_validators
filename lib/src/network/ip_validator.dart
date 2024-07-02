import '../../localization/l10n.dart';
import '../base_validator.dart';

class IpValidator extends BaseValidator<String> {
  IpValidator({
    this.version = 4,

    /// {@macro ipv4_template}
    /// {@macro ipv6_template}
    this.regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final int version;

  final RegExp? regex;

  /// {@template ipv4_template}
  /// This regex matches an IPv4 address.
  ///
  /// - It consists of four groups of one to three digits.
  /// - Each group is separated by a dot.
  /// - Each group can range from 0 to 255.
  ///
  /// Examples: 192.168.1.1, 10.0.0.1
  /// {@endtemplate}
  static final RegExp _ipv4Maybe =
      RegExp(r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$');

  /// {@template ipv6_template}
  /// This regex matches an IPv6 address.
  ///
  /// - It supports various valid IPv6 notations.
  /// - It allows the use of "::" for consecutive zero blocks.
  /// - It allows hexadecimal digits and colons.
  ///
  /// Examples: ::1, 2001:0db8:85a3:0000:0000:8a2e:0370:7334
  /// {@endtemplate}
  static final RegExp _ipv6 = RegExp(
    r'^((?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,7}:|(?:[0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,5}(?::[0-9a-fA-F]{1,4}){1,2}|(?:[0-9a-fA-F]{1,4}:){1,4}(?::[0-9a-fA-F]{1,4}){1,3}|(?:[0-9a-fA-F]{1,4}:){1,3}(?::[0-9a-fA-F]{1,4}){1,4}|(?:[0-9a-fA-F]{1,4}:){1,2}(?::[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:(?:(?::[0-9a-fA-F]{1,4}){1,6})|:(?:(?::[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(?::[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(?::0{1,4}){0,1}:){0,1}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(?:[0-9a-fA-F]{1,4}:){1,4}:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))$',
  );

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.ipErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return !isIP(valueCandidate, version) ? errorText : null;
  }

  /// check if the string [str] is IP [version] 4 or 6
  ///
  /// * [version] is a String or an `int`.
  bool isIP(String? str, int version) {
    if (version != 4 && version != 6) {
      return isIP(str, 4) || isIP(str, 6);
    } else if (version == 4) {
      if (regex != null) {
        return regex!.hasMatch(str!);
      } else if (!_ipv4Maybe.hasMatch(str!)) {
        return false;
      }
      final List<String> parts = str.split('.')
        ..sort((String a, String b) => int.parse(a) - int.parse(b));
      return int.parse(parts[3]) <= 255;
    } else if (regex != null) {
      return regex!.hasMatch(str!);
    }
    return version == 6 && _ipv6.hasMatch(str!);
  }
}
