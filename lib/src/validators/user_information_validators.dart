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

final RegExp _creditCardRegex = RegExp(
  r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$',
);

Validator<String> creditCard({
  RegExp? regex,
  String? creditCardMsg,
}) {
  return (String value) {
    return _isCreditCard(value, regex ?? _creditCardRegex)
        ? null
        : creditCardMsg ?? FormBuilderLocalizations.current.creditCardErrorText;
  };
}

//******************************************************************************
//*                              Aux functions                                 *
//******************************************************************************
bool _isCreditCard(String value, RegExp regex) {
  final String sanitized = value.replaceAll(RegExp('[^0-9]+'), '');
  if (!regex.hasMatch(sanitized)) {
    return false;
  }

  // Luhn algorithm
  int sum = 0;
  String digit;
  bool shouldDouble = false;

  for (int i = sanitized.length - 1; i >= 0; i--) {
    digit = sanitized.substring(i, i + 1);
    int tmpNum = int.parse(digit);

    if (shouldDouble) {
      tmpNum *= 2;
      if (tmpNum >= 10) {
        sum += (tmpNum % 10) + 1;
      } else {
        sum += tmpNum;
      }
    } else {
      sum += tmpNum;
    }
    shouldDouble = !shouldDouble;
  }

  return (sum % 10 == 0);
}
