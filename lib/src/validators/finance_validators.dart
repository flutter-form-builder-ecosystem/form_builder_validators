import '../../localization/l10n.dart';
import 'constants.dart';

final RegExp _creditCardRegex = RegExp(
  r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$',
);

/// {@macro validator_creditCard}
Validator<String> creditCard({
  RegExp? regex,
  String Function(String input)? creditCardMsg,
}) {
  return (String input) {
    return _isCreditCard(input, regex ?? _creditCardRegex)
        ? null
        : creditCardMsg?.call(input) ??
            FormBuilderLocalizations.current.creditCardErrorText;
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
