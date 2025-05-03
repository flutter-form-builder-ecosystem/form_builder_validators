import '../../localization/l10n.dart';
import 'constants.dart';

/// Represents supported Internet Protocol versions
/// Supported versions:
/// - `iPv4`
/// - `iPv6`
/// - `any` (supports all versions)
enum IpVersion {
  /// IPv4 (RFC 791) - 32-bit addresses
  /// - Format: Four 8-bit decimal numbers (0-255) separated by dots
  /// - Example: 192.168.1.1, 10.0.0.1
  iPv4,

  /// IPv6 (RFC 2460) - 128-bit addresses
  /// - Format: Eight 16-bit hexadecimal groups separated by colons
  /// - Example: 2001:0db8:85a3:0000:0000:8a2e:0370:7334
  /// - Allows compression of zeros (::) and leading zero omission
  iPv6,

  /// Accepts both IPv4 and IPv6 formats
  any,
}

/// {@macro ip_validator}
Validator<String> ip({
  IpVersion version = IpVersion.iPv4,
  // TODO(ArturAssisComp): study the possibility to replace this parameter with
  // a more generic one. Instead of accepting a regex for IP, accepts a function
  // that returns if the ip address is valid or not. Something like:
  // bool Function(String input) customIpValidator,
  RegExp? regex,
  String Function(String input)? ipMsg,
}) {
  return (String input) {
    return !_isIP(input, version, regex)
        // TODO(ArturAssisComp): study the possibility to make the error message more
        // meaningful. One good example is the password validator, which may be
        // configured to return a detailed message of why it is invalid.
        ? ipMsg?.call(input) ?? FormBuilderLocalizations.current.ipErrorText
        : null;
  };
}

/// Default protocols to be used for the url validation.
/// The protocols are:
///   - `http`
///   - `https`
///   - `ftp`
const List<String> kDefaultUrlValidationProtocols = <String>[
  'http',
  'https',
  'ftp'
];

/// {@macro validator_url}
Validator<String> url({
  List<String> protocols = kDefaultUrlValidationProtocols,
  bool requireTld = true,
  bool requireProtocol = false,
  bool allowUnderscore = false,
  List<String> hostAllowList = const <String>[],
  List<String> hostBlockList = const <String>[],
  RegExp? regex,
  String Function(String input)? urlMsg,
}) {
  final List<String> immutableProtocols = List<String>.unmodifiable(protocols);
  final List<String> immutableHostAllowList =
      List<String>.unmodifiable(hostAllowList);
  final List<String> immutableHostBlockList =
      List<String>.unmodifiable(hostBlockList);
  return (String value) {
    return (regex != null && !regex.hasMatch(value)) ||
            !_isURL(
              value,
              protocols: immutableProtocols,
              requireTld: requireTld,
              requireProtocol: requireProtocol,
              allowUnderscore: allowUnderscore,
              hostAllowList: immutableHostAllowList,
              hostBlockList: immutableHostBlockList,
            )
        ? urlMsg?.call(value) ?? FormBuilderLocalizations.current.urlErrorText
        : null;
  };
}

/// {@macro validator_mac_address}
Validator<String> macAddress({
  bool Function(String)? isMacAddress,
  String Function(String input)? macAddressMsg,
}) {
  final RegExp defaultRegex = RegExp(
    r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$|^([0-9A-Fa-f]{4}\.){2}([0-9A-Fa-f]{4})$',
  );
  return (String input) {
    return (isMacAddress?.call(input) ?? defaultRegex.hasMatch(input))
        ? null
        : (macAddressMsg?.call(input) ??
            FormBuilderLocalizations.current.macAddressErrorText);
  };
}

//******************************************************************************
//*                              Aux functions                                 *
//******************************************************************************
const int _maxUrlLength = 2083;
final RegExp _ipv4Maybe =
    RegExp(r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$');
final RegExp _ipv6 = RegExp(
  r'^((?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,7}:|(?:[0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,5}(?::[0-9a-fA-F]{1,4}){1,2}|(?:[0-9a-fA-F]{1,4}:){1,4}(?::[0-9a-fA-F]{1,4}){1,3}|(?:[0-9a-fA-F]{1,4}:){1,3}(?::[0-9a-fA-F]{1,4}){1,4}|(?:[0-9a-fA-F]{1,4}:){1,2}(?::[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:(?::[0-9a-fA-F]{1,4}){1,6}|:(?:(?::[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(?::[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]+|::(ffff(?::0{1,4})?:)?(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(?:[0-9a-fA-F]{1,4}:){1,4}:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))$',
);

/// Check if the string [str] is IP [version] 4 or 6.
///
/// * [version] is a String or an `int`.
bool _isIP(String str, IpVersion version, RegExp? regex) {
  if (regex != null) {
    return regex.hasMatch(str);
  }
  switch (version) {
    case IpVersion.iPv4:
      if (!_ipv4Maybe.hasMatch(str)) {
        return false;
      }
      final List<String> parts = str.split('.');
      return !parts.any((String e) => int.parse(e) > 255);
    case IpVersion.iPv6:
      return _ipv6.hasMatch(str);
    case IpVersion.any:
      return _isIP(str, IpVersion.iPv4, regex) ||
          _isIP(str, IpVersion.iPv6, regex);
  }
}

/// Check if the string [value] is a URL.
///
/// * [protocols] sets the list of allowed protocols
/// * [requireTld] sets if TLD is required
/// * [requireProtocol] is a `bool` that sets if protocol is required for validation
/// * [allowUnderscore] sets if underscores are allowed
/// * [hostAllowList] sets the list of allowed hosts
/// * [hostBlockList] sets the list of disallowed hosts
bool _isURL(
  String value, {
  required List<String> protocols,
  bool requireTld = true,
  bool requireProtocol = false,
  bool allowUnderscore = false,
  required List<String> hostAllowList,
  required List<String> hostBlockList,
  RegExp? regexp,
}) {
  if (value.isEmpty ||
      value.length > _maxUrlLength ||
      value.startsWith('mailto:')) {
    return false;
  }
  final int port;
  final String? protocol;
  final String? auth;
  final String user;
  final String host;
  final String hostname;
  final String portStr;
  final String path;
  final String query;
  final String hash;

  // check protocol
  List<String> split = value.split('://');
  if (split.length > 1) {
    protocol = _shift(split).toLowerCase();
    if (!protocols.contains(protocol)) {
      return false;
    }
  } else if (requireProtocol == true) {
    return false;
  }
  final String str1 = split.join('://');

  // check hash
  split = str1.split('#');
  final String str2 = _shift(split);
  hash = split.join('#');
  if (hash.isNotEmpty && RegExp(r'\s').hasMatch(hash)) {
    return false;
  }

  // check query params
  split = str2.split('?');
  final String str3 = _shift(split);
  query = split.join('?');
  if (query.isNotEmpty && RegExp(r'\s').hasMatch(query)) {
    return false;
  }

  // check path
  split = str3.split('/');
  final String str4 = _shift(split);
  path = split.join('/');
  if (path.isNotEmpty && RegExp(r'\s').hasMatch(path)) {
    return false;
  }

  // check auth type urls
  split = str4.split('@');
  if (split.length > 1) {
    auth = _shift(split);
    if (auth?.contains(':') ?? false) {
      user = _shift(auth!.split(':'));
      if (!RegExp(r'^\S+$').hasMatch(user)) {
        return false;
      }
      if (!RegExp(r'^\S*$').hasMatch(user)) {
        return false;
      }
    }
  }

  // check hostname
  hostname = split.join('@');
  split = hostname.split(':');
  host = _shift(split).toLowerCase();
  if (split.isNotEmpty) {
    portStr = split.join(':');
    try {
      port = int.parse(portStr, radix: 10);
    } catch (e) {
      return false;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(portStr) || port <= 0 || port > 65535) {
      return false;
    }
  }

  if (!_isIP(host, IpVersion.any, regexp) &&
      !_isFQDN(
        host,
        requireTld: requireTld,
        allowUnderscores: allowUnderscore,
      ) &&
      host != 'localhost') {
    return false;
  }

  if (hostAllowList.isNotEmpty && !hostAllowList.contains(host)) {
    return false;
  }

  if (hostBlockList.isNotEmpty && hostBlockList.contains(host)) {
    return false;
  }

  return true;
}

/// Check if the string [str] is a fully qualified domain name (e.g., domain.com).
///
/// * [requireTld] sets if TLD is required
/// * [allowUnderscores] sets if underscores are allowed
bool _isFQDN(
  String str, {
  bool requireTld = true,
  bool allowUnderscores = false,
}) {
  final List<String> parts = str.split('.');
  if (requireTld) {
    final String tld = parts.removeLast();
    if (parts.isEmpty || !RegExp(r'^[a-z]{2,}$').hasMatch(tld)) {
      return false;
    }
  }

  final String partPattern = allowUnderscores
      ? r'^[a-z\u00a1-\uffff0-9-_]+$'
      : r'^[a-z\u00a1-\uffff0-9-]+$';

  for (final String part in parts) {
    if (!RegExp(partPattern).hasMatch(part)) {
      return false;
    }
    if (part[0] == '-' ||
        part[part.length - 1] == '-' ||
        part.contains('---') ||
        (allowUnderscores && part.contains('__'))) {
      return false;
    }
  }
  return true;
}

/// Remove and return the first element from a list.
T _shift<T>(List<T> l) {
  if (l.isNotEmpty) {
    final T first = l.first;
    // TODO why not iterating the list?
    l.removeAt(0);
    return first;
  }
  // TODO refactor that.
  return null as T;
}
