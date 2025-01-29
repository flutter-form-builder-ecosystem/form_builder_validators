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
