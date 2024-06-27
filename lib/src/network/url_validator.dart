import '../../form_builder_validators.dart';
import '../../localization/l10n.dart';
import '../base_validator.dart';

class UrlValidator extends BaseValidator<String?> {
  UrlValidator({
    this.protocols = const <String>['http', 'https', 'ftp'],
    this.requireTld = true,
    this.requireProtocol = false,
    this.allowUnderscore = false,
    this.hostWhitelist = const <String>[],
    this.hostBlacklist = const <String>[],
    this.regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : _ipValidator = IpValidator(regex: regex, errorText: errorText);

  final List<String> protocols;

  final bool requireTld;

  final bool requireProtocol;

  final bool allowUnderscore;

  final List<String> hostWhitelist;

  final List<String> hostBlacklist;

  final RegExp? regex;

  final int _maxUrlLength = 2083;

  final IpValidator _ipValidator;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.urlErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    return (regex != null && !regex!.hasMatch(valueCandidate!)) ||
            !isURL(
              valueCandidate,
              protocols: protocols,
              requireTld: requireTld,
              requireProtocol: requireProtocol,
              allowUnderscore: allowUnderscore,
              hostWhitelist: hostWhitelist,
              hostBlacklist: hostBlacklist,
            )
        ? errorText
        : null;
  }

  /// check if the string [str] is a URL
  ///
  /// * [protocols] sets the list of allowed protocols
  /// * [requireTld] sets if TLD is required
  /// * [requireProtocol] is a `bool` that sets if protocol is required for validation
  /// * [allowUnderscore] sets if underscores are allowed
  /// * [hostWhitelist] sets the list of allowed hosts
  /// * [hostBlacklist] sets the list of disallowed hosts
  bool isURL(
    String? str, {
    List<String?> protocols = const <String?>['http', 'https', 'ftp'],
    bool requireTld = true,
    bool requireProtocol = false,
    bool allowUnderscore = false,
    List<String> hostWhitelist = const <String>[],
    List<String> hostBlacklist = const <String>[],
  }) {
    if (str == null ||
        str.isEmpty ||
        str.length > _maxUrlLength ||
        str.startsWith('mailto:')) {
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
    List<String> split = str.split('://');
    if (split.length > 1) {
      protocol = shift(split).toLowerCase();
      if (!protocols.contains(protocol)) {
        return false;
      }
    } else if (requireProtocol == true) {
      return false;
    }
    str = split.join('://');

    // check hash
    split = str.split('#');
    str = shift(split);
    hash = split.join('#');
    if (hash.isNotEmpty && RegExp(r'\s').hasMatch(hash)) {
      return false;
    }

    // check query params
    split = str.split('?');
    str = shift(split);
    query = split.join('?');
    if (query.isNotEmpty && RegExp(r'\s').hasMatch(query)) {
      return false;
    }

    // check path
    split = str.split('/');
    str = shift(split);
    path = split.join('/');
    if (path.isNotEmpty && RegExp(r'\s').hasMatch(path)) {
      return false;
    }

    // check auth type urls
    split = str.split('@');
    if (split.length > 1) {
      auth = shift(split);
      if (auth?.contains(':') ?? false) {
        user = shift(auth!.split(':'));
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
    host = shift(split).toLowerCase();
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

    if (!_ipValidator.isIP(host, 0) &&
        !isFQDN(
          host,
          requireTld: requireTld,
          allowUnderscores: allowUnderscore,
        ) &&
        host != 'localhost') {
      return false;
    }

    if (hostWhitelist.isNotEmpty && !hostWhitelist.contains(host)) {
      return false;
    }

    if (hostBlacklist.isNotEmpty && hostBlacklist.contains(host)) {
      return false;
    }

    return true;
  }

  /// check if the string [str] is a fully qualified domain name (e.g. domain.com).
  ///
  /// * [requireTld] sets if TLD is required
  /// * [allowUnderscore] sets if underscores are allowed
  bool isFQDN(
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

    for (final String part in parts) {
      if (allowUnderscores) {
        if (part.contains('__')) {
          return false;
        }
      }
      if (!RegExp(r'^[a-z\\u00a1-\\uffff0-9-]+$').hasMatch(part)) {
        return false;
      }
      if (part[0] == '-' ||
          part[part.length - 1] == '-' ||
          part.contains('---')) {
        return false;
      }
    }
    return true;
  }

  T shift<T>(List<T> l) {
    if (l.isNotEmpty) {
      final T first = l.first;
      l.removeAt(0);
      return first;
    }
    return null as T;
  }
}
