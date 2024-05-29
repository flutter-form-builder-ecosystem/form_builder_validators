import 'package:flutter/material.dart';
import '../form_builder_validators.dart';

import 'utils/helpers.dart';
import 'utils/validators.dart';

/// For creation of [FormFieldValidator]s.
class FormBuilderValidators {
  /// [FormFieldValidator] that is composed of other [FormFieldValidator]s.
  ///
  /// Each validator is run against the [FormField] value and if any returns a
  /// non-null result, validation fails; otherwise, validation passes.
  ///
  /// ## Parameters:
  /// - [validators] The list of validators to compose.
  ///
  /// ## Returns:
  /// A combined validator that applies all the provided validators in sequence.
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

  /// [FormFieldValidator] that is composed of other [FormFieldValidator]s.
  ///
  /// Each validator is run against the [FormField] value and if any returns a
  /// null result, validation passes.
  ///
  /// ## Parameters:
  /// - [validators] The list of validators to compose.
  ///
  /// ## Returns:
  /// A combined validator that applies all the provided validators in sequence, passing if any validator returns null.
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
  ///
  /// ## Parameters:
  /// - [validator] The validator to apply.
  /// - [transformer] The transformer to apply.
  ///
  /// ## Returns:
  /// A validator that first applies the [transformer] to the value and then applies the [validator].
  static FormFieldValidator transform<T>(
    FormFieldValidator<T> validator,
    T Function(T? value) transformer,
  ) {
    return (valueCandidate) {
      final transformedValue = transformer(valueCandidate);
      return validator(transformedValue);
    };
  }

  /// [FormFieldValidator] that runs validators and collects all errors.
  ///
  /// ## Parameters:
  /// - [validators] The list of validators to run.
  ///
  /// ## Returns:
  /// A combined validator that applies all the provided validators and returns all error messages concatenated by newline.
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
  ///
  /// ## Parameters:
  /// - [log] The log message to display.
  ///
  /// ## Returns:
  /// A validator that logs the value and always returns null.
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
  ///
  /// ## Parameters:
  /// - [condition] The condition to check.
  /// - [validator] The validator to skip.
  ///
  /// ## Returns:
  /// A validator that skips the [validator] when [condition] is true.
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
  ///
  /// ## Parameters:
  /// - [values] The list of values to check against.
  /// - [errorText] The error message to display when the value is not unique.
  ///
  /// ## Returns:
  /// A validator that checks if the value is unique.
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
  ///
  /// ## Parameters:
  /// - [defaultValue] The default value to transform to.
  /// - [validator] The validator to apply.
  ///
  /// ## Returns:
  /// A validator that uses [defaultValue] if the value is null or empty, then applies the [validator].
  static FormFieldValidator<T> defaultValue<T>(
    T defaultValue,
    FormFieldValidator<T> validator,
  ) =>
      (valueCandidate) => validator(valueCandidate ?? defaultValue);

  /// [FormFieldValidator] that requires the field have a non-empty value.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is empty.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is not empty.
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
  ///
  /// ## Parameters:
  /// - [value] The value to compare with.
  /// - [errorText] The error message to display when the value is not equal.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is equal to [value].
  static FormFieldValidator<T> equal<T>(
    Object value, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate != value
          ? errorText ?? FormBuilderLocalizations.current.equalErrorText(value)
          : null;

  /// [FormFieldValidator] that requires the field's value be not equal to the provided value.
  ///
  /// ## Parameters:
  /// - [value] The value to compare with.
  /// - [errorText] The error message to display when the value is equal.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is not equal to [value].
  static FormFieldValidator<T> notEqual<T>(
    Object value, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == value
          ? errorText ??
              FormBuilderLocalizations.current.notEqualErrorText(value)
          : null;

  /// [FormFieldValidator] that requires the field's value to be greater than (or equal) to the provided number.
  ///
  /// ## Parameters:
  /// - [min] The minimum value to compare.
  /// - [inclusive] Whether the comparison is inclusive (default: true).
  /// - [errorText] The error message to display when the value is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is greater than (or equal) to [min].
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
  ///
  /// ## Parameters:
  /// - [max] The maximum value to compare.
  /// - [inclusive] Whether the comparison is inclusive (default: true).
  /// - [errorText] The error message to display when the value is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is less than (or equal) to [max].
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
  ///
  /// ## Parameters:
  /// - [minLength] The minimum length to compare.
  /// - [allowEmpty] Whether the field's value can be empty (default: false).
  /// - [errorText] The error message to display when the length is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the length of the field's value is greater than or equal to [minLength].
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
  ///
  /// ## Parameters:
  /// - [maxLength] The maximum length to compare.
  /// - [errorText] The error message to display when the length is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the length of the field's value is less than or equal to [maxLength].
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
  ///
  /// ## Parameters:
  /// - [length] The length to compare.
  /// - [allowEmpty] Whether the field's value can be empty (default: false).
  /// - [errorText] The error message to display when the length is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the length of the field's value is equal to [length].
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
  ///
  /// ## Parameters:
  /// - [minCount] The minimum word count.
  /// - [allowEmpty] Whether the field's value can be empty (default: false).
  /// - [errorText] The error message to display when the word count is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the word count of the field's value is greater than or equal to [minCount].
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
  ///
  /// ## Parameters:
  /// - [maxCount] The maximum word count.
  /// - [errorText] The error message to display when the word count is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the word count of the field's value is less than or equal to [maxCount].
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
  /// ## Parameters:
  /// - [errorText] The error message to display when the email is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid email address.
  static FormFieldValidator<String> email({
    String? errorText,
  }) =>
      (valueCandidate) =>
          (valueCandidate?.isNotEmpty ?? false) && !isEmail(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.emailErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid URL.
  ///
  /// ## Parameters:
  /// - [protocols] The list of allowed protocols (default: ['http', 'https', 'ftp']).
  /// - [requireTld] Whether TLD is required (default: true).
  /// - [requireProtocol] Whether protocol is required for validation (default: false).
  /// - [allowUnderscore] Whether underscores are allowed (default: false).
  /// - [hostWhitelist] The list of allowed hosts.
  /// - [hostBlacklist] The list of disallowed hosts.
  /// - [errorText] The error message to display when the URL is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid URL.
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
  ///
  /// ## Parameters:
  /// - [pattern] The regex pattern to match.
  /// - [errorText] The error message to display when the value does not match the pattern.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value matches the [pattern].
  static FormFieldValidator<String> match(
    String pattern, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              !RegExp(pattern).hasMatch(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.matchErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value not to match the provided regex pattern.
  ///
  /// ## Parameters:
  /// - [pattern] The regex pattern to match.
  /// - [errorText] The error message to display when the value matches the pattern.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value does not match the [pattern].
  static FormFieldValidator<String> notMatch(
    String pattern, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              RegExp(pattern).hasMatch(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.matchErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the number is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid number.
  static FormFieldValidator<String> numeric({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              null == num.tryParse(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.numericErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid integer.
  ///
  /// ## Parameters:
  /// - [radix] The radix to use when parsing the integer.
  /// - [errorText] The error message to display when the integer is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid integer.
  static FormFieldValidator<String> integer({
    String? errorText,
    int? radix,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              null == int.tryParse(valueCandidate!, radix: radix)
          ? errorText ?? FormBuilderLocalizations.current.integerErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid credit card number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the credit card number is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid credit card number.
  static FormFieldValidator<String> creditCard({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              !isCreditCard(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.creditCardErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid credit card expiration date.
  ///
  /// ## Parameters:
  /// - [checkForExpiration] Whether the expiration date should be checked (default: true).
  /// - [errorText] The error message to display when the expiration date is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid credit card expiration date.
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
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the CVC is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid credit card CVC.
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
  ///
  /// ## Parameters:
  /// - [version] The IP version (4 or 6).
  /// - [errorText] The error message to display when the IP address is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid IP address.
  static FormFieldValidator<String> ip({
    int? version,
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isNotEmpty == true && !isIP(valueCandidate, version)
              ? errorText ?? FormBuilderLocalizations.current.ipErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid date string.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the date is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid date string.
  static FormFieldValidator<String> dateString({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              !isDateTime(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.dateStringErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid time string.
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
  static FormFieldValidator<String> time({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == null ||
              valueCandidate.isEmpty ||
              !isTime(valueCandidate)
          ? errorText ?? FormBuilderLocalizations.current.timeErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid date.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the date is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid date.
  static FormFieldValidator<DateTime?> dateTime({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == null
          ? errorText ?? FormBuilderLocalizations.current.dateStringErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a date within a certain range.
  ///
  /// ## Parameters:
  /// - [minDate] The minimum date that the field's value should be greater than or equal to.
  /// - [maxDate] The maximum date that the field's value should be less than or equal to.
  /// - [errorText] The error message to display when the date is not in the range.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a date within the range [minDate] to [maxDate].
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
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the phone number is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid phone number.
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
  ///
  /// ## Parameters:
  /// - [formats] The list of allowed color code formats (e.g., ['hex', 'rgb', 'hsl']).
  /// - [errorText] The error message to display when the color code is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid color code.
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
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not uppercase.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is uppercase.
  static FormFieldValidator<String> uppercase({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              valueCandidate!.toUpperCase() != valueCandidate
          ? errorText ?? FormBuilderLocalizations.current.uppercaseErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be lowercase.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not lowercase.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is lowercase.
  static FormFieldValidator<String> lowercase({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              valueCandidate!.toLowerCase() != valueCandidate
          ? errorText ?? FormBuilderLocalizations.current.lowercaseErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid file extension.
  ///
  /// ## Parameters:
  /// - [allowedExtensions] The list of allowed file extensions.
  /// - [errorText] The error message to display when the file extension is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid file extension.
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
  ///
  /// ## Parameters:
  /// - [maxSize] The maximum size in bytes.
  /// - [errorText] The error message to display when the file size is greater than the maximum size.
  ///
  /// ## Returns:
  /// A validator that checks if the file size is less than or equal to [maxSize].
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
  ///
  /// ## Parameters:
  /// - [condition] A function that determines if the validator should be applied.
  /// - [validator] The validator to apply if the condition is met.
  ///
  /// ## Returns:
  /// A validator that applies [validator] if [condition] is true.
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
  ///
  /// ## Parameters:
  /// - [minValue] The minimum value that the field's value should be greater than or equal to.
  /// - [maxValue] The maximum value that the field's value should be less than or equal to.
  /// - [inclusive] Whether the range is inclusive (default: true).
  /// - [errorText] The error message to display when the value is not in the range.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is within the range [minValue] to [maxValue].
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
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not true.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is true.
  static FormFieldValidator<bool> isTrue({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate != true
          ? errorText ?? FormBuilderLocalizations.current.mustBeTrueErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a bool and false.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not false.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is false.
  static FormFieldValidator<bool> isFalse({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate != false
          ? errorText ?? FormBuilderLocalizations.current.mustBeFalseErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to contain a minimum number of special characters.
  ///
  /// ## Parameters:
  /// - [atLeast] The minimum number of special characters (default: 1).
  /// - [errorText] The error message to display when the value does not contain the required number of special characters.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value contains at least [atLeast] special characters.
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
  ///
  /// ## Parameters:
  /// - [atLeast] The minimum number of uppercase characters (default: 1).
  /// - [errorText] The error message to display when the value does not contain the required number of uppercase characters.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value contains at least [atLeast] uppercase characters.
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
  ///
  /// ## Parameters:
  /// - [atLeast] The minimum number of lowercase characters (default: 1).
  /// - [errorText] The error message to display when the value does not contain the required number of lowercase characters.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value contains at least [atLeast] lowercase characters.
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
  ///
  /// ## Parameters:
  /// - [atLeast] The minimum number of numeric characters (default: 1).
  /// - [errorText] The error message to display when the value does not contain the required number of numeric characters.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value contains at least [atLeast] numeric characters.
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
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid username.
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
  ///
  /// ## Parameters:
  /// - [minLength] The minimum length of the password (default: 8).
  /// - [maxLength] The maximum length of the password (default: 32).
  /// - [uppercase] The minimum number of uppercase characters (default: 1).
  /// - [lowercase] The minimum number of lowercase characters (default: 1).
  /// - [number] The minimum number of numeric characters (default: 1).
  /// - [specialChar] The minimum number of special characters (default: 1).
  /// - [errorText] The error message to display when the password is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid password.
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
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not alphabetical.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is alphabetical.
  static FormFieldValidator<String> alphabetical({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == null ||
              valueCandidate.isEmpty ||
              !isAlphabetical(valueCandidate)
          ? errorText ?? FormBuilderLocalizations.current.alphabeticalErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid UUID.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the UUID is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid UUID.
  static FormFieldValidator<String> uuid({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == null ||
              valueCandidate.isEmpty ||
              !isUUID(valueCandidate)
          ? errorText ?? FormBuilderLocalizations.current.uuidErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be valid JSON.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the JSON is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is valid JSON.
  static FormFieldValidator<String> json({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isJSON(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.jsonErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid latitude.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the latitude is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid latitude.
  static FormFieldValidator<String> latitude({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isLatitude(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.latitudeErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid longitude.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the longitude is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid longitude.
  static FormFieldValidator<String> longitude({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isLongitude(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.longitudeErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid base64 string.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the base64 string is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid base64 string.
  static FormFieldValidator<String> base64({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isBase64(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.base64ErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid file or folder path.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the path is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid file or folder path.
  static FormFieldValidator<String> path({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isFilePath(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.pathErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be an odd number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not an odd number.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is an odd number.
  static FormFieldValidator<String> oddNumber({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isOddNumber(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.oddNumberErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be an even number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not an even number.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is an even number.
  static FormFieldValidator<String> evenNumber({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isEmpty != false ||
              !isEvenNumber(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.evenNumberErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid port number.
  ///
  /// ## Parameters:
  /// - [min] The minimum port number (default: 0).
  /// - [max] The maximum port number (default: 65535).
  /// - [errorText] The error message to display when the port number is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid port number.
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
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the MAC address is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid MAC address.
  static FormFieldValidator<String> macAddress({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isEmpty != false ||
              !isMACAddress(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.macAddressErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to start with a specific value.
  ///
  /// ## Parameters:
  /// - [prefix] The value that the field's value should start with.
  /// - [errorText] The error message to display when the value does not start with the prefix.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value starts with [prefix].
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
  ///
  /// ## Parameters:
  /// - [suffix] The value that the field's value should end with.
  /// - [errorText] The error message to display when the value does not end with the suffix.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value ends with [suffix].
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
  ///
  /// ## Parameters:
  /// - [substring] The value that the field's value should contain.
  /// - [caseSensitive] Whether the search is case-sensitive (default: true).
  /// - [errorText] The error message to display when the value does not contain the substring.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value contains [substring].
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
  ///
  /// ## Parameters:
  /// - [min] The minimum value that the field's value should be greater than or equal to.
  /// - [max] The maximum value that the field's value should be less than or equal to.
  /// - [errorText] The error message to display when the value is not in the range.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is between [min] and [max].
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
  ///
  /// ## Parameters:
  /// - [values] The list of values that the field's value should be in.
  /// - [errorText] The error message to display when the value is not in the list.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is in [values].
  static FormFieldValidator<T> containsElement<T>(
    List<T> values, {
    String? errorText,
  }) =>
      (valueCandidate) => !values.contains(valueCandidate)
          ? errorText ??
              FormBuilderLocalizations.current.containsElementErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid IBAN.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the IBAN is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid IBAN.
  static FormFieldValidator<String> iban({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isIBAN(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.ibanErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid BIC.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the BIC is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid BIC.
  static FormFieldValidator<String> bic({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isBIC(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.bicErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid ISBN.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the ISBN is invalid.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a valid ISBN.
  static FormFieldValidator<String> isbn({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isISBN(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.isbnErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a single line.
  ///
  /// ## Parameters:
  /// - [errorText] The error message to display when the value is not a single line.
  ///
  /// ## Returns:
  /// A validator that checks if the field's value is a single line.
  static FormFieldValidator<String> singleLine({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isEmpty != false ||
              !isSingleLine(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.singleLineErrorText
          : null;
}
