import 'package:flutter/material.dart';
import '../form_builder_validators.dart';

import 'utils/helpers.dart';
import 'utils/validators.dart';

/// For creation of [FormFieldValidator]s.
class FormBuilderValidators {
  /// [FormFieldValidator] that is composed of other [FormFieldValidator]s.
  /// Each validator is run against the [FormField] value and if any returns a
  /// non-null result validation fails, otherwise, validation passes
  /// * [validators] is the list of validators to compose
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
  /// Each validator is run against the [FormField] value and if any returns a
  /// null result validation passes
  /// * [validators] is the list of validators to compose
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
  /// * [validator] is the validator to apply.
  /// * [transformer] is the transformer to apply.
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
  /// * [validators] is the list of validators to run.
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

  /// [FormFieldValidator] that logs the value at a specific point in the validation chain
  /// * [log] is the log message to display
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
  /// * [condition] is the condition to check.
  /// * [validator] is the validator to skip.
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
  /// * [values] is the list of values to check against.
  /// * [errorText] is the error message to display when the value is not unique.
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

  /// [FormFieldValidator] that requires the field have a non-empty value.
  /// * [errorText] is the error message to display when the value is empty
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

  /// [FormFieldValidator] that requires the field's value be equal to the
  /// provided value.
  /// * [errorText] is the error message to display when the value is not equal
  static FormFieldValidator<T> equal<T>(
    Object value, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate != value
          ? errorText ?? FormBuilderLocalizations.current.equalErrorText(value)
          : null;

  /// [FormFieldValidator] that requires the field's value be not equal to
  /// the provided value.
  /// * [errorText] is the error message to display when the value is equal
  static FormFieldValidator<T> notEqual<T>(
    Object value, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == value
          ? errorText ??
              FormBuilderLocalizations.current.notEqualErrorText(value)
          : null;

  /// [FormFieldValidator] that requires the field's value to be greater than
  /// (or equal) to the provided number.
  /// * [inclusive] is a `bool` that sets if the comparison is inclusive. By default `true`
  /// * [errorText] is the error message to display when the value is invalid
  /// * [min] is the minimum value to compare
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

  /// [FormFieldValidator] that requires the field's value to be less than
  /// (or equal) to the provided number.
  /// * [inclusive] is a `bool` that sets if the comparison is inclusive. By default `true`
  /// * [errorText] is the error message to display when the value is invalid
  /// * [max] is the maximum value to compare
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

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// greater than or equal to the provided minimum length.
  /// * [allowEmpty] is a `bool` that sets if the field's value can be empty. By default `false`
  /// * [errorText] is the error message to display when the length is invalid
  /// * [minLength] is the minimum length to compare
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

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// less than or equal to the provided maximum length.
  /// * [errorText] is the error message to display when the length is invalid
  /// * [maxLength] is the maximum length to compare
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

  /// [FormFieldValidator] that requires the length of the field to be
  /// equal to the provided length. Works with String, iterable and int types
  /// * [allowEmpty] is a `bool` that sets if the field's value can be empty. By default `false`
  /// * [errorText] is the error message to display when the length is invalid
  /// * [length] is the length to compare
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

  /// [FormFieldValidator] that requires the words count of the field's value to be
  /// greater than or equal to the provided minimum count.
  /// * [allowEmpty] is a `bool` that sets if the field's value can be empty. By default `false`
  /// * [errorText] is the error message to display when the words count is invalid
  /// * [minCount] is the minimum words count
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

  /// [FormFieldValidator] that requires the words count of the field's value to be
  /// less than or equal to the provided maximum count.
  /// * [errorText] is the error message to display when the words count is invalid
  /// * [maxCount] is the maximum words count
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
  /// * [errorText] is the error message to display when the email is invalid
  static FormFieldValidator<String> email({
    String? errorText,
  }) =>
      (valueCandidate) =>
          (valueCandidate?.isNotEmpty ?? false) && !isEmail(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.emailErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid url.
  /// * [protocols] sets the list of allowed protocols. By default `['http', 'https', 'ftp']`
  /// * [requireTld] sets if TLD is required. By default `true`
  /// * [requireProtocol] is a `bool` that sets if protocol is required for validation
  /// By default `false`
  /// * [allowUnderscore] sets if underscores are allowed. By default `false`
  /// * [hostWhitelist] sets the list of allowed hosts
  /// * [hostBlacklist] sets the list of disallowed hosts
  /// * [errorText] is the error message to display when the url is invalid
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
  /// * [pattern] is the regex pattern to match
  /// * [errorText] is the error message to display when the value does not match the pattern
  static FormFieldValidator<String> match(
    String pattern, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              !RegExp(pattern).hasMatch(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.matchErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value not to match the provided regex pattern.
  /// * [pattern] is the regex pattern to match
  /// * [errorText] is the error message to display when the value matches the pattern
  static FormFieldValidator<String> notMatch(
    String pattern, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              RegExp(pattern).hasMatch(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.matchErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid number.
  /// * [errorText] is the error message to display when the number is invalid
  static FormFieldValidator<String> numeric({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              null == num.tryParse(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.numericErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid integer.
  /// * [radix] is the radix to use when parsing the integer.
  /// * [errorText] is the error message to display when the integer is invalid
  static FormFieldValidator<String> integer({
    String? errorText,
    int? radix,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              null == int.tryParse(valueCandidate!, radix: radix)
          ? errorText ?? FormBuilderLocalizations.current.integerErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid credit card number.
  /// * [errorText] is the error message to display when the credit card number is invalid
  static FormFieldValidator<String> creditCard({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              !isCreditCard(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.creditCardErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid credit card expiration date.
  /// * [checkForExpiration] is a `bool` that sets if the expiration date should be checked. By default `true`
  /// * [errorText] is the error message to display when the expiration date is invalid
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
  /// * [errorText] is the error message to display when the CVC is invalid
  static FormFieldValidator<String> creditCardCVC({
    String? errorText,
  }) =>
      compose<String>(
        [
          minLength(3,
              errorText: errorText ??
                  FormBuilderLocalizations.current.creditCardCVCErrorText),
          maxLength(4,
              errorText: errorText ??
                  FormBuilderLocalizations.current.creditCardCVCErrorText),
        ],
      );

  /// [FormFieldValidator] that requires the field's value to be a valid IP address.
  /// * [version] is a `String` or an `int`.
  /// * [errorText] is the error message to display when the IP address is invalid
  static FormFieldValidator<String> ip({
    int? version,
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isNotEmpty == true && !isIP(valueCandidate, version)
              ? errorText ?? FormBuilderLocalizations.current.ipErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid date string.
  /// * [errorText] is the error message to display when the date is invalid
  static FormFieldValidator<String> dateString({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              !isDate(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.dateStringErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a date within a certain range.
  /// * [minDate] is the minimum date that the field's value should be greater than or equal to.
  /// * [maxDate] is the maximum date that the field's value should be less than or equal to.
  /// * [errorText] is the error message to display when the date is not in the range
  static FormFieldValidator<String> dateRange({
    required DateTime minDate,
    required DateTime maxDate,
    String? errorText,
  }) =>
      (String? valueCandidate) {
        if (valueCandidate == null || !isDate(valueCandidate)) {
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
  /// * [errorText] is the error message to display when the phone number is invalid
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
  /// * [formats] is a list of allowed color code formats (e.g., ['hex', 'rgb', 'hsl'])
  /// * [errorText] is the error message to display when the color code is invalid
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
  /// * [errorText] is the error message to display when the value is not uppercase
  static FormFieldValidator<String> uppercase({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              valueCandidate!.toUpperCase() != valueCandidate
          ? errorText ?? FormBuilderLocalizations.current.uppercaseErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be lowercase.
  /// * [errorText] is the error message to display when the value is not lowercase
  static FormFieldValidator<String> lowercase({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isNotEmpty == true &&
              valueCandidate!.toLowerCase() != valueCandidate
          ? errorText ?? FormBuilderLocalizations.current.lowercaseErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid file extension.
  /// * [allowedExtensions] is a list of allowed file extensions.
  /// * [errorText] is the error message to display when the file extension is invalid.
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

  /// [FormFieldValidator] that restricts the size of an file to be less than or equal to the provided maximum size.
  /// * [maxSize] is the maximum size in bytes.
  /// * [errorText] is the error message to display when the file size is greater than the maximum size.
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
  /// * [condition] is a function that determines if the validator should be applied.
  /// * [validator] is the validator to apply if the condition is met.
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
  /// * [minValue] is the minimum value that the field's value should be greater than or equal to.
  /// * [maxValue] is the maximum value that the field's value should be less than or equal to.
  /// * [inclusive] is a `bool` that sets if the range is inclusive. By default `true`
  /// * [errorText] is the error message to display when the value is not in the range
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

        return errorText ?? minResult ?? maxResult;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a bool and true.
  /// * [errorText] is the error message to display when the value is not true
  static FormFieldValidator<bool> isTrue({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate != true
          ? errorText ?? FormBuilderLocalizations.current.mustBeTrueErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a bool and false.
  /// * [errorText] is the error message to display when the value is not false
  static FormFieldValidator<bool> isFalse({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate != false
          ? errorText ?? FormBuilderLocalizations.current.mustBeFalseErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to contain an amount of special characters.
  /// * [atLeast] is the minimum amount of special characters. By default `1`
  /// * [errorText] is the error message to display when the value does not contain the required amount of special characters
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

  /// [FormFieldValidator] that requires the field's value to contain an amount of uppercase characters.
  /// * [atLeast] is the minimum amount of uppercase characters. By default `1`
  /// * [errorText] is the error message to display when the value does not contain the required amount of uppercase characters
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

  /// [FormFieldValidator] that requires the field's value to contain an amount of lowercase characters.
  /// * [atLeast] is the minimum amount of lowercase characters. By default `1`
  /// * [errorText] is the error message to display when the value does not contain the required amount of lowercase characters
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

  /// [FormFieldValidator] that requires the field's value to contain an amount of numeric characters.
  /// * [atLeast] is the minimum amount of numeric characters. By default `1`
  /// * [errorText] is the error message to display when the value does not contain the required amount of numeric characters
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
  /// * [minLength] is the minimum length of the username. By default `3`
  /// * [maxLength] is the maximum length of the username. By default `32`
  /// * [errorText] is the error message to display when the username is invalid
  /// * [allowNumbers] is a `bool` that sets if digits are allowed. By default `true`
  /// * [allowUnderscore] is a `bool` that sets if underscores are allowed. By default `false`
  /// * [allowDots] is a `bool` that sets if dots are allowed. By default `false`
  /// * [allowDash] is a `bool` that sets if dashes are allowed. By default `false`
  /// * [allowSpace] is a `bool` that sets if spaces are allowed. By default `false`
  /// * [allowSpecialChar] is a `bool` that sets if special characters are allowed. By default `false`
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
  /// * [minLength] is the minimum length of the password. By default `8`
  /// * [maxLength] is the maximum length of the password. By default `32`
  /// * [uppercase] is the minimum amount of uppercase characters. By default `1`
  /// * [lowercase] is the minimum amount of lowercase characters. By default `1`
  /// * [number] is the minimum amount of numeric characters. By default `1`
  /// * [specialChar] is the minimum amount of special characters. By default `1`
  /// * [errorText] is the error message to display when the password is invalid
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
  /// * [errorText] is the error message to display when the value is not alphabetical
  static FormFieldValidator<String> alphabetical({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == null ||
              valueCandidate.isEmpty ||
              !isAlphabetical(valueCandidate)
          ? errorText ?? FormBuilderLocalizations.current.alphabeticalErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid uuid.
  /// * [errorText] is the error message to display when the uuid is invalid
  static FormFieldValidator<String> uuid({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == null ||
              valueCandidate.isEmpty ||
              !isUUID(valueCandidate)
          ? errorText ?? FormBuilderLocalizations.current.uuidErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be valid json.
  /// * [errorText] is the error message to display when the json is invalid
  static FormFieldValidator<String> json({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isJSON(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.jsonErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid latitude.
  /// * [errorText] is the error message to display when the latitude is invalid
  static FormFieldValidator<String> latitude({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isLatitude(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.latitudeErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid longitude.
  /// * [errorText] is the error message to display when the longitude is invalid
  static FormFieldValidator<String> longitude({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isLongitude(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.longitudeErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid base64 string.
  /// * [errorText] is the error message to display when the base64 string is invalid
  static FormFieldValidator<String> base64({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isBase64(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.base64ErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid file or folder path.
  /// * [errorText] is the error message to display when the path is invalid
  static FormFieldValidator<String> path({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isFilePath(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.pathErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be an odd number.
  /// * [errorText] is the error message to display when the value is not an odd number
  static FormFieldValidator<String> oddNumber({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isOddNumber(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.oddNumberErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be an even number.
  /// * [errorText] is the error message to display when the value is not an even number
  static FormFieldValidator<String> evenNumber({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isEmpty != false ||
              !isEvenNumber(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.evenNumberErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid port number.
  /// * [min] is the minimum port number. By default `0`
  /// * [max] is the maximum port number. By default `65535`
  /// * [errorText] is the error message to display when the port number is invalid
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

  /// [FormFieldValidator] that requires the field's value to be a valid macAddress.
  /// * [errorText] is the error message to display when the macAddress is invalid
  static FormFieldValidator<String> macAddress({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isEmpty != false ||
              !isMACAddress(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.macAddressErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to starts with a specific value.
  /// * [prefix] is the value that the field's value should start with.
  /// * [errorText] is the error message to display when the value does not start with the prefix
  static FormFieldValidator<String> startsWith({
    required String prefix,
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isEmpty != false ||
              !valueCandidate!.startsWith(prefix)
          ? errorText ??
              FormBuilderLocalizations.current.startsWithErrorText(prefix)
          : null;

  /// [FormFieldValidator] that requires the field's value to ends with a specific value.
  /// * [suffix] is the value that the field's value should end with.
  /// * [errorText] is the error message to display when the value does not end with the suffix
  static FormFieldValidator<String> endsWith({
    required String suffix,
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !valueCandidate!.endsWith(suffix)
              ? errorText ??
                  FormBuilderLocalizations.current.endsWithErrorText(suffix)
              : null;

  /// [FormFieldValidator] that requires the field's value to contains a specific value.
  /// * [substring] is the value that the field's value should contain.
  /// * [caseSensitive] is a `bool` that sets if the search is case sensitive. By default `true`
  /// * [errorText] is the error message to display when the value does not contain the substring
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
  /// * [min] is the minimum value that the field's value should be greater than or equal to.
  /// * [max] is the maximum value that the field's value should be less than or equal to.
  /// * [errorText] is the error message to display when the value is not in the range
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

  /// [FormFieldValidator] that requires the field's value to in a list of values.
  /// * [values] is the list of values that the field's value should be in.
  /// * [errorText] is the error message to display when the value is not in the list
  static FormFieldValidator<T> containsElement<T>(
    List<T> values, {
    String? errorText,
  }) =>
      (valueCandidate) => !values.contains(valueCandidate)
          ? errorText ??
              FormBuilderLocalizations.current.containsElementErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid IBAN.
  /// * [errorText] is the error message to display when the IBAN is invalid
  static FormFieldValidator<String> iban({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isIBAN(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.ibanErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid BIC.
  /// * [errorText] is the error message to display when the BIC is invalid
  static FormFieldValidator<String> bic({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isBIC(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.bicErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid ISBN.
  /// * [errorText] is the error message to display when the ISBN is invalid
  static FormFieldValidator<String> isbn({
    String? errorText,
  }) =>
      (valueCandidate) =>
          valueCandidate?.isEmpty != false || !isISBN(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.isbnErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a single line.
  /// * [errorText] is the error message to display when the value is not a single line
  static FormFieldValidator<String> singleLine({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate?.isEmpty != false ||
              !isSingleLine(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.singleLineErrorText
          : null;
}
