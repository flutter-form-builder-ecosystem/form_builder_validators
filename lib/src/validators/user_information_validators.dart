import '../../form_builder_validators.dart';
import 'collection_validators.dart' as collection_val;
import 'core_validators/compose_validators.dart';
import 'string_validators.dart';

/// {@macro validator_password}
Validator<String> password({
  int minLength = 16,
  int maxLength = 32,
  int minUppercaseCount = 1,
  int minLowercaseCount = 1,
  int minNumberCount = 1,
  int minSpecialCharCount = 1,
  String Function(String input)? passwordMsg,
}) {
  if (maxLength < minLength) {
    throw ArgumentError.value(maxLength, 'maxLength',
        'The maxLength may not be less than minLength (=$minLength)');
  }
  final Validator<String> andValidator = and(<Validator<String>>[
    collection_val.minLength(minLength),
    collection_val.maxLength(maxLength),
    hasMinUppercaseChars(min: minUppercaseCount),
    hasMinLowercaseChars(min: minLowercaseCount),
    hasMinNumericChars(min: minNumberCount),
    hasMinSpecialChars(min: minSpecialCharCount),
  ]);
  String? validatorWithPasswordMsg(String input) =>
      andValidator(input) == null ? null : passwordMsg?.call(input);
  return passwordMsg != null ? validatorWithPasswordMsg : andValidator;
}

final RegExp _phoneNumberRegex = RegExp(
  r'^\+?(\d{1,4}[\s.-]?)?(\(?\d{1,4}\)?[\s.-]?)?(\d{1,4}[\s.-]?)?(\d{1,4}[\s.-]?)?(\d{1,9})$',
);

/// {@macro validator_phoneNumber}
Validator<String> phoneNumber({
  RegExp? regex,
  String Function(String input)? phoneNumberMsg,
}) {
  return (String input) {
    final String phoneNumber = input.replaceAll(' ', '').replaceAll('-', '');
    return (regex ?? _phoneNumberRegex).hasMatch(phoneNumber)
        ? null
        : phoneNumberMsg?.call(input) ??
            FormBuilderLocalizations.current.phoneErrorText;
  };
}

/// {@macro validator_email}
Validator<String> email({
  RegExp? regex,
  String Function(String input)? emailMsg,
}) {
  final RegExp defaultRegex = RegExp(
    r"^((([a-z]|\d|[!#$%&'*+\-/=?^_`{|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#$%&'*+\-/=?^_`{|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)(((([\x20\x09])*(\x0d\x0a))?([\x20\x09])+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*((([\x20\x09])*(\x0d\x0a))?([\x20\x09])+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$",
  );
  return (String input) {
    return (regex ?? defaultRegex).hasMatch(input.toLowerCase())
        ? null
        : emailMsg?.call(input) ??
            FormBuilderLocalizations.current.emailErrorText;
  };
}
