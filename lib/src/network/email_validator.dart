import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template email_template}
/// `EmailValidator` extends `BaseValidator` that validates a given email address.
/// It uses a regular expression to check if the email address is valid.
///
/// Parameters:
///
/// - [errorText]: The error message returned if the email address is invalid.
/// - [regex]: The regular expression used to validate the email address.
///
/// {@macro email_regex_template}
/// {@endtemplate}
class EmailValidator extends BaseValidator<String> {
  EmailValidator({
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _emailRegex;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.emailErrorText;

  /// {@template email_regex_template}
  /// The default regex matches an email address.
  ///
  /// - It allows various characters, including letters, digits, and special characters.
  /// - It supports international characters.
  /// - It checks for the presence of an "@" symbol followed by a valid domain name.
  ///
  /// Examples: user@example.com, user.name+tag@example.co.uk
  /// {@endtemplate}
  static final RegExp _emailRegex = RegExp(
    r"^((([a-z]|\d|[!#\$%&'*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$",
  );

  /// The regular expression used to validate the email address.
  final RegExp regex;

  @override
  String? validateValue(String? valueCandidate) {
    return regex.hasMatch(valueCandidate!.toLowerCase()) ? null : errorText;
  }
}
