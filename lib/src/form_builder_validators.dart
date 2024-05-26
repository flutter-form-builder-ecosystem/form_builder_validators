import 'dart:async';

import 'package:flutter/material.dart';
import '../form_builder_validators.dart';

import 'utils/helpers.dart';
import 'utils/validators.dart';

/// For creation of [FormFieldValidator]s.
class FormBuilderValidators {
  /// [FormFieldValidator] that is composed of other [FormFieldValidator]s.
  /// Each validator is run against the [FormField] value and if any returns a
  /// non-null result validation fails, otherwise, validation passes
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
  static FormFieldValidator transform<T>(
    FormFieldValidator<T> validator,
    T Function(T? value) transformer,
  ) {
    return (valueCandidate) {
      final transformedValue = transformer(valueCandidate);
      return validator(transformedValue);
    };
  }

  /// [FormFieldValidator] that debounces the validation.
  /// * [duration] is the duration to wait before running the validation.
  static FormFieldValidator<T> debounce<T>({
    required Duration duration,
    required FormFieldValidator<T> validator,
  }) {
    Timer? debounceTimer;
    String? result;

    return (valueCandidate) {
      debounceTimer?.cancel();
      debounceTimer = Timer(duration, () {
        result = validator(valueCandidate);
      });

      return result;
    };
  }

  /// [FormFieldValidator] that retries the validation.
  /// * [times] is the number of times to retry the validation.
  /// * [duration] is the duration to wait before retrying the validation.
  static FormFieldValidator<T> retry<T>({
    required int times,
    required Duration duration,
    required FormFieldValidator<T> validator,
  }) {
    int retries = 0;
    String? result;

    return (valueCandidate) {
      if (retries < times) {
        result = validator(valueCandidate);
        if (result != null) {
          retries++;
          Future.delayed(duration, () {
            result = validator(valueCandidate);
          });
        }
      }

      return result;
    };
  }

  /// [FormFieldValidator] that requires the field have a non-empty value.
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
  static FormFieldValidator<T> equal<T>(
    Object value, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate != value
          ? errorText ?? FormBuilderLocalizations.current.equalErrorText(value)
          : null;

  /// [FormFieldValidator] that requires the field's value be not equal to
  /// the provided value.
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
  static FormFieldValidator<String> email({
    String? errorText,
  }) =>
      (valueCandidate) =>
          (valueCandidate?.isNotEmpty ?? false) && !isEmail(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.emailErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid url.
  ///
  /// * [protocols] sets the list of allowed protocols. By default `['http', 'https', 'ftp']`
  /// * [requireTld] sets if TLD is required. By default `true`
  /// * [requireProtocol] is a `bool` that sets if protocol is required for validation
  /// By default `false`
  /// * [allowUnderscore] sets if underscores are allowed. By default `false`
  /// * [hostWhitelist] sets the list of allowed hosts
  /// * [hostBlacklist] sets the list of disallowed hosts
  static FormFieldValidator<String> url({
    String? errorText,
    List<String> protocols = const ['http', 'https', 'ftp'],
    bool requireTld = true,
    bool requireProtocol = false,
    bool allowUnderscore = false,
    List<String> hostWhitelist = const [],
    List<String> hostBlacklist = const [],
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
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
  static FormFieldValidator<String> match(
    String pattern, {
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              !RegExp(pattern).hasMatch(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.matchErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value not to match the provided regex pattern.
  static FormFieldValidator<String> notMatch(
    String pattern, {
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              RegExp(pattern).hasMatch(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.matchErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid number.
  static FormFieldValidator<String> numeric({
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              null == num.tryParse(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.numericErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid integer.
  static FormFieldValidator<String> integer({
    String? errorText,
    int? radix,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              null == int.tryParse(valueCandidate!, radix: radix)
          ? errorText ?? FormBuilderLocalizations.current.integerErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid credit card number.
  static FormFieldValidator<String> creditCard({
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              !isCreditCard(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.creditCardErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid credit card expiration date.
  static FormFieldValidator<String> creditCardExpirationDate({
    bool checkForExpiration = true,
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              !isCreditCardExpirationDate(valueCandidate!)
          ? errorText ??
              FormBuilderLocalizations.current.creditCardExpirationDateErrorText
          : (checkForExpiration && !isNotExpiredCreditCardDate(valueCandidate!))
              ? errorText ??
                  FormBuilderLocalizations.current.creditCardExpiredErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid credit card CVC.
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
  static FormFieldValidator<String> ip({
    int? version,
    String? errorText,
  }) =>
      (valueCandidate) =>
          true == valueCandidate?.isNotEmpty && !isIP(valueCandidate, version)
              ? errorText ?? FormBuilderLocalizations.current.ipErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid date string.
  static FormFieldValidator<String> dateString({
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              !isDate(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.dateStringErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a date within a certain range.
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
  static FormFieldValidator<String> colorCode({
    List<String> formats = const ['hex', 'rgb', 'hsl'],
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              !isColorCode(valueCandidate!, formats: formats)
          ? errorText ??
              FormBuilderLocalizations.current
                  .colorCodeErrorText(formats.join(', '))
          : null;

  /// [FormFieldValidator] that requires the field's value to be uppercase.
  static FormFieldValidator<String> uppercase({
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              valueCandidate!.toUpperCase() != valueCandidate
          ? errorText ?? FormBuilderLocalizations.current.uppercaseErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be lowercase.
  static FormFieldValidator<String> lowercase({
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              valueCandidate!.toLowerCase() != valueCandidate
          ? errorText ?? FormBuilderLocalizations.current.lowercaseErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid file extension.
  static FormFieldValidator<String> fileExtension({
    required List<String> allowedExtensions,
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == null
          ? null
          : !allowedExtensions
                  .contains(fileExtensionFromPath(valueCandidate).toLowerCase())
              ? errorText ??
                  FormBuilderLocalizations.current
                      .fileExtensionErrorText(allowedExtensions.join(', '))
              : null;

  /// [FormFieldValidator] that restricts the size of an file to be less than or equal to the provided maximum size.
  /// * [maxSize] is the maximum size in bytes.
  static FormFieldValidator<String> fileSize({
    required int maxSize,
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == null
          ? null
          : int.parse(valueCandidate) > maxSize
              ? errorText ??
                  FormBuilderLocalizations.current.fileSizeErrorText(
                    formatBytes(int.parse(valueCandidate)),
                    formatBytes(maxSize),
                  )
              : null;

  /// [FormFieldValidator] that applies another validator conditionally.
  static FormFieldValidator<T> conditional<T>(
    bool Function(T value) condition,
    FormFieldValidator<T> validator,
  ) =>
      (T? valueCandidate) =>
          condition(valueCandidate as T) ? validator(valueCandidate) : null;

  /// [FormFieldValidator] that requires the field's value to be within a certain range.
  static FormFieldValidator<T> range<T>(
    num minValue,
    num maxValue, {
    bool inclusive = true,
    String? errorText,
  }) {
    return compose<T>(
      [
        min(minValue, inclusive: inclusive, errorText: errorText),
        max(maxValue, inclusive: inclusive, errorText: errorText),
      ],
    );
  }

  /// [FormFieldValidator] that requires the field's value to be a bool and true.
  static FormFieldValidator<bool> mustBeTrue({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate != true
          ? errorText ?? FormBuilderLocalizations.current.mustBeTrueErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a bool and false.
  static FormFieldValidator<bool> mustBeFalse({
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate != false
          ? errorText ?? FormBuilderLocalizations.current.mustBeFalseErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to contain an amount of special characters.
  static FormFieldValidator<String> hasSpecialChars({
    int atLeast = 1,
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              specialCharLength(valueCandidate!) >= atLeast
          ? null
          : errorText ??
              FormBuilderLocalizations.current
                  .containsSpecialCharErrorText(atLeast);

  /// [FormFieldValidator] that requires the field's value to contain an amount of uppercase characters.
  static FormFieldValidator<String> hasUppercaseChars({
    int atLeast = 1,
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              uppercaseCharLength(valueCandidate!) >= atLeast
          ? null
          : errorText ??
              FormBuilderLocalizations.current
                  .containsUppercaseCharErrorText(atLeast);

  /// [FormFieldValidator] that requires the field's value to contain an amount of lowercase characters.
  static FormFieldValidator<String> hasLowercaseChars({
    int atLeast = 1,
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              lowercaseCharLength(valueCandidate!) >= atLeast
          ? null
          : errorText ??
              FormBuilderLocalizations.current
                  .containsLowercaseCharErrorText(atLeast);

  /// [FormFieldValidator] that requires the field's value to contain an amount of numeric characters.
  static FormFieldValidator<String> hasNumericChars({
    int atLeast = 1,
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              numberCharLength(valueCandidate!) >= atLeast
          ? null
          : errorText ??
              FormBuilderLocalizations.current.containsNumberErrorText(atLeast);

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
  static FormFieldValidator<String> alphabetical({
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              !isAlphabetical(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.alphabeticalErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid uuid.
  static FormFieldValidator<String> uuid({
    String? errorText,
  }) =>
      (valueCandidate) =>
          true == valueCandidate?.isNotEmpty && !isUUID(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.uuidErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be valid json.
  static FormFieldValidator<String> json({
    String? errorText,
  }) =>
      (valueCandidate) =>
          true == valueCandidate?.isNotEmpty && !isJSON(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.jsonErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid latitude.
  static FormFieldValidator<String> latitude({
    String? errorText,
  }) =>
      (valueCandidate) =>
          true == valueCandidate?.isNotEmpty && !isLatitude(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.latitudeErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid longitude.
  static FormFieldValidator<String> longitude({
    String? errorText,
  }) =>
      (valueCandidate) =>
          true == valueCandidate?.isNotEmpty && !isLongitude(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.longitudeErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid base64 string.
  static FormFieldValidator<String> base64({
    String? errorText,
  }) =>
      (valueCandidate) =>
          true == valueCandidate?.isNotEmpty && !isBase64(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.base64ErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid file or folder path.
  static FormFieldValidator<String> path({
    String? errorText,
  }) =>
      (valueCandidate) =>
          true == valueCandidate?.isNotEmpty && !isFilePath(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.pathErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be an odd number.
  static FormFieldValidator<String> oddNumber({
    String? errorText,
  }) =>
      (valueCandidate) =>
          true == valueCandidate?.isNotEmpty && !isOddNumber(valueCandidate!)
              ? errorText ?? FormBuilderLocalizations.current.oddNumberErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be an even number.
  static FormFieldValidator<String> evenNumber({
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              !isEvenNumber(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.evenNumberErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid port number.
  static FormFieldValidator<String> portNumber({
    int min = 0,
    int max = 65535,
    String? errorText,
  }) =>
      (valueCandidate) {
        if (true == valueCandidate?.isNotEmpty) {
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
  static FormFieldValidator<String> macAddress({
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              !isMACAddress(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.macAddressErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to starts with a specific value.
  /// * [prefix] is the value that the field's value should start with.
  static FormFieldValidator<String> startsWith({
    required String prefix,
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              !valueCandidate!.startsWith(prefix)
          ? errorText ??
              FormBuilderLocalizations.current.startsWithErrorText(prefix)
          : null;

  /// [FormFieldValidator] that requires the field's value to ends with a specific value.
  /// * [suffix] is the value that the field's value should end with.
  static FormFieldValidator<String> endsWith({
    required String suffix,
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              !valueCandidate!.endsWith(suffix)
          ? errorText ??
              FormBuilderLocalizations.current.endsWithErrorText(suffix)
          : null;

  /// [FormFieldValidator] that requires the field's value to contains a specific value.
  /// * [substring] is the value that the field's value should contain.
  /// * [caseSensitive] is a `bool` that sets if the search is case sensitive. By default `true`
  static FormFieldValidator<String> contains({
    required String substring,
    bool caseSensitive = true,
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
                  caseSensitive &&
                  !valueCandidate!.contains(substring) ||
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
  static FormFieldValidator<T> inList<T>(
    List<T> values, {
    String? errorText,
  }) =>
      (valueCandidate) => !values.contains(valueCandidate)
          ? errorText ?? FormBuilderLocalizations.current.valueInListErrorText
          : null;
}
