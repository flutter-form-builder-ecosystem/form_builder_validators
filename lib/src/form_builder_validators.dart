import 'package:flutter/widgets.dart';

import '../form_builder_validators.dart';
import 'utils/helpers.dart';
import 'utils/validators.dart';

/// Provides utility methods for creating various [FormFieldValidator]s.
class FormBuilderValidators {
  /// [FormFieldValidator] that combines multiple validators into one.
  /// This validator applies each provided validator sequentially, and fails if any of them return a non-null result.
  ///
  /// ## Parameters:
  /// - [validators] The list of validators to compose.
  static FormFieldValidator<T> compose<T>(
    List<FormFieldValidator<T>> validators,
  ) {
    return (valueCandidate) {
      for (final validator in validators) {
        final validatorResult = validator.call(valueCandidate);
        if (validatorResult != null) {
          return validatorResult;
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that combines multiple validators, passing validation if any return null.
  /// This validator applies each provided validator sequentially, and passes if any of them return a null result.
  ///
  /// ## Parameters:
  /// - [validators] The list of validators to compose.
  static FormFieldValidator<T> or<T>(
    List<FormFieldValidator<T>> validators,
  ) {
    return (valueCandidate) {
      String? errorResult;
      for (final validator in validators) {
        final validatorResult = validator.call(valueCandidate);
        if (validatorResult == null) {
          return null;
        } else {
          errorResult = validatorResult;
        }
      }
      return errorResult;
    };
  }

  /// [FormFieldValidator] that transforms the value before applying the validator.
  /// This validator applies a transformer to the value before running the actual validator.
  ///
  /// ## Parameters:
  /// - [validator] The validator to apply.
  /// - [transformer] The transformer to apply.
  static FormFieldValidator transform<T>(
    FormFieldValidator<T> validator,
    T Function(T? value) transformer,
  ) {
    return (valueCandidate) {
      final transformedValue = transformer(valueCandidate);
      return validator(transformedValue);
    };
  }

  /// [FormFieldValidator] that runs validators and collects all error messages.
  /// This validator runs all provided validators and concatenates any error messages into a single string.
  ///
  /// ## Parameters:
  /// - [validators] The list of validators to run.
  static FormFieldValidator<T> aggregate<T>(
    List<FormFieldValidator<T>> validators,
  ) {
    return (valueCandidate) {
      final errors = <String>[];
      for (final validator in validators) {
        final error = validator(valueCandidate);
        if (error != null) {
          errors.add(error);
        }
      }
      return errors.isNotEmpty ? errors.join('\n') : null;
    };
  }

  /// [FormFieldValidator] that logs the value at a specific point in the validation chain.
  /// This validator logs the value being validated and always returns null.
  ///
  /// ## Parameters:
  /// - [log] The log message to display.
  static FormFieldValidator<T> log<T>({
    String Function(T? value)? log,
  }) {
    return (valueCandidate) {
      if (log != null) {
        debugPrint(log(valueCandidate));
      }
      return null;
    };
  }

  /// [FormFieldValidator] that skips the validation when a certain condition is met.
  /// This validator skips the provided validator if the condition is true.
  ///
  /// ## Parameters:
  /// - [condition] The condition to check.
  /// - [validator] The validator to skip.
  static FormFieldValidator<T> skipWhen<T>(
    bool Function(T? value) condition,
    FormFieldValidator<T> validator,
  ) {
    return (valueCandidate) {
      if (condition(valueCandidate)) {
        return null;
      }
      return validator(valueCandidate);
    };
  }

  /// [FormFieldValidator] that checks if the value is unique in a list of values.
  /// This validator ensures the value is unique within the provided list.
  ///
  /// ## Parameters:
  /// - [values] The list of values to check against.
  /// - [errorText] The error message to display when the value is not unique.
  static FormFieldValidator<T> unique<T>(
    List<T> values, {
    String? errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate == null ||
          values.where((element) => element == valueCandidate).length != 1) {
        return errorText ?? FormBuilderLocalizations.current.uniqueErrorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that transforms the value to a default if it's null or empty before running the validator.
  /// This validator uses a default value if the provided value is null or empty, and then applies the validator.
  ///
  /// ## Parameters:
  /// - [defaultValue] The default value to transform to.
  /// - [validator] The validator to apply.
  static FormFieldValidator<T> defaultValue<T>(
    T defaultValue,
    FormFieldValidator<T> validator,
  ) =>
      (valueCandidate) => validator(valueCandidate ?? defaultValue);

  /// [FormFieldValidator] that requires the field have a non-empty value.
  /// This validator checks if the field's value is not empty.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is empty.
  static FormFieldValidator<T> required<T>({
    String? errorText,
  }) {
    return (T? valueCandidate) {
      if (valueCandidate == null ||
          (valueCandidate is String && valueCandidate.trim().isEmpty) ||
          (valueCandidate is Iterable && valueCandidate.isEmpty) ||
          (valueCandidate is Map && valueCandidate.isEmpty)) {
        return errorText ?? FormBuilderLocalizations.current.requiredErrorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value be equal to the provided value.
  /// This validator checks if the field's value is equal to the given value.
  ///
  /// ## Parameters:
  /// - [value] The value to compare with.
  /// - [errorText] The error message to display when the value is not equal.
  static FormFieldValidator<T> equal<T>(
    Object value, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate != value
          ? errorText ?? FormBuilderLocalizations.current.equalErrorText(value)
          : null;

  /// [FormFieldValidator] that requires the field's value be not equal to the provided value.
  /// This validator checks if the field's value is not equal to the given value.
  ///
  /// ## Parameters:
  /// - [value] The value to compare with.
  /// - [errorText] The error message to display when the value is equal.
  static FormFieldValidator<T> notEqual<T>(
    Object value, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == value
          ? errorText ??
              FormBuilderLocalizations.current.notEqualErrorText(value)
          : null;

  /// [FormFieldValidator] that requires the field's value to be greater than (or equal) to the provided number.
  /// This validator checks if the field's value is greater than or equal to the given minimum value.
  ///
  /// ## Parameters:
  /// - [min] The minimum value to compare.
  /// - [inclusive] Whether the comparison is inclusive (default: true).
  /// - [errorText] The error message to display when the value is invalid.
  static FormFieldValidator<T> min<T>(
    num min, {
    bool inclusive = true,
    String? errorText,
  }) {
    return (T? valueCandidate) {
      if (valueCandidate != null) {
        assert(valueCandidate is num || valueCandidate is String);
        final number = valueCandidate is num
            ? valueCandidate
            : num.tryParse(valueCandidate.toString());

        if (number != null && (inclusive ? number < min : number <= min)) {
          return errorText ??
              FormBuilderLocalizations.current.minErrorText(min);
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be less than (or equal) to the provided number.
  /// This validator checks if the field's value is less than or equal to the given maximum value.
  ///
  /// ## Parameters:
  /// - [max] The maximum value to compare.
  /// - [inclusive] Whether the comparison is inclusive (default: true).
  /// - [errorText] The error message to display when the value is invalid.
  static FormFieldValidator<T> max<T>(
    num max, {
    bool inclusive = true,
    String? errorText,
  }) {
    return (T? valueCandidate) {
      if (valueCandidate != null) {
        assert(valueCandidate is num || valueCandidate is String);
        final number = valueCandidate is num
            ? valueCandidate
            : num.tryParse(valueCandidate.toString());

        if (number != null && (inclusive ? number > max : number >= max)) {
          return errorText ??
              FormBuilderLocalizations.current.maxErrorText(max);
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the length of the field's value to be greater than or equal to the provided minimum length.
  /// This validator checks if the length of the field's value meets the minimum length requirement.
  ///
  /// ## Parameters:
  /// - [minLength] The minimum length to compare.
  /// - [allowEmpty] Whether the field's value can be empty (default: false).
  /// - [errorText] The error message to display when the length is invalid.
  static FormFieldValidator<T> minLength<T>(
    int minLength, {
    bool allowEmpty = false,
    String? errorText,
  }) {
    assert(minLength > 0);
    return (T? valueCandidate) {
      assert(
        valueCandidate is String ||
            valueCandidate is Iterable ||
            valueCandidate == null,
      );
      var valueLength = 0;
      if (valueCandidate is String) valueLength = valueCandidate.length;
      if (valueCandidate is Iterable) valueLength = valueCandidate.length;
      return valueLength < minLength && (!allowEmpty || valueLength > 0)
          ? errorText ??
              FormBuilderLocalizations.current.minLengthErrorText(minLength)
          : null;
    };
  }

  /// [FormFieldValidator] that requires the length of the field's value to be less than or equal to the provided maximum length.
  /// This validator checks if the length of the field's value meets the maximum length requirement.
  ///
  /// ## Parameters:
  /// - [maxLength] The maximum length to compare.
  /// - [errorText] The error message to display when the length is invalid.
  static FormFieldValidator<T> maxLength<T>(
    int maxLength, {
    String? errorText,
  }) {
    assert(maxLength > 0);
    return (T? valueCandidate) {
      assert(
        valueCandidate is String ||
            valueCandidate is Iterable ||
            valueCandidate == null,
      );
      int valueLength = 0;
      if (valueCandidate is String) valueLength = valueCandidate.length;
      if (valueCandidate is Iterable) valueLength = valueCandidate.length;
      return null != valueCandidate && valueLength > maxLength
          ? errorText ??
              FormBuilderLocalizations.current.maxLengthErrorText(maxLength)
          : null;
    };
  }

  /// [FormFieldValidator] that requires the length of the field to be equal to the provided length. Works with String, iterable, and int types.
  /// This validator checks if the length of the field's value is equal to the given length.
  ///
  /// ## Parameters:
  /// - [length] The length to compare.
  /// - [allowEmpty] Whether the field's value can be empty (default: false).
  /// - [errorText] The error message to display when the length is invalid.
  static FormFieldValidator<T> equalLength<T>(
    int length, {
    bool allowEmpty = false,
    String? errorText,
  }) {
    assert(length > 0);
    return (T? valueCandidate) {
      assert(
        valueCandidate is String ||
            valueCandidate is Iterable ||
            valueCandidate is int ||
            valueCandidate == null,
      );
      int valueLength = 0;

      if (valueCandidate is int) valueLength = valueCandidate.toString().length;
      if (valueCandidate is String) valueLength = valueCandidate.length;
      if (valueCandidate is Iterable) valueLength = valueCandidate.length;

      return valueLength != length && (!allowEmpty || valueLength > 0)
          ? errorText ??
              FormBuilderLocalizations.current.equalLengthErrorText(length)
          : null;
    };
  }

  /// [FormFieldValidator] that requires the word count of the field's value to be greater than or equal to the provided minimum count.
  /// This validator checks if the word count of the field's value meets the minimum count requirement.
  ///
  /// ## Parameters:
  /// - [minCount] The minimum word count.
  /// - [allowEmpty] Whether the field's value can be empty (default: false).
  /// - [errorText] The error message to display when the word count is invalid.
  static FormFieldValidator<String> minWordsCount(
    int minCount, {
    bool allowEmpty = false,
    String? errorText,
  }) {
    assert(minCount > 0, 'The minimum words count must be greater than 0');
    return (valueCandidate) {
      int valueWordsCount = 0;

      if (valueCandidate != null && valueCandidate.trim().isNotEmpty) {
        valueWordsCount = valueCandidate.trim().split(' ').length;
      }

      return valueWordsCount < minCount && (!allowEmpty || valueWordsCount > 0)
          ? errorText ??
              FormBuilderLocalizations.current.minWordsCountErrorText(minCount)
          : null;
    };
  }

  /// [FormFieldValidator] that requires the word count of the field's value to be less than or equal to the provided maximum count.
  /// This validator checks if the word count of the field's value meets the maximum count requirement.
  ///
  /// ## Parameters:
  /// - [maxCount] The maximum word count.
  /// - [errorText] The error message to display when the word count is invalid.
  static FormFieldValidator<String> maxWordsCount(
    int maxCount, {
    String? errorText,
  }) {
    assert(maxCount > 0, 'The maximum words count must be greater than 0');
    return (valueCandidate) {
      final int valueWordsCount = valueCandidate?.trim().split(' ').length ?? 0;
      return null != valueCandidate && valueWordsCount > maxCount
          ? errorText ??
              FormBuilderLocalizations.current.maxWordsCountErrorText(maxCount)
          : null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid email address.
  ///
  /// {@macro email_template}
  /// {@macro email_regex_template}
  static FormFieldValidator<String> email({
    String? errorText,
    RegExp? emailRegex,
  }) =>
      EmailValidator(
        errorText: errorText ?? FormBuilderLocalizations.current.emailErrorText,
        emailRegex: emailRegex,
      ).call;

  /// [FormFieldValidator] that requires the field's value to be a valid URL.
  /// This validator checks if the field's value is a valid URL.
  ///
  /// ## Parameters:
  /// - [protocols] The list of allowed protocols (default: ['http', 'https', 'ftp']).
  /// - [requireTld] Whether TLD is required (default: true).
  /// - [requireProtocol] Whether protocol is required for validation (default: false).
  /// - [allowUnderscore] Whether underscores are allowed (default: false).
  /// - [hostWhitelist] The list of allowed hosts.
  /// - [hostBlacklist] The list of disallowed hosts.
  /// - [errorText] The error message to display when the URL is invalid.
  static FormFieldValidator<String> url({
    String? errorText,
    List<String> protocols = const ['http', 'https', 'ftp'],
    bool requireTld = true,
    bool requireProtocol = false,
    bool allowUnderscore = false,
    List<String> hostWhitelist = const [],
    List<String> hostBlacklist = const [],
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              !isURL(
                valueCandidate,
                protocols: protocols,
                requireTld: requireTld,
                requireProtocol: requireProtocol,
                allowUnderscore: allowUnderscore,
                hostWhitelist: hostWhitelist,
                hostBlacklist: hostBlacklist,
              )
          ? errorText ?? FormBuilderLocalizations.current.urlErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to match the provided regex pattern.
  /// This validator checks if the field's value matches the given regex pattern.
  ///
  /// ## Parameters:
  /// - [pattern] The regex pattern to match.
  /// - [errorText] The error message to display when the value does not match the pattern.
  static FormFieldValidator<String> match(
    String pattern, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              !RegExp(pattern).hasMatch(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.matchErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value not to match the provided regex pattern.
  /// This validator checks if the field's value does not match the given regex pattern.
  ///
  /// ## Parameters:
  /// - [pattern] The regex pattern to match.
  /// - [errorText] The error message to display when the value matches the pattern.
  static FormFieldValidator<String> notMatch(
    String pattern, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              RegExp(pattern).hasMatch(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.matchErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid number.
  /// This validator checks if the field's value is a valid number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the number is invalid.
  static FormFieldValidator<String> numeric({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              null == num.tryParse(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.numericErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid integer.
  /// This validator checks if the field's value is a valid integer.
  ///
  /// ## Parameters:
  /// - [radix] The radix to use when parsing the integer.
  /// - [errorText] The error message to display when the integer is invalid.
  static FormFieldValidator<String> integer({
    String? errorText,
    int? radix,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              null == int.tryParse(valueCandidate!, radix: radix)
          ? errorText ?? FormBuilderLocalizations.current.integerErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid credit card number.
  /// This validator checks if the field's value is a valid credit card number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the credit card number is invalid.
  ///
  /// {@macro credit_card_template}
  static FormFieldValidator<String> creditCard({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              !isCreditCard(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.creditCardErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid credit card expiration date.
  /// This validator checks if the field's value is a valid credit card expiration date.
  ///
  /// ## Parameters:
  /// - [checkForExpiration] Whether the expiration date should be checked (default: true).
  /// - [errorText] The error message to display when the expiration date is invalid.
  ///
  /// {@macro credit_card_expiration_template}
  static FormFieldValidator<String> creditCardExpirationDate({
    bool checkForExpiration = true,
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              !isCreditCardExpirationDate(valueCandidate!)
          ? errorText ??
              FormBuilderLocalizations.current.creditCardExpirationDateErrorText
          : (checkForExpiration && !isNotExpiredCreditCardDate(valueCandidate!))
              ? errorText ??
                  FormBuilderLocalizations.current.creditCardExpiredErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid credit card CVC.
  /// This validator checks if the field's value is a valid credit card CVC.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the CVC is invalid.
  static FormFieldValidator<String> creditCardCVC({
    String? errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate == null || valueCandidate.isEmpty) {
        return errorText ??
            FormBuilderLocalizations.current.creditCardCVCErrorText;
      } else {
        final cvc = int.tryParse(valueCandidate);
        if (cvc == null ||
            valueCandidate.length < 3 ||
            valueCandidate.length > 4) {
          return errorText ??
              FormBuilderLocalizations.current.creditCardCVCErrorText;
        } else {
          return null;
        }
      }
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid IP address.
  /// This validator checks if the field's value is a valid IP address.
  ///
  /// ## Parameters:
  /// - [version] The IP version (4 or 6).
  /// - [errorText] The error message to display when the IP address is invalid.
  ///
  /// {@macro ipv4_template}
  ///
  /// {@macro ipv6_template}
  static FormFieldValidator<String> ip({
    int? version,
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isNotEmpty == true && !isIP(valueCandidate, version)
              ? errorText ?? FormBuilderLocalizations.current.ipErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid date string.
  /// This validator checks if the field's value is a valid date string.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the date is invalid.
  static FormFieldValidator<String> dateString({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              !isDateTime(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.dateStringErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid time string.
  /// This validator checks if the field's value is a valid time string.
  ///
  /// The validator supports various time formats, both 24-hour and 12-hour clocks.
  ///
  /// ## Valid 24-hour time formats:
  /// - `HH:mm`: Hours and minutes, e.g., `23:59`
  /// - `HH:mm:ss`: Hours, minutes, and seconds, e.g., `23:59:59`
  /// - `HH:mm:ss.SSS`: Hours, minutes, seconds, and milliseconds, e.g., `23:59:59.999`
  ///
  /// ## Valid 12-hour time formats:
  /// - `h:mm a`: Hours and minutes with AM/PM, e.g., `11:59 PM`
  /// - `h:mm:ss a`: Hours, minutes, and seconds with AM/PM, e.g., `11:59:59 PM`
  /// - `h:mm:ss.SSS a`: Hours, minutes, seconds, and milliseconds with AM/PM, e.g., `11:59:59.999 PM`
  ///
  /// ## Parameters:
  /// - [errorText] (optional): The error message to display when the time is invalid.
  ///
  /// ## Returns:
  /// If the value is null, empty, or not a valid time, it returns the [errorText] or a default error message.
  ///
  /// {@macro time_template}
  static FormFieldValidator<String> time({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == null ||
              valueCandidate.isEmpty ||
              !isTime(valueCandidate)
          ? errorText ?? FormBuilderLocalizations.current.timeErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid date.
  /// This validator checks if the field's value is a valid date.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the date is invalid.
  static FormFieldValidator<DateTime?> dateTime({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == null
          ? errorText ?? FormBuilderLocalizations.current.dateStringErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a date within a certain range.
  /// This validator checks if the field's value is a date within the given range.
  ///
  /// ## Parameters:
  /// - [minDate] The minimum date that the field's value should be greater than or equal to.
  /// - [maxDate] The maximum date that the field's value should be less than or equal to.
  /// - [errorText] The error message to display when the date is not in the range.
  static FormFieldValidator<String> dateRange({
    required DateTime minDate,
    required DateTime maxDate,
    String? errorText,
  }) =>
      (String? valueCandidate) {
        if (valueCandidate == null || !isDateTime(valueCandidate)) {
          return errorText ??
              FormBuilderLocalizations.current.dateStringErrorText;
        }

        final DateTime date = DateTime.parse(valueCandidate);
        return date.isBefore(minDate) || date.isAfter(maxDate)
            ? errorText ??
                FormBuilderLocalizations.current
                    .dateRangeErrorText(minDate.toString(), maxDate.toString())
            : null;
      };

  /// [FormFieldValidator] that requires the field's value to be a valid phone number.
  /// This validator checks if the field's value is a valid phone number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the phone number is invalid.
  ///
  /// {@macro phone_number_template}
  static FormFieldValidator<String> phoneNumber({
    String? errorText,
  }) =>
      (valueCandidate) {
        if (valueCandidate == null || valueCandidate.isEmpty) {
          return errorText ?? FormBuilderLocalizations.current.phoneErrorText;
        }
        return !isPhoneNumber(valueCandidate)
            ? errorText ?? FormBuilderLocalizations.current.phoneErrorText
            : null;
      };

  /// [FormFieldValidator] that requires the field's value to be a valid color code.
  /// This validator checks if the field's value is a valid color code.
  ///
  /// ## Parameters:
  /// - [formats] The list of allowed color code formats (e.g., ['hex', 'rgb', 'hsl']).
  /// - [errorText] The error message to display when the color code is invalid.
  ///
  /// {@macro hex_template}
  ///
  /// {@macro rgb_template}
  ///
  /// {@macro hsl_template}
  static FormFieldValidator<String> colorCode({
    List<String> formats = const ['hex', 'rgb', 'hsl'],
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              !isColorCode(valueCandidate!, formats: formats)
          ? errorText ??
              FormBuilderLocalizations.current
                  .colorCodeErrorText(formats.join(', '))
          : null;

  /// [FormFieldValidator] that requires the field's value to be uppercase.
  /// This validator checks if the field's value is uppercase.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not uppercase.
  static FormFieldValidator<String> uppercase({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              valueCandidate!.toUpperCase() != valueCandidate
          ? errorText ?? FormBuilderLocalizations.current.uppercaseErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be lowercase.
  /// This validator checks if the field's value is lowercase.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not lowercase.
  static FormFieldValidator<String> lowercase({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              valueCandidate!.toLowerCase() != valueCandidate
          ? errorText ?? FormBuilderLocalizations.current.lowercaseErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid file extension.
  /// This validator checks if the field's value is a valid file extension.
  ///
  /// ## Parameters:
  /// - [allowedExtensions] The list of allowed file extensions.
  /// - [errorText] The error message to display when the file extension is invalid.
  static FormFieldValidator<String> fileExtension({
    required List<String> allowedExtensions,
    String? errorText,
  }) {
    final allowedExtensionsLowerCase =
        allowedExtensions.map((e) => e.toLowerCase()).toList();

    return (valueCandidate) {
      if (valueCandidate == null || valueCandidate.isEmpty) {
        return errorText ??
            FormBuilderLocalizations.current.fileExtensionErrorText(
              allowedExtensions.join(', '),
            );
      }

      final extension = fileExtensionFromPath(valueCandidate).toLowerCase();
      if (!allowedExtensionsLowerCase.contains(extension)) {
        return errorText ??
            FormBuilderLocalizations.current.fileExtensionErrorText(
              allowedExtensions.join(', '),
            );
      }

      return null;
    };
  }

  /// [FormFieldValidator] that restricts the size of a file to be less than or equal to the provided maximum size.
  /// This validator checks if the file size is within the given limit.
  ///
  /// ## Parameters:
  /// - [maxSize] The maximum size in bytes.
  /// - [errorText] The error message to display when the file size exceeds the limit.
  static FormFieldValidator<String> fileSize({
    required int maxSize,
    String? errorText,
  }) =>
      (valueCandidate) {
        if (valueCandidate == null || valueCandidate.isEmpty) {
          return errorText ??
              FormBuilderLocalizations.current
                  .fileSizeErrorText(formatBytes(0), formatBytes(maxSize));
        }

        final size = int.tryParse(valueCandidate);
        if (size == null || size > maxSize) {
          return errorText ??
              FormBuilderLocalizations.current.fileSizeErrorText(
                  formatBytes(size ?? 0), formatBytes(maxSize));
        }

        return null;
      };

  /// [FormFieldValidator] that applies another validator conditionally.
  /// This validator applies a provided validator based on the specified condition.
  ///
  /// ## Parameters:
  /// - [condition] A function that determines if the validator should be applied.
  /// - [validator] The validator to apply if the condition is met.
  static FormFieldValidator<T> conditional<T>(
    bool Function(T value) condition,
    FormFieldValidator<T> validator,
  ) =>
      (valueCandidate) {
        if (valueCandidate != null && condition(valueCandidate)) {
          return validator(valueCandidate);
        }
        return null;
      };

  /// [FormFieldValidator] that requires the field's value to be within a certain range.
  /// This validator checks if the field's value is within the specified numerical range.
  ///
  /// ## Parameters:
  /// - [minValue] The minimum value that the field's value should be greater than or equal to.
  /// - [maxValue] The maximum value that the field's value should be less than or equal to.
  /// - [inclusive] Whether the range is inclusive (default: true).
  /// - [errorText] The error message to display when the value is not in the range.
  static FormFieldValidator<T> range<T>(
    num minValue,
    num maxValue, {
    bool inclusive = true,
    String? errorText,
  }) {
    return (T? valueCandidate) {
      if (valueCandidate != null) {
        assert(valueCandidate is num || valueCandidate is String);
        final number = valueCandidate is num
            ? valueCandidate
            : num.tryParse(valueCandidate.toString());

        final minResult =
            min(minValue, inclusive: inclusive, errorText: errorText)(number);
        final maxResult =
            max(maxValue, inclusive: inclusive, errorText: errorText)(number);

        if (minResult != null || maxResult != null) {
          return errorText ?? minResult ?? maxResult;
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a bool and true.
  /// This validator checks if the field's value is true.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not true.
  static FormFieldValidator<bool> isTrue({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate != true
          ? errorText ?? FormBuilderLocalizations.current.mustBeTrueErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a bool and false.
  /// This validator checks if the field's value is false.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not false.
  static FormFieldValidator<bool> isFalse({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate != false
          ? errorText ?? FormBuilderLocalizations.current.mustBeFalseErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to contain a minimum number of special characters.
  /// This validator checks if the field's value contains the specified number of special characters.
  ///
  /// ## Parameters:
  /// - [atLeast] The minimum number of special characters (default: 1).
  /// - [errorText] The error message to display when the value does not contain the required number of special characters.
  static FormFieldValidator<String> hasSpecialChars({
    int atLeast = 1,
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              specialCharLength(valueCandidate!) >= atLeast
          ? null
          : errorText ??
              FormBuilderLocalizations.current
                  .containsSpecialCharErrorText(atLeast);

  /// [FormFieldValidator] that requires the field's value to contain a minimum number of uppercase characters.
  /// This validator checks if the field's value contains the specified number of uppercase characters.
  ///
  /// ## Parameters:
  /// - [atLeast] The minimum number of uppercase characters (default: 1).
  /// - [errorText] The error message to display when the value does not contain the required number of uppercase characters.
  static FormFieldValidator<String> hasUppercaseChars({
    int atLeast = 1,
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              uppercaseCharLength(valueCandidate!) >= atLeast
          ? null
          : errorText ??
              FormBuilderLocalizations.current
                  .containsUppercaseCharErrorText(atLeast);

  /// [FormFieldValidator] that requires the field's value to contain a minimum number of lowercase characters.
  /// This validator checks if the field's value contains the specified number of lowercase characters.
  ///
  /// ## Parameters:
  /// - [atLeast] The minimum number of lowercase characters (default: 1).
  /// - [errorText] The error message to display when the value does not contain the required number of lowercase characters.
  static FormFieldValidator<String> hasLowercaseChars({
    int atLeast = 1,
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              lowercaseCharLength(valueCandidate!) >= atLeast
          ? null
          : errorText ??
              FormBuilderLocalizations.current
                  .containsLowercaseCharErrorText(atLeast);

  /// [FormFieldValidator] that requires the field's value to contain a minimum number of numeric characters.
  /// This validator checks if the field's value contains the specified number of numeric characters.
  ///
  /// ## Parameters:
  /// - [atLeast] The minimum number of numeric characters (default: 1).
  /// - [errorText] The error message to display when the value does not contain the required number of numeric characters.
  static FormFieldValidator<String> hasNumericChars({
    int atLeast = 1,
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              numberCharLength(valueCandidate!) >= atLeast
          ? null
          : errorText ??
              FormBuilderLocalizations.current.containsNumberErrorText(atLeast);

  /// [FormFieldValidator] that requires the field's value to be a valid username.
  /// This validator checks if the field's value meets the criteria for a valid username.
  ///
  /// ## Parameters:
  /// - [minLength] The minimum length of the username (default: 3).
  /// - [maxLength] The maximum length of the username (default: 32).
  /// - [errorText] The error message to display when the username is invalid.
  /// - [allowNumbers] Whether digits are allowed (default: true).
  /// - [allowUnderscore] Whether underscores are allowed (default: false).
  /// - [allowDots] Whether dots are allowed (default: false).
  /// - [allowDash] Whether dashes are allowed (default: false).
  /// - [allowSpace] Whether spaces are allowed (default: false).
  /// - [allowSpecialChar] Whether special characters are allowed (default: false).
  static FormFieldValidator<String> username({
    int minLength = 3,
    int maxLength = 32,
    String? errorText,
    bool allowNumbers = true,
    bool allowUnderscore = false,
    bool allowDots = false,
    bool allowDash = false,
    bool allowSpace = false,
    bool allowSpecialChar = false,
  }) {
    return FormBuilderValidators.compose<String>(
      [
        FormBuilderValidators.minLength(minLength, errorText: errorText),
        FormBuilderValidators.maxLength(maxLength, errorText: errorText),
        if (!allowNumbers)
          FormBuilderValidators.notMatch(
            r'[0-9]',
            errorText: errorText,
          ),
        if (!allowUnderscore)
          FormBuilderValidators.notMatch(
            r'_',
            errorText: errorText,
          ),
        if (!allowDots)
          FormBuilderValidators.notMatch(
            r'\.',
            errorText: errorText,
          ),
        if (!allowDash)
          FormBuilderValidators.notMatch(
            r'-',
            errorText: errorText,
          ),
        if (!allowSpace)
          FormBuilderValidators.notMatch(
            r'\s',
            errorText: errorText,
          ),
        if (!allowSpecialChar)
          FormBuilderValidators.notMatch(
            r'[!@#\$%^&*(),.?":{}|<>]',
            errorText: errorText,
          ),
      ],
    );
  }

  /// [FormFieldValidator] that requires the field's value to be a valid password.
  /// This validator checks if the field's value meets the criteria for a valid password.
  ///
  /// ## Parameters:
  /// - [minLength] The minimum length of the password (default: 8).
  /// - [maxLength] The maximum length of the password (default: 32).
  /// - [uppercase] The minimum number of uppercase characters (default: 1).
  /// - [lowercase] The minimum number of lowercase characters (default: 1).
  /// - [number] The minimum number of numeric characters (default: 1).
  /// - [specialChar] The minimum number of special characters (default: 1).
  /// - [errorText] The error message to display when the password is invalid.
  static FormFieldValidator<String> password({
    int minLength = 8,
    int maxLength = 32,
    int uppercase = 1,
    int lowercase = 1,
    int number = 1,
    int specialChar = 1,
    String? errorText,
  }) {
    return FormBuilderValidators.compose<String>(
      [
        FormBuilderValidators.minLength(minLength, errorText: errorText),
        FormBuilderValidators.maxLength(maxLength, errorText: errorText),
        if (uppercase > 0)
          FormBuilderValidators.hasUppercaseChars(
              atLeast: uppercase, errorText: errorText),
        if (lowercase > 0)
          FormBuilderValidators.hasLowercaseChars(
              atLeast: lowercase, errorText: errorText),
        if (number > 0)
          FormBuilderValidators.hasNumericChars(
              atLeast: number, errorText: errorText),
        if (specialChar > 0)
          FormBuilderValidators.hasSpecialChars(
              atLeast: specialChar, errorText: errorText),
      ],
    );
  }

  /// [FormFieldValidator] that requires the field's value to be alphabetical.
  /// This validator checks if the field's value contains only alphabetical characters.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not alphabetical.
  ///
  /// {@macro alphabetical_template}
  static FormFieldValidator<String> alphabetical({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == null ||
              valueCandidate.isEmpty ||
              !isAlphabetical(valueCandidate)
          ? errorText ?? FormBuilderLocalizations.current.alphabeticalErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid UUID.
  /// This validator checks if the field's value is a valid UUID.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the UUID is invalid.
  ///
  /// {@macro uuid_template}
  static FormFieldValidator<String> uuid({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == null ||
              valueCandidate.isEmpty ||
              !isUUID(valueCandidate)
          ? errorText ?? FormBuilderLocalizations.current.uuidErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be valid JSON.
  /// This validator checks if the field's value is valid JSON.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the JSON is invalid.
  static FormFieldValidator<String> json({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isJSON(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.jsonErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid latitude.
  /// This validator checks if the field's value is a valid latitude.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the latitude is invalid.
  static FormFieldValidator<String> latitude({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isLatitude(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.latitudeErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid longitude.
  /// This validator checks if the field's value is a valid longitude.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the longitude is invalid.
  static FormFieldValidator<String> longitude({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isLongitude(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.longitudeErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid base64 string.
  /// This validator checks if the field's value is a valid base64 string.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the base64 string is invalid.
  static FormFieldValidator<String> base64({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isBase64(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.base64ErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid file or folder path.
  /// This validator checks if the field's value is a valid file or folder path.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the path is invalid.
  ///
  /// {@macro file_path_template}
  static FormFieldValidator<String> path({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isFilePath(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.pathErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be an odd number.
  /// This validator checks if the field's value is an odd number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not an odd number.
  static FormFieldValidator<String> oddNumber({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isOddNumber(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.oddNumberErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be an even number.
  /// This validator checks if the field's value is an even number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not an even number.
  static FormFieldValidator<String> evenNumber({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isEmpty != false ||
              !isEvenNumber(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.evenNumberErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid port number.
  /// This validator checks if the field's value is a valid port number.
  ///
  /// ## Parameters:
  /// - [min] The minimum port number (default: 0).
  /// - [max] The maximum port number (default: 65535).
  /// - [errorText] The error message to display when the port number is invalid.
  static FormFieldValidator<String> portNumber({
    int min = 0,
    int max = 65535,
    String? errorText,
  }) =>
      (valueCandidate) {
        if (valueCandidate?.isNotEmpty == true) {
          int? port = int.tryParse(valueCandidate!);
          if (port == null || port < min || port > max) {
            return errorText ??
                FormBuilderLocalizations.current.portNumberErrorText(min, max);
          }
        } else {
          return errorText ??
              FormBuilderLocalizations.current.portNumberErrorText(min, max);
        }
        return null;
      };

  /// [FormFieldValidator] that requires the field's value to be a valid MAC address.
  /// This validator checks if the field's value is a valid MAC address.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the MAC address is invalid.
  ///
  /// {@macro mac_address_template}
  static FormFieldValidator<String> macAddress({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isEmpty != false ||
              !isMACAddress(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.macAddressErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to start with a specific value.
  /// This validator checks if the field's value starts with the given prefix.
  ///
  /// ## Parameters:
  /// - [prefix] The value that the field's value should start with.
  /// - [errorText] The error message to display when the value does not start with the prefix.
  static FormFieldValidator<String> startsWith({
    required String prefix,
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isEmpty != false ||
              !valueCandidate!.startsWith(prefix)
          ? errorText ??
              FormBuilderLocalizations.current.startsWithErrorText(prefix)
          : null;

  /// [FormFieldValidator] that requires the field's value to end with a specific value.
  /// This validator checks if the field's value ends with the given suffix.
  ///
  /// ## Parameters:
  /// - [suffix] The value that the field's value should end with.
  /// - [errorText] The error message to display when the value does not end with the suffix.
  static FormFieldValidator<String> endsWith({
    required String suffix,
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !valueCandidate!.endsWith(suffix)
              ? errorText ??
                  FormBuilderLocalizations.current.endsWithErrorText(suffix)
              : null;

  /// [FormFieldValidator] that requires the field's value to contain a specific value.
  /// This validator checks if the field's value contains the given substring.
  ///
  /// ## Parameters:
  /// - [substring] The value that the field's value should contain.
  /// - [caseSensitive] Whether the search is case-sensitive (default: true).
  /// - [errorText] The error message to display when the value does not contain the substring.
  static FormFieldValidator<String> contains({
    required String substring,
    bool caseSensitive = true,
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isEmpty != false ||
              caseSensitive && !valueCandidate!.contains(substring) ||
              !caseSensitive &&
                  !valueCandidate!
                      .toLowerCase()
                      .contains(substring.toLowerCase())
          ? errorText ??
              FormBuilderLocalizations.current.containsErrorText(substring)
          : null;

  /// [FormFieldValidator] that requires the field's value to be between two numbers.
  /// This validator checks if the field's value is between the given minimum and maximum values.
  ///
  /// ## Parameters:
  /// - [min] The minimum value that the field's value should be greater than or equal to.
  /// - [max] The maximum value that the field's value should be less than or equal to.
  /// - [errorText] The error message to display when the value is not in the range.
  static FormFieldValidator<num> between({
    required num min,
    required num max,
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate == null || valueCandidate < min || valueCandidate > max
              ? errorText ??
                  FormBuilderLocalizations.current.betweenErrorText(min, max)
              : null;

  /// [FormFieldValidator] that requires the field's value to be in a list of values.
  /// This validator checks if the field's value is in the given list of values.
  ///
  /// ## Parameters:
  /// - [values] The list of values that the field's value should be in.
  /// - [errorText] The error message to display when the value is not in the list.
  static FormFieldValidator<T> containsElement<T>(
    List<T> values, {
    String? errorText,
  }) =>
      (valueCandidate) => !values.contains(valueCandidate)
          ? errorText ??
              FormBuilderLocalizations.current.containsElementErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid IBAN.
  /// This validator checks if the field's value is a valid IBAN.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the IBAN is invalid.
  static FormFieldValidator<String> iban({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isIBAN(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.ibanErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid BIC.
  /// This validator checks if the field's value is a valid BIC.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the BIC is invalid.
  ///
  /// {@macro bic_template}
  static FormFieldValidator<String> bic({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isBIC(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.bicErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid ISBN.
  /// This validator checks if the field's value is a valid ISBN.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the ISBN is invalid.
  static FormFieldValidator<String> isbn({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isISBN(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.isbnErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a single line.
  /// This validator checks if the field's value is a single line.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not a single line.
  static FormFieldValidator<String> singleLine({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isEmpty != false ||
              !isSingleLine(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.singleLineErrorText
          : null;
}
