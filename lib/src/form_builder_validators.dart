// coverage:ignore-file
import 'dart:core' as c;
import 'dart:core';

import 'package:flutter/widgets.dart';

import '../form_builder_validators.dart';
//import 'validators/constants.dart'; // Uncomment after removing the deprecated code.
import 'validators/network_validators.dart';
import 'validators/validators.dart' as val;

@Deprecated('use the base class Validators instead')

/// Provides utility methods for creating various [FormFieldValidator]s.
class FormBuilderValidators {
  /// [FormFieldValidator] that requires the field's value to contain a minimum
  /// number of lowercase characters.
  ///
  /// ## Parameters:
  /// - [atLeast] The minimum number of lowercase characters (default: 1).
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the value does not contain the
  /// required number of lowercase characters.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro lowercase_chars_template}
  static FormFieldValidator<String> hasLowercaseChars({
    int atLeast = 1,
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      HasLowercaseCharsValidator(
        atLeast: atLeast,
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to contain a minimum
  ///  number of numeric characters.
  ///
  /// ## Parameters:
  /// - [atLeast] The minimum number of numeric characters (default: 1).
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the value does not contain the
  /// required number of numeric characters.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro numeric_chars_template}
  static FormFieldValidator<String> hasNumericChars({
    int atLeast = 1,
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      HasNumericCharsValidator(
        atLeast: atLeast,
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to contain a minimum
  /// number of special characters.
  ///
  /// ## Parameters:
  /// - [atLeast] The minimum number of special characters (default: 1).
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the value does not contain the
  /// required number of special characters.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro special_chars_template}
  static FormFieldValidator<String> hasSpecialChars({
    int atLeast = 1,
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      HasSpecialCharsValidator(
        atLeast: atLeast,
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to contain a minimum
  /// number of uppercase characters.
  ///
  /// ## Parameters:
  /// - [atLeast] The minimum number of uppercase characters (default: 1).
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the value does not contain the
  /// required number of uppercase characters.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro uppercase_chars_template}
  static FormFieldValidator<String> hasUppercaseChars({
    int atLeast = 1,
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      HasUppercaseCharsValidator(
        atLeast: atLeast,
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a bool and
  /// false.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the value is not false.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<bool> isFalse({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      IsFalseValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a bool and
  /// true.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the value is not true.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<bool> isTrue({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      IsTrueValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be in a
  /// list of values.
  ///
  /// ## Parameters:
  /// - [values] The list of values that the field's value should be in.
  /// - [errorText] The error message when the value is not in the list.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> containsElement<T>(
    List<T> values, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      ContainsElementValidator<T>(
        values,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the length of the field to be equal to
  /// the provided length. Works with String, iterable, and int types.
  ///
  /// ## Parameters:
  /// - [length] The length to compare.
  /// - [allowEmpty] Whether the field's value can be empty (default: false).
  /// - [errorText] The error message when the length is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> equalLength<T>(
    int length, {
    bool allowEmpty = false,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      EqualLengthValidator<T>(
        length,
        allowEmpty: allowEmpty,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// less than or equal to the provided maximum length.
  ///
  /// ## Parameters:
  /// - [maxLength] The maximum length to compare.
  /// - [errorText] The error message when the length is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> maxLength<T>(
    int maxLength, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      MaxLengthValidator<T>(
        maxLength,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// greater than or equal to the provided minimum length.
  ///
  /// ## Parameters:
  /// - [minLength] The minimum length to compare.
  /// - [errorText] The error message when the length is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> minLength<T>(
    int minLength, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      MinLengthValidator<T>(
        minLength,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be within
  /// a certain range.
  ///
  /// ## Parameters:
  /// - [min] The minimum value should be greater than or equal to.
  /// - [max] The maximum value should be less than or equal to.
  /// - [inclusive] Whether the range is inclusive (default: true).
  /// - [errorText] The error message when the value is not in the range.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> range<T>(
    num min,
    num max, {
    bool inclusive = true,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      RangeValidator<T>(
        min,
        max,
        inclusive: inclusive,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that checks if the value is unique in a list
  /// of values.
  ///
  /// ## Parameters:
  /// - [values] The list of values to check against.
  /// - [errorText] The error message when the value is not unique.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> unique<T>(
    List<T> values, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      UniqueValidator<T>(
        values,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that runs validators and collects all error messages.
  ///
  /// ## Parameters:
  /// - [validators] The list of validators to run.
  static FormFieldValidator<T> aggregate<T>(
    List<FormFieldValidator<T>> validators,
  ) =>
      AggregateValidator<T>(validators).validate;

  /// [FormFieldValidator] that combines multiple validators into one.
  /// This validator applies each provided validator sequentially,
  /// and fails if any of them return a non-null result.
  ///
  /// ## Parameters:
  /// - [validators] The list of validators to compose.
  static FormFieldValidator<T> compose<T>(
    List<FormFieldValidator<T>> validators,
  ) =>
      ComposeValidator<T>(validators).validate;

  /// [FormFieldValidator] that applies another validator conditionally.
  ///
  /// ## Parameters:
  /// - [condition] A function that determines if the validator should be
  /// applied.
  /// - [validator] The validator to apply if the condition is met.
  static FormFieldValidator<T> conditional<T>(
    bool Function(T? value) condition,
    FormFieldValidator<T> validator,
  ) =>
      ConditionalValidator<T>(condition, validator).validate;

  /// [FormFieldValidator] that transforms the value to a default if it's null
  /// or empty before running the validator.
  ///
  /// ## Parameters:
  /// - [defaultValue] The default value to transform to.
  /// - [validator] The validator to apply.
  static FormFieldValidator<T> defaultValue<T>(
    T defaultValue,
    FormFieldValidator<T> validator,
  ) =>
      DefaultValueValidator<T>(defaultValue, validator).validate;

  /// [FormFieldValidator] that requires the field's value be equal
  /// to the provided value.
  ///
  /// ## Parameters:
  /// - [value] The value to compare with.
  /// - [errorText] The error message when the value is not equal.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> equal<T>(
    Object value, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      EqualValidator<T>(
        value,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that logs the value at a specific point in the
  /// validation chain.
  /// This validator logs the value being validated and always returns null.
  ///
  /// ## Parameters:
  /// - [log] The log message to display.
  /// - [errorText] The error message when the value is invalid.
  static FormFieldValidator<T> log<T>({
    String Function(T? value)? log,
    String? errorText,
  }) =>
      LogValidator<T>(
        log: log,
        errorText: errorText,
      ).validate;

  /// [FormFieldValidator] that requires the field's value be not equal
  /// to the provided value.
  ///
  /// ## Parameters:
  /// - [value] The value to compare with.
  /// - [errorText] The error message when the value is equal.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> notEqual<T>(
    Object value, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      NotEqualValidator<T>(
        value,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that combines multiple validators,
  /// passing validation if any return null.
  ///
  /// ## Parameters:
  /// - [validators] The list of validators to compose.
  static FormFieldValidator<T> or<T>(
    List<FormFieldValidator<T>> validators,
  ) =>
      OrValidator<T>(validators).validate;

  /// [FormFieldValidator] that requires the field have a non-empty value.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the value is empty.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> required<T>({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      RequiredValidator<T>(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that skips the validation when a certain
  /// condition is met.
  ///
  /// ## Parameters:
  /// - [condition] The condition to check.
  /// - [validator] The validator to skip.
  static FormFieldValidator<T> skipWhen<T>(
    bool Function(T? value) condition,
    FormFieldValidator<T> validator,
  ) =>
      SkipWhenValidator<T>(condition, validator).validate;

  /// [FormFieldValidator] that transforms the value before applying
  /// the validator.
  ///
  /// ## Parameters:
  /// - [transformer] The transformer to apply.
  /// - [validator] The validator to apply.
  static FormFieldValidator<T> transform<T>(
    T Function(T? value) transformer,
    FormFieldValidator<T> validator,
  ) =>
      TransformValidator<T>(transformer, validator).validate;

  /// [FormFieldValidator] that requires the field's value to be in the future.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the date is not
  /// in the future.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> dateFuture({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      DateFutureValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid time
  /// in the past.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the time is not
  /// in the past.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> datePast({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      DatePastValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a date within
  /// a certain range.
  ///
  /// ## Parameters:
  /// - [minDate] The minimum date that the field's value should be greater
  /// than or equal to.
  /// - [maxDate] The maximum date that the field's value should be less
  /// than or equal to.
  /// - [errorText] The error message when the date is not
  /// in the range.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> dateRange(
    DateTime minDate,
    DateTime maxDate, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      DateRangeValidator(
        minDate,
        maxDate,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a
  /// valid date string.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the date is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> date({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      DateValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid date.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the date is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<DateTime?> dateTime({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      DateTimeValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid time.
  ///
  /// It supports various time formats, both 24-hour and 12-hour formats.
  ///
  /// ## Valid 24-hour time formats:
  /// - `HH:mm`: Hours and minutes,
  /// e.g., `23:59`
  /// - `HH:mm:ss`: Hours, minutes, and seconds,
  /// e.g., `23:59:59`
  /// - `HH:mm:ss.SSS`: Hours, minutes, seconds, and milliseconds,
  /// e.g., `23:59:59.999`
  ///
  /// ## Valid 12-hour time formats:
  /// - `h:mm a`: Hours and minutes with AM/PM,
  /// e.g., `11:59 PM`
  /// - `h:mm:ss a`: Hours, minutes, and seconds with AM/PM,
  /// e.g., `11:59:59 PM`
  /// - `h:mm:ss.SSS a`: Hours, minutes, seconds, and milliseconds with AM/PM,
  /// e.g., `11:59:59.999 PM`
  ///
  /// ## Parameters:
  /// - [errorText] (optional): The error message when the time
  /// is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro time_template}
  static FormFieldValidator<String> time({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      TimeValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid time zone.

  /// ## Parameters:
  /// - [errorText] The error message when the time zone is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  /// {@macro time_zone_template}
  static FormFieldValidator<String> timeZone({
    List<String>? validTimeZones,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      TimeZoneValidator(
        validTimeZones: validTimeZones,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to a valid file extension.
  ///
  /// ## Parameters:
  /// - [allowedExtensions] The list of allowed file extensions.
  /// - [errorText] The error message when the file extension is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> fileExtension(
    List<String> allowedExtensions, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      FileExtensionValidator(
        allowedExtensions,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a
  /// valid file name.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the file name is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> fileName({
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      FileNameValidator(
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that restricts the size of a file to be less than or
  /// equal to the provided maximum size.
  ///
  /// ## Parameters:
  /// - [maxSize] The maximum size in bytes.
  /// - [errorText] The error message when the file size exceeds the limit.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> fileSize(
    int maxSize, {
    bool base1024Conversion = true,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      FileSizeValidator(
        maxSize,
        base1024Conversion: base1024Conversion,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid MIME type.
  /// The MIME type should be in the format `type/subtype`.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the file name is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> mimeType({
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      MimeTypeValidator(
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid file
  /// or folder path.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the path is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro file_path_template}
  static FormFieldValidator<String> path({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      PathValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid BIC.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the BIC is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro bic_template}
  static FormFieldValidator<String> bic({
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      BicValidator(
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid
  /// credit card CVC.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the CVC is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> creditCardCVC({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      CreditCardCvcValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid
  /// credit card expiration date.
  ///
  /// ## Parameters:
  /// - [checkForExpiration] Whether the expiration date should be checked
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the expiration
  /// date is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro credit_card_expiration_template}
  static FormFieldValidator<String> creditCardExpirationDate({
    bool checkForExpiration = true,
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      CreditCardExpirationDateValidator(
        checkForExpiration: checkForExpiration,
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a
  /// valid credit card number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the credit card number
  /// is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro credit_card_template}
  static FormFieldValidator<String> creditCard({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      CreditCardValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid IBAN.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the IBAN is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro iban_template}
  static FormFieldValidator<String> iban({
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      IbanValidator(
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid city.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [citiesWhitelist] The list of allowed cities.
  /// - [citiesBlacklist] The list of disallowed cities.
  /// - [errorText] The error message when the city is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> city({
    RegExp? regex,
    List<String> citiesWhitelist = const <String>[],
    List<String> citiesBlacklist = const <String>[],
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      CityValidator(
        regex: regex,
        citiesWhitelist: citiesWhitelist,
        citiesBlacklist: citiesBlacklist,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid country.
  ///
  /// ## Parameters:
  /// - [countryWhitelist] The list of allowed countries.
  /// - [countryBlacklist] The list of disallowed countries.
  /// - [errorText] The error message when the country is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> country({
    List<String> countryWhitelist = const <String>[],
    List<String> countryBlacklist = const <String>[],
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      CountryValidator(
        countryWhitelist: countryWhitelist,
        countryBlacklist: countryBlacklist,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid first name.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [firstNameWhitelist] The list of allowed first names.
  /// - [firstNameBlacklist] The list of disallowed first names.
  /// - [errorText] The error message when the first name is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> firstName({
    RegExp? regex,
    List<String> firstNameWhitelist = const <String>[],
    List<String> firstNameBlacklist = const <String>[],
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      FirstNameValidator(
        regex: regex,
        firstNameWhitelist: firstNameWhitelist,
        firstNameBlacklist: firstNameBlacklist,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid last name.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [lastNameWhitelist] The list of allowed last names.
  /// - [lastNameBlacklist] The list of disallowed last names.
  /// - [errorText] The error message when the last name is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> lastName({
    RegExp? regex,
    List<String> lastNameWhitelist = const <String>[],
    List<String> lastNameBlacklist = const <String>[],
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      LastNameValidator(
        regex: regex,
        lastNameWhitelist: lastNameWhitelist,
        lastNameBlacklist: lastNameBlacklist,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid passport number.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [passportNumberWhitelist] The list of allowed passport numbers.
  /// - [passportNumberBlacklist] The list of disallowed passport numbers.
  /// - [errorText] The error message when the passport number is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> passport({
    RegExp? regex,
    List<String> passportNumberWhitelist = const <String>[],
    List<String> passportNumberBlacklist = const <String>[],
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      PassportNumberValidator(
        regex: regex,
        passportNumberWhitelist: passportNumberWhitelist,
        passportNumberBlacklist: passportNumberBlacklist,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid state.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [stateWhitelist] The list of allowed states.
  /// - [stateBlacklist] The list of disallowed states.
  /// - [errorText] The error message when the state is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> state({
    RegExp? regex,
    List<String> stateWhitelist = const <String>[],
    List<String> stateBlacklist = const <String>[],
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      StateValidator(
        regex: regex,
        stateWhitelist: stateWhitelist,
        stateBlacklist: stateBlacklist,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid street address.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [streetWhitelist] The list of allowed street addresses.
  /// - [streetBlacklist] The list of disallowed street addresses.
  /// - [errorText] The error message when the street address is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> street({
    RegExp? regex,
    List<String> streetWhitelist = const <String>[],
    List<String> streetBlacklist = const <String>[],
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      StreetValidator(
        regex: regex,
        streetWhitelist: streetWhitelist,
        streetBlacklist: streetBlacklist,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid
  /// password.
  ///
  /// ## Parameters:
  /// - [minLength] The minimum length of the password (default: 8).
  /// - [maxLength] The maximum length of the password (default: 32).
  /// - [minUppercaseCount] The minimum number of uppercase characters (default: 1).
  /// - [minLowercaseCount] The minimum number of lowercase characters (default: 1).
  /// - [minNumberCount] The minimum number of numeric characters (default: 1).
  /// - [minSpecialCharCount] The minimum number of special characters (default: 1).
  /// - [errorText] The error message when the password is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> password({
    int minLength = 8,
    int maxLength = 32,
    int minUppercaseCount = 1,
    int minLowercaseCount = 1,
    int minNumberCount = 1,
    int minSpecialCharCount = 1,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      PasswordValidator(
        minLength: minLength,
        maxLength: maxLength,
        minUppercaseCount: minUppercaseCount,
        minLowercaseCount: minLowercaseCount,
        minNumberCount: minNumberCount,
        minSpecialCharCount: minSpecialCharCount,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a
  /// valid SSN (Social Security Number).
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the SSN is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> ssn({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      SsnValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a
  /// valid username.
  ///
  /// ## Parameters:
  /// - [minLength] The minimum length of the username (default: 3).
  /// - [maxLength] The maximum length of the username (default: 32).
  /// - [allowNumbers] Whether digits are allowed (default: true).
  /// - [allowUnderscore] Whether underscores are allowed (default: false).
  /// - [allowDots] Whether dots are allowed (default: false).
  /// - [allowDash] Whether dashes are allowed (default: false).
  /// - [allowSpace] Whether spaces are allowed (default: false).
  /// - [allowSpecialChar] Whether special characters are allowed
  /// (default: false).
  /// - [errorText] The error message when the username is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> username({
    int minLength = 3,
    int maxLength = 32,
    bool allowNumbers = true,
    bool allowUnderscore = false,
    bool allowDots = false,
    bool allowDash = false,
    bool allowSpace = false,
    bool allowSpecialChar = false,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      UsernameValidator(
        minLength: minLength,
        maxLength: maxLength,
        allowNumbers: allowNumbers,
        allowUnderscore: allowUnderscore,
        allowDots: allowDots,
        allowDash: allowDash,
        allowSpace: allowSpace,
        allowSpecialChar: allowSpecialChar,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid zip code.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the zip code is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> zipCode({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      ZipCodeValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a
  /// valid email address.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the email is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro email_regex_template}
  static FormFieldValidator<String> email({
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      EmailValidator(
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid IP address.
  ///
  /// ## Parameters:
  /// - [version] The IP version (4 or 6).
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the IP address is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro ipv4_template}
  ///
  /// {@macro ipv6_template}
  static FormFieldValidator<String> ip({
    int version = 4,
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      IpValidator(
        version: version,
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid
  /// latitude.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the latitude is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> latitude({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      LatitudeValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid
  /// longitude.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the longitude is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> longitude({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      LongitudeValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid
  /// MAC address.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the MAC address is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro mac_address_template}
  static FormFieldValidator<String> macAddress({
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      MacAddressValidator(
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a
  /// valid phone number.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the phone number
  /// is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro phone_number_template}
  static FormFieldValidator<String> phoneNumber({
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      PhoneNumberValidator(
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid
  /// port number.
  ///
  /// ## Parameters:
  /// - [min] The minimum port number (default: 0).
  /// - [max] The maximum port number (default: 65535).
  /// - [errorText] The error message when the port number is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> portNumber({
    int min = 0,
    int max = 65535,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      PortNumberValidator(
        min: min,
        max: max,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid URL.
  ///
  /// ## Parameters:
  /// - [protocols] The list of allowed protocols
  /// (default: ['http', 'https', 'ftp']).
  /// - [requireTld] Whether TLD is required (default: true).
  /// - [requireProtocol] Whether protocol is required for validation.
  /// - [allowUnderscore] Whether underscores are allowed.
  /// - [hostWhitelist] The list of allowed hosts.
  /// - [hostBlacklist] The list of disallowed hosts.
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the URL is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro url_template}
  static FormFieldValidator<String> url({
    List<String> protocols = const <String>['http', 'https', 'ftp'],
    bool requireTld = true,
    bool requireProtocol = false,
    bool allowUnderscore = false,
    List<String> hostWhitelist = const <String>[],
    List<String> hostBlacklist = const <String>[],
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      UrlValidator(
        protocols: protocols,
        requireTld: requireTld,
        requireProtocol: requireProtocol,
        allowUnderscore: allowUnderscore,
        hostWhitelist: hostWhitelist,
        hostBlacklist: hostBlacklist,
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be between
  /// two numbers.
  ///
  /// ## Parameters:
  /// - [min] The minimum value that the field's value should be greater than
  /// or equal to.
  /// - [max] The maximum value that the field's value should be less than
  /// or equal to.
  /// - [errorText] The error message when the value is not in the range.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> between<T>(
    num min,
    num max, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      BetweenValidator<T>(
        min,
        max,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be an even number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the value is not an even number.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> evenNumber({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      EvenNumberValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid float.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the float is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  /// {@macro float_template}
  static FormFieldValidator<T> float<T>({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      FloatValidator<T>(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid hexadecimal.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the hexadecimal is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  /// {@macro hexadecimal_template}
  static FormFieldValidator<String> hexadecimal({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      HexadecimalValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the value to be a valid integer.
  ///
  /// ## Parameters:
  /// - [radix] The radix to use when parsing the integer.
  /// - [errorText] The error message when the integer is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> integer({
    int? radix,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      IntegerValidator(
        radix: radix,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be less than
  /// (or equal) to the provided number.
  ///
  /// ## Parameters:
  /// - [max] The maximum value to compare.
  /// - [inclusive] Whether the comparison is inclusive (default: true).
  /// - [errorText] The error message when the value is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> max<T>(
    num max, {
    bool inclusive = true,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      MaxValidator<T>(
        max,
        inclusive: inclusive,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be greater than
  /// (or equal) to the provided number.
  ///
  /// ## Parameters:
  /// - [min] The minimum value to compare.
  /// - [inclusive] Whether the comparison is inclusive (default: true).
  /// - [errorText] The error message when the value is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> min<T>(
    num min, {
    bool inclusive = true,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      MinValidator<T>(
        min,
        inclusive: inclusive,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a
  /// negative number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the value is not negative.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> negativeNumber<T>({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      NegativeNumberValidator<T>(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a number that
  /// is not zero.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the value is zero.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> notZeroNumber<T>({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      NotZeroNumberValidator<T>(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the number is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> numeric<T>({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      NumericValidator<T>(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be an odd number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the value is not an odd number.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> oddNumber({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      OddNumberValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a
  /// positive number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the value is not positive.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<T> positiveNumber<T>({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      PositiveNumberValidator<T>(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid prime number.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the value is not a prime number.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  /// {@macro prime_number_template}
  static FormFieldValidator<T> primeNumber<T>({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      PrimeNumberValidator<T>(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to contain only alphabetical characters.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the value is not alphabetical.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro alphabetical_template}
  static FormFieldValidator<String> alphabetical({
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      AlphabeticalValidator(
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to contain a
  /// specific value.
  ///
  /// ## Parameters:
  /// - [substring] The value that the field's value should contain.
  /// - [caseSensitive] Whether the search is case-sensitive (default: true).
  /// - [errorText] The error message when the value does not contain the
  /// substring.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> contains(
    String substring, {
    bool caseSensitive = true,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      ContainsValidator(
        substring,
        caseSensitive: caseSensitive,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to end with
  /// a specific value.
  ///
  /// ## Parameters:
  /// - [suffix] The value that the field's value should end with.
  /// - [errorText] The error message when the value does not end with
  /// the suffix.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> endsWith(
    String suffix, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      EndsWithValidator(
        suffix,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be lowercase.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the value is not lowercase.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> lowercase({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      LowercaseValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value not to match
  /// the provided regex pattern.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the value
  /// matches the pattern.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> matchNot(
    RegExp regex, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      MatchNotValidator(
        regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to match the
  /// provided regex pattern.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the value does not
  /// match the pattern.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> match(
    RegExp regex, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      MatchValidator(
        regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the word count of the field's value
  /// to be less than or equal to the provided maximum count.
  ///
  /// ## Parameters:
  /// - [maxWordsCount] The maximum word count.
  /// - [errorText] The error message when the word count is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> maxWordsCount(
    int maxWordsCount, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      MaxWordsCountValidator(
        maxWordsCount,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the word count of the field's value
  /// to be greater than or equal to the provided minimum count.
  ///
  /// ## Parameters:
  /// - [minWordsCount] The minimum word count.
  /// - [errorText] The error message when the word count is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> minWordsCount(
    int minWordsCount, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      MinWordsCountValidator(
        minWordsCount,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a single line.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the value is not a single line.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> singleLine({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      SingleLineValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to start with
  /// a specific value.
  ///
  /// ## Parameters:
  /// - [prefix] The value that the field's value should start with.
  /// - [errorText] The error message when the value does not start with
  /// the prefix.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> startsWith(
    String prefix, {
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      StartsWithValidator(
        prefix,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be uppercase.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the value is not uppercase.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> uppercase({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      UppercaseValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid
  /// base64 string.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the base64 string is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> base64({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      Base64Validator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a
  /// valid color code.
  ///
  /// ## Parameters:
  /// - [formats] The list of allowed color code formats
  /// (e.g., ['hex', 'rgb', 'hsl']).
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the color code is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro hex_template}
  ///
  /// {@macro rgb_template}
  ///
  /// {@macro hsl_template}
  static FormFieldValidator<String> colorCode({
    List<String> formats = const <String>['hex', 'rgb', 'hsl'],
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      ColorCodeValidator(
        formats: formats,
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid DUNS number.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [errorText] The error message when the DUNS number is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  /// {@macro duns_template}
  static FormFieldValidator<String> duns({
    RegExp? regex,
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      DunsValidator(
        regex: regex,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid ISBN.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the ISBN is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> isbn({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      IsbnValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be valid JSON.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the JSON is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  static FormFieldValidator<String> json({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      JsonValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid language code.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [languageCodeWhitelist] The list of allowed language codes.
  /// - [languageCodeBlacklist] The list of disallowed language codes.
  /// - [errorText] The error message when the language code is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  /// {@macro language_code_template}
  static FormFieldValidator<String> languageCode({
    RegExp? regex,
    List<String> languageCodeWhitelist = const <String>[],
    List<String> languageCodeBlacklist = const <String>[],
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      LanguageCodeValidator(
        regex: regex,
        languageCodeWhitelist: languageCodeWhitelist,
        languageCodeBlacklist: languageCodeBlacklist,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid license plate.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [licensePlateWhitelist] The list of allowed license plates.
  /// - [licensePlateBlacklist] The list of disallowed license plates.
  /// - [errorText] The error message when the license plate is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  /// {@macro license_plate_template}
  static FormFieldValidator<String> licensePlate({
    RegExp? regex,
    List<String> licensePlateWhitelist = const <String>[],
    List<String> licensePlateBlacklist = const <String>[],
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      LicensePlateValidator(
        regex: regex,
        licensePlateWhitelist: licensePlateWhitelist,
        licensePlateBlacklist: licensePlateBlacklist,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid
  /// UUID.
  ///
  /// ## Parameters:
  /// - [errorText] The error message when the UUID is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  ///
  /// {@macro uuid_template}
  static FormFieldValidator<String> uuid({
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      UuidValidator(
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;

  /// [FormFieldValidator] that requires the field's value to be a valid VIN.
  ///
  /// ## Parameters:
  /// - [regex] The regex pattern to match.
  /// - [vinWhitelist] The list of allowed VINs.
  /// - [vinBlacklist] The list of disallowed VINs.
  /// - [errorText] The error message when the VIN is invalid.
  /// - [checkNullOrEmpty] Whether to check for null or empty values.
  /// {@macro vin_template}
  static FormFieldValidator<String> vin({
    RegExp? regex,
    List<String> vinWhitelist = const <String>[],
    List<String> vinBlacklist = const <String>[],
    String? errorText,
    bool checkNullOrEmpty = true,
  }) =>
      VinValidator(
        regex: regex,
        vinWhitelist: vinWhitelist,
        vinBlacklist: vinBlacklist,
        errorText: errorText,
        checkNullOrEmpty: checkNullOrEmpty,
      ).validate;
}

//********************************* NEW API ********************************************************************************

/// A class that is used as an aggregator/namespace for all the available
/// validators in this package.
final class Validators {
  // Composition validators
  /// {@template validator_and}
  /// Creates a composite validator that applies multiple validation rules from
  /// `validators` using AND logic.
  ///
  /// The validator executes each validation rule in sequence and handles errors
  /// in one of two modes:
  ///
  /// 1. Fast-fail mode (`printErrorAsSoonAsPossible = true`):
  ///    - Returns the first encountered error message
  ///    - Stops validation after first failure
  ///
  /// 2. Aggregate mode (`printErrorAsSoonAsPossible = false`):
  ///    - Collects all error messages
  ///    - Combines them as: `prefix + msg1 + separator + msg2 + ... + msgN + suffix`
  ///
  /// Returns `null` if all validations pass.
  ///
  /// ## Example
  /// ```dart
  /// final validator = and([
  ///   isEmail,
  ///   fromGmail,
  /// ], separator: ' * ');
  /// ```
  ///
  /// ## Parameters
  /// - `validators`: List of validation functions to apply
  /// - `prefix`: String to prepend to combined error message (default: '')
  /// - `suffix`: String to append to combined error message (default: '')
  /// - `separator`: String between error messages
  /// (default: FormBuilderLocalizations.current.andSeparator)
  /// - `printErrorAsSoonAsPossible`: Whether to return first error or combine all
  /// (default: true)
  ///
  /// ## Returns
  /// - `null` if all validation passes
  /// - Validation failure message, otherwise
  ///
  /// ## Throws
  /// - [ArgumentError] if `validators` is empty
  /// {@endtemplate}
  static Validator<T> and<T extends Object>(
    List<Validator<T>> validators, {
    String prefix = '',
    String suffix = '',
    String? separator,
    c.bool printErrorAsSoonAsPossible = true,
  }) =>
      val.and<T>(validators,
          prefix: prefix,
          suffix: suffix,
          separator: separator,
          printErrorAsSoonAsPossible: printErrorAsSoonAsPossible);

  /// {@template validator_or}
  /// Creates a composite validator that applies multiple validation rules from
  /// `validators` using OR logic.
  ///
  /// The validator executes each validation rule in sequence until one passes
  /// (returns null) or all fail. If all validators fail, their error messages
  /// are combined as: `prefix + msg1 + separator + msg2 + ... + msgN + suffix`
  ///
  /// ## Example
  /// ```dart
  /// final validator = or([
  ///   isGmail,
  ///   isYahoo,
  /// ], separator: ' + ');
  /// ```
  ///
  /// ## Parameters
  /// - `validators`: List of validation functions to apply
  /// - `prefix`: String to prepend to combined error message (default: '')
  /// - `suffix`: String to append to combined error message (default: '')
  /// - `separator`: String between error messages
  /// (default: FormBuilderLocalizations.current.orSeparator)
  ///
  /// ## Returns
  /// - `null` if any validation passes
  /// - Combined error message if all validations fail
  ///
  /// ## Throws
  /// - [ArgumentError] if `validators` is empty
  /// {@endtemplate}
  static Validator<T> or<T extends Object>(
    List<Validator<T>> validators, {
    String prefix = '',
    String suffix = '',
    String? separator,
  }) =>
      val.or<T>(
        validators,
        prefix: prefix,
        suffix: suffix,
        separator: separator,
      );

  // Conditional validators
  /// {@template validator_validate_if}
  /// Creates a conditional validator that only applies validation when a specified
  /// condition is met.
  ///
  /// The validator first evaluates the `condition` function with the input value.
  /// If the condition returns true, it applies the validation rule `v`.
  /// If the condition returns false, the validation automatically passes.
  ///
  /// ## Example
  /// ```dart
  /// final validator = validateIf<String>(
  ///   (value) => value.startsWith('http'),
  ///   isValidUrl,
  /// );
  /// ```
  ///
  /// ## Parameters
  /// - `condition`: Function that determines if validation should be applied
  /// - `v`: Validation function to apply when condition is true
  ///
  /// ## Returns
  /// - `null` if condition is false or validation passes
  /// - Validation failure message from `v` if condition is true and validation fails
  ///
  /// ## Type Parameters
  /// - `T`: Type of value being validated, may be a nullable Object
  /// {@endtemplate}
  static Validator<T> validateIf<T extends Object?>(
          c.bool Function(T value) condition, Validator<T> v) =>
      val.validateIf<T>(condition, v);

  /// {@template validator_skip_if}
  /// Creates a validator that conditionally bypasses validation based on a
  /// predicate function.
  ///
  /// First evaluates `condition` with the input value. If true, validation is
  /// skipped and automatically passes. If false, applies validation rule `v`.
  ///
  /// ## Example
  /// ```dart
  /// final validator = skipIf<String>(
  ///   (value) => value.isEmpty,
  ///   validateEmail,
  /// );
  /// ```
  ///
  /// ## Parameters
  /// - `condition`: Predicate function determining if validation should be skipped
  /// - `v`: Validation function to apply when condition is false
  ///
  /// ## Returns
  /// - `null` if condition is true or validation passes
  /// - Validation failure message from `v` if condition is false and validation fails
  ///
  /// ## Type Parameters
  /// - `T`: Type of value being validated, may be a nullable Object
  /// {@endtemplate}
  static Validator<T> skipIf<T extends Object?>(
          c.bool Function(T value) condition, Validator<T> v) =>
      val.skipIf<T>(condition, v);

  // Debug print validator
  /// {@template validator_debug_print_validator}
  /// Creates a validator that logs input values to stdout before optionally applying
  /// another validator.
  ///
  /// ## Example
  /// ```dart
  /// final validator = debugPrintValidator<String>(
  ///   next: validateEmail,
  ///   logOnInput: (value) => 'Email input: $value',
  /// );
  /// ```
  ///
  /// ## Parameters
  /// - `next`: Optional validator to apply after logging
  /// - `logOnInput`: Optional function to customize log message format
  ///
  /// ## Returns
  /// - `null` if no `next` validator or if validation passes
  /// - Validation failure from `next` validator if validation fails
  ///
  /// ## Type Parameters
  /// - `T`: Type of value being validated, may be a nullable Object
  /// {@endtemplate}
  static Validator<T> debugPrintValidator<T extends Object?>(
          {Validator<T>? next, String Function(T input)? logOnInput}) =>
      val.debugPrintValidator(next: next, logOnInput: logOnInput);

  // Equality validators
  /// {@template validator_equal}
  /// Creates a validator that checks if a given input matches `referenceValue`
  /// using the equality (`==`) operator.
  ///
  ///
  /// ## Parameters
  /// - `referenceValue` (`T`): The value to compare against the input. This serves as
  ///   the reference for equality checking.
  /// - `equalMsg` (`String Function(T input, T referenceValue)?`): Optional
  /// custom error message generator. Takes the `input` and the `referenceValue`
  /// as parameters and returns a custom error message.
  ///
  /// ## Type Parameters
  /// - `T`: The type of value being validated. Must extend `Object?` to allow for
  ///   nullable types.
  ///
  /// ## Returns
  /// Returns a `Validator<T>` function that:
  /// - Returns `null` if the input matches the target value
  /// - Returns an error message if the values don't match, either from the custom
  ///   `isEqualMsg` function or the default localized error text.
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage for password confirmation
  /// final confirmAction = Validator.equal('Type this to confirm the action');
  /// assert(confirmAction('Type this to confirm the action') == null); // null returned (validation passes)
  /// assert(confirmAction(12345) != null); // Error message returned
  ///
  /// // Using custom error message
  /// final specificValueValidator = Validator.equal<int>(
  ///   42,
  ///   equalMsg: (_, value) => 'Value must be exactly $value',
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - The comparison uses the `==` operator, which may not be suitable for complex
  ///   objects without proper equality implementation
  /// - The error message uses the string representation of the value via
  ///   `toString()`, which might not be ideal for all types.
  /// {@endtemplate}
  static Validator<T> equal<T extends Object?>(
    T value, {
    String Function(T input, T referenceValue)? equalMsg,
  }) =>
      val.equal(value, equalMsg: equalMsg);

  /// {@template validator_not_equal}
  /// Creates a validator that checks if a given input is not equal to
  /// `referenceValue` using the not-equal (`!=`) operator.
  ///
  /// ## Parameters
  /// - `referenceValue` (`T`): The reference value to compare against. Input must
  /// not equal this value to pass validation.
  /// - `notEqualMsg` (`String Function(T input, T referenceValue)?`): Optional
  /// custom error message generator. Takes the `input` and the `referenceValue`
  /// as parameters and returns a custom error message.
  ///
  /// ## Type Parameters
  /// - `T`: The type of value being validated. Must extend `Object?` to allow for
  ///   null values and proper equality comparison.
  ///
  /// ## Returns
  /// Returns a `Validator<T>` function that:
  /// - Returns `null` if the input is not equal to the reference value
  /// - Returns an error message string if the input equals the reference value
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage with strings
  /// final validator = Validators.notEqual<String>('reserved');
  /// assert(validator('not-reserved') == null); // null (validation passes)
  /// assert(validator('reserved') != null); // "Value must not be equal to reserved"
  ///
  /// // Custom error message
  /// final customValidator = Validators.notEqual<int>(
  ///   42,
  ///   notEqualMsg: (_, value) => 'Please choose a number other than $value',
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - The comparison uses the `!=` operator, which may not be suitable for complex
  ///   objects without proper equality implementation
  /// - The error message uses the string representation of the value via
  ///   `toString()`, which might not be ideal for all types
  /// {@endtemplate}
  static Validator<T> notEqual<T extends Object?>(
    T value, {
    String Function(T input, T referenceValue)? notEqualMsg,
  }) =>
      val.notEqual(value, notEqualMsg: notEqualMsg);

  // Required validators
  /// {@template validator_required}
  /// Generates a validator function that enforces required field validation for
  /// form inputs. This validator ensures that a field has a non-null, non-empty
  /// value before any subsequent validation is performed.
  ///
  /// ## Type Parameters
  /// - `T`: Represents the non-nullable version of the field's type that will be
  /// passed to any subsequent validators. Once this validator passes, downstream
  /// validators are guaranteed to receive a non-null value, eliminating the need
  /// for additional null checks.
  ///
  /// ## Parameters
  /// - `next` (`Validator<T>?`): An optional subsequent validator function that
  ///   will be applied after the required validation passes. This allows for
  ///   chaining multiple validation rules.
  /// - `requiredMsg` (`String?`): An optional custom error message to display
  ///   when the field is empty or null. If not provided, defaults to the
  ///   localized required field error text.
  ///
  /// ## Returns
  /// Returns a `Validator<T?>` function that:
  /// - Returns null if the value passes both required and subsequent `next`
  /// validation
  /// - Returns an error message string if validation fails
  ///
  /// ## Examples
  /// ```dart
  /// // Basic required field validation
  /// final validator = Validators.required<String>();
  /// print(validator(null));     // Returns localized error message
  /// print(validator(''));       // Returns localized error message
  /// print(validator('value')); // Returns null (validation passed)
  ///
  /// // Chaining with another validator
  /// final complexValidator = Validators.required<String>(
  ///   (value) => value.length < 10 ? 'Too long' : null,
  ///   'Custom required message'
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - The validator assumes empty strings/maps/iterables, white strings, and null
  /// values are equivalent for validation purposes
  /// {@endtemplate}
  static Validator<T?> required<T extends Object>([
    Validator<T>? next,
    String? requiredMsg,
  ]) =>
      val.required(next, requiredMsg);

  /// {@template validator_optional}
  /// Creates a validator function that makes a field optional while allowing additional validation
  /// rules. This validator is particularly useful in form validation scenarios where certain
  /// fields are not mandatory but still need to conform to specific rules when provided.
  ///
  /// The validator handles various input types including strings, iterables, and maps,
  /// considering them as "not provided" when they are null, empty, or contain only whitespace
  /// (for strings).
  ///
  /// ## Type Parameters
  /// - `T`: Represents the non-nullable version of the field's type that will be
  /// passed to any subsequent validators. Once a non-null value is passed, downstream
  /// validators are guaranteed to receive a non-null value, eliminating the need
  /// for additional null checks.
  ///
  /// ## Parameters
  /// - `next` (`Validator<T>?`): An optional subsequent validator function that will be
  ///   applied only if the input value is provided (non-null and non-empty). This allows
  ///   for chaining validation rules.
  /// - `optionalMsg` (`String Function(T input, String nextErrorMessage)?`): An
  /// optional error message that takes the `input` and the `nextErrorMessage` as
  /// parameters and returns the custom error message.
  ///
  /// ## Returns
  /// Returns a `Validator<T?>` function that:
  /// - Returns `null` if the input is not provided (indicating valid optional field)
  /// - Returns `null` if the non-null/non-empty input passes the `next` validation
  /// rules.
  /// - Returns a formatted error message string if validation fails
  ///
  /// ## Examples
  /// ```dart
  /// // Basic optional string validator
  /// final validator = Validators.optional<String>();
  ///
  /// // Optional validator with additional email validation
  /// final emailValidator = Validators.optional<String>(
  ///   validateEmail,
  ///   (_, error) => 'Invalid email format: $error',
  /// );
  ///
  /// // Usage with different inputs
  /// print(validator(null));     // Returns: null (valid)
  /// print(validator(''));       // Returns: null (valid)
  /// print(emailValidator('invalid@email')); // Returns: error message
  /// ```
  ///
  /// ## Caveats
  /// - The validator assumes empty strings/maps/iterables, white strings, and null values are
  /// equivalent for validation purposes, all them are considered valid.
  /// {@endtemplate}
  static Validator<T?> optional<T extends Object>([
    Validator<T>? next,
    String Function(T input, String nextErrorMsg)? optionalMsg,
  ]) =>
      val.optional(next, optionalMsg);

  /// {@template validator_validate_with_default}
  /// Creates a validator function that applies a default value before validation,
  /// making sure the `next` validator will always receive a non-null input.
  ///
  /// This function generates a new validator that first replaces null input
  /// with a specified default value, then applies `next` validator.
  ///
  /// ## Type Parameters
  /// - `T`: The non-nullable version of the type of the input being validated.
  /// It must extend from `Object`.
  ///
  /// ## Parameters
  /// - `defaultValue` (`T`): The fallback non-null value to use when input is null.
  /// - `next` (`Validator<T>`): The validation function to apply after the default
  ///   value has been potentially substituted.
  ///
  /// ## Returns
  /// Returns a new `Validator<T?>` function that accepts nullable input and
  /// produces validation results based on the combined default value substitution
  /// and validation logic. The returned validator is a function that:
  /// - Returns null if the value, potentially replaced with the default, passes
  /// the `next` validation
  /// - Returns an error message string if validation fails
  ///
  /// ## Examples
  /// ```dart
  /// // Create a validator that requires a minimum length of 3
  /// final minLength = (String value) =>
  ///     value.length >= 3 ? null : 'Must be at least 3 characters';
  ///
  /// // Wrap it with a default value of 'N/A'
  /// final defaultValue = 'default value';
  /// final validator = Validators.validateWithDefault('N/A', minLength);
  ///
  /// print(validator(null));      // Returns null (valid)
  /// print(validator('ab'));      // Returns 'Must be at least 3 characters'
  /// print(validator('abc'));     // Returns null (valid)
  /// // Equivalent to:
  /// print(minLength(null ?? defaultValue));      // Returns null (valid)
  /// print(minLength('ab' ?? defaultValue));      // Returns 'Must be at least 3 characters'
  /// print(minLength('abc' ?? defaultValue));      // Returns null (valid)
  /// ```
  /// {@endtemplate}
  static Validator<T?> validateWithDefault<T extends Object>(
          T defaultValue, Validator<T> next) =>
      val.validateWithDefault(defaultValue, next);

  // Transform Validator

  /// {@template validator_transform_and_validate}
  /// Creates a validator that transforms user input and optionally chains with the `next` validator.
  /// This validator attempts to transform the input using the provided transformation function.
  /// If the transformation succeeds, it either returns null or passes the transformed value
  /// to the next validator in the chain. If the transformation fails, it returns an error message.
  ///
  /// The validator is particularly useful for type conversions and data transformations where
  /// the transformation itself serves as a validation step. For example, converting string
  /// input to numbers or dates where invalid formats should be treated as validation failures.
  ///
  /// ## Type Parameters
  /// - `IN`: The input type to be transformed. Must be nullable or non-nullable Object.
  /// - `OUT`: The output type after transformation. Must be nullable or non-nullable Object.
  ///
  /// ## Parameters
  /// - `transformFunction` (`OUT Function(IN)`): The function that performs the actual
  ///   transformation from type `IN` to type `OUT`. This function should throw an exception
  ///   if the transformation cannot be performed.
  /// - `next` (`Validator<OUT>?`): Optional validator to process the transformed value.
  ///   If provided, its result will be returned when transformation succeeds.
  /// - `transformAndValidateMsg` (`String Function(IN)?`): Optional function that generates
  ///   a custom error message when transformation fails. Receives the original input as
  ///   an argument.
  /// - `transformedResultTypeDescription` (`String?`): Optional description of the expected
  ///   transformed type, used to generate more readable error messages. For example,
  ///   "positive integer" would result in messages like 'Value is not a valid positive integer'.
  ///
  /// ## Returns
  /// Returns a `Validator<IN>` function that:
  /// - Returns `null` if transformation succeeds and no `next` validator is provided
  /// - Returns the result of the `next` validator if transformation succeeds and a `next`
  ///   validator is provided
  /// - Returns an error message string if transformation fails
  ///
  /// ## Examples
  /// ```dart
  /// // Creating a validator that converts strings to ArithmeticExpression:
  /// final arithmeticExprValidator = transformAndValidate<String, ArithmeticExpression>(
  ///   parseToArithmeticExpression,
  ///   transformedResultTypeDescription: 'arithmetic expression',
  /// );
  ///
  /// // Example usage:
  /// final validator = arithmeticExprValidator;
  /// print(validator('2+3')); // null (valid)
  /// print(validator('2+Hello World+3')); // "Value is not a valid arithmetic expression"
  /// print(validator('1+2+3+4+5+6+7+8+9+10')); // null (valid)
  /// ```
  /// {@endtemplate}
  static Validator<IN>
      transformAndValidate<IN extends Object?, OUT extends Object?>(
    OUT Function(IN) transformFunction, {
    Validator<OUT>? next,
    String Function(IN)? transformAndValidateMsg,
    String? transformedResultTypeDescription,
  }) =>
          val.transformAndValidate(
            transformFunction,
            next: next,
            transformAndValidateMsg: transformAndValidateMsg,
            transformedResultTypeDescription: transformedResultTypeDescription,
          );

  // Type Validator
  /// {@template validator_string}
  /// Creates a validator that verifies if an input value is a [String]. If the
  /// check succeeds, the transformed value will be passed to the `next`
  /// validator.
  ///
  /// ## Type Parameters
  /// - T: The type of the input value, must extend Object to ensure non-null values
  ///
  /// ## Parameters
  /// - `next` (`Validator<String>?`): An optional subsequent validator that processes
  ///   the input after successful string validation. Receives the validated input
  ///   as a [String].
  /// - `stringMsg` (`String Function(T input)?`): An optional custom error message
  ///   generator function that takes the input as parameter and returns a customized error
  ///   message.
  ///
  /// ## Returns
  /// Returns a `Validator<T>` function that:
  /// - Returns null if the input is valid and no `next` validator is provided
  /// - If the input is a valid [String], returns the result of the `next` validator
  /// - Returns an error message string if the input is not a [String]
  ///
  /// ## Examples
  /// ```dart
  /// // Basic string validation
  /// final validator = Validators.string<Object>();
  /// print(validator('valid string')); // null
  /// print(validator(123)); // 'Must be a string'
  ///
  /// // With custom error message
  /// final customValidator = Validators.string<dynamic>(
  ///   stringMsg: (input) => '${input.toString()} is not a valid String.',
  /// );
  /// print(customValidator(42)); // '42 is not a valid string'
  ///
  /// // Chaining validators
  /// final chainedValidator = Validators.string<Object>(
  ///   (value) => value.isEmpty ? 'String cannot be empty' : null,
  /// );
  /// print(chainedValidator('')); // 'String cannot be empty'
  /// ```
  ///
  ///
  /// ## Caveats
  /// - This validator does not automatically convert the input to [String]. For
  /// example, if the input is a number, it will never transform it to the string
  /// version by calling `toString` method.
  /// {@endtemplate}
  static Validator<T> string<T extends Object>([
    Validator<String>? next,
    String Function(T input)? stringMsg,
  ]) =>
      val.string(next, stringMsg);

  /// {@template validator_int}
  /// Creates a validator that verifies if an input value is an [int] or can be
  /// parsed into an [int]. If the check succeeds, the transformed value will be
  /// passed to the `next` validator.
  ///
  /// This validator performs two key checks:
  /// 1. Direct validation of `int` types
  /// 2. String parsing validation for string inputs that represent integers
  ///
  /// ## Type Parameters
  /// - `T`: The type of the input value. Must extend `Object` to ensure non-null
  /// values.
  ///
  /// ## Parameters
  /// - `next` (`Validator<int>?`): An optional subsequent validator that receives
  ///   the converted integer value for additional validation
  /// - `intMsg` (`String Function(T input)?`): Optional custom error message
  ///   generator function that receives the invalid input and returns an error
  ///   message
  ///
  /// ## Returns
  /// Returns a `Validator<T>` function that:
  /// - Returns `null` if validation succeeds and no `next` validator is provided
  /// - Returns the result of the `next` validator if provided and initial
  /// validation succeeds
  /// - Returns an error message string if validation fails
  ///
  /// ## Examples
  /// ```dart
  /// // Basic integer validation
  /// final validator = Validators.int();
  /// print(validator(42));        // null (valid)
  /// print(validator('123'));     // null (valid)
  /// print(validator('abc'));     // 'This field requires a valid integer.'
  ///
  /// // With custom error message
  /// final customValidator = Validators.int(null, (input) => 'Custom error for: $input');
  /// print(customValidator('abc')); // 'Custom error for: abc'
  ///
  /// // With chained validation
  /// final rangeValidator = Validators.int((value) =>
  ///     value > 100 ? 'Must be less than 100' : null);
  /// print(rangeValidator('150')); // 'Must be less than 100'
  /// ```
  ///
  /// ## Caveats
  /// - If the input is [String], it will be parsed by the [int.tryParse] method.
  /// {@endtemplate}
  static Validator<T> int<T extends Object>([
    Validator<c.int>? next,
    String Function(T input)? intMsg,
  ]) =>
      val.isInt(next, intMsg);

  /// {@template validator_double}
  /// Creates a validator that verifies if an input value is a [double] or can be
  /// parsed into a [double]. If the check succeeds, the transformed value will be
  /// passed to the `next` validator.
  ///
  /// This validator performs two key checks:
  /// 1. Direct validation of `double` types
  /// 2. String parsing validation for string inputs that represent doubles
  ///
  /// ## Type Parameters
  /// - `T`: The type of the input value. Must extend `Object` to ensure non-null
  /// values
  ///
  /// ## Parameters
  /// - `next` (`Validator<double>?`): An optional subsequent validator that receives
  ///   the converted numeric value for additional validation
  /// - `doubleMsg` (`String Function(T input)?`): Optional custom error message
  ///   generator function that receives the invalid input and returns an error
  ///   message
  ///
  /// ## Returns
  /// Returns a `Validator<T>` function that:
  /// - Returns `null` if validation succeeds and no `next` validator is provided
  /// - Returns the result of the `next` validator if provided and initial
  /// validation succeeds
  /// - Returns an error message string if validation fails
  ///
  /// ## Examples
  /// ```dart
  /// // Basic number validation
  /// final validator = Validators.double();
  /// print(validator(42.0));        // null (valid)
  /// print(validator(3.14));      // null (valid)
  /// print(validator('123.45'));  // null (valid)
  /// print(validator('1e-4'));    // null (valid)
  /// print(validator('abc'));     // 'Please enter a valid number'
  ///
  /// // With custom error message
  /// final customValidator = Validators.double(null, (input) => 'Invalid number: $input');
  /// print(customValidator('abc')); // 'Invalid number: abc'
  ///
  /// // With chained validation
  /// final rangeValidator = Validators.double((value) =>
  ///     value > 1000 ? 'Must be less than 1000' : null);
  /// print(rangeValidator('1500')); // 'Must be less than 1000'
  /// ```
  ///
  /// ## Caveats
  /// - If the input is [String], it will be parsed by the [double.tryParse] method.
  /// {@endtemplate}
  static Validator<T> double<T extends Object>([
    Validator<c.double>? next,
    String Function(T input)? doubleMsg,
  ]) =>
      val.isDouble(next, doubleMsg);

  /// {@template validator_num}
  /// Creates a validator that verifies if an input value is a [num] or can be
  /// parsed into a [num]. If the check succeeds, the transformed value will be
  /// passed to the `next` validator.
  ///
  /// This validator performs two key checks:
  /// 1. Direct validation of `num` types (including both `int` and `double`)
  /// 2. String parsing validation for string inputs that represent numbers
  ///
  /// ## Type Parameters
  /// - `T`: The type of the input value. Must extend `Object` to ensure non-null
  /// values
  ///
  /// ## Parameters
  /// - `next` (`Validator<num>?`): An optional subsequent validator that receives
  ///   the converted numeric value for additional validation
  /// - `numMsg` (`String Function(T input)?`): Optional custom error message
  ///   generator function that receives the invalid input and returns an error
  ///   message
  ///
  /// ## Returns
  /// Returns a `Validator<T>` function that:
  /// - Returns `null` if validation succeeds and no `next` validator is provided
  /// - Returns the result of the `next` validator if provided and initial
  /// validation succeeds
  /// - Returns an error message string if validation fails
  ///
  /// ## Examples
  /// ```dart
  /// // Basic number validation
  /// final validator = Validators.num();
  /// print(validator(42));        // null (valid)
  /// print(validator(3.14));      // null (valid)
  /// print(validator('123.45'));  // null (valid)
  /// print(validator('1e-4'));    // null (valid)
  /// print(validator('abc'));     // 'Please enter a valid number'
  ///
  /// // With custom error message
  /// final customValidator = Validators.num(null, (input) => 'Invalid number: $input');
  /// print(customValidator('abc')); // 'Invalid number: abc'
  ///
  /// // With chained validation
  /// final rangeValidator = Validators.num((value) =>
  ///     value > 1000 ? 'Must be less than 1000' : null);
  /// print(rangeValidator('1500')); // 'Must be less than 1000'
  /// ```
  ///
  /// ## Caveats
  /// - If the input is [String], it will be parsed by the [num.tryParse] method.
  /// {@endtemplate}
  static Validator<T> num<T extends Object>([
    Validator<c.num>? next,
    String Function(T input)? numMsg,
  ]) =>
      val.isNum(next, numMsg);

  /// {@template validator_bool}
  /// Creates a validator that verifies if an input value is a [bool] or can be
  /// parsed into a [bool]. If the check succeeds, the transformed value will be
  /// passed to the `next` validator.
  ///
  /// This validator performs two key checks:
  /// 1. Direct validation of `bool` types
  /// 2. String parsing validation for string inputs that represent booleans
  ///
  /// ## Type Parameters
  /// - `T`: The type of the input value. Must extend `Object` to ensure non-null
  /// values
  ///
  /// ## Parameters
  /// - `next` (`Validator<bool>?`): An optional subsequent validator that receives
  ///   the converted boolean value for additional validation
  /// - `boolMsg` (`String Function(T input)?`): Optional custom error message
  ///   generator function that receives the invalid input and returns an error
  ///   message
  /// - `caseSensitive` (`bool`): Controls whether string parsing is case-sensitive.
  ///   When `false`, values like 'TRUE', 'True', and 'true' are all valid. Defaults
  ///   to `false`
  /// - `trim` (`bool`): Controls whether to remove whitespace before parsing string
  ///   inputs. When `true`, strings like ' true ' and 'false\n' are valid. Defaults
  ///   to `true`
  ///
  /// ## Returns
  /// Returns a `Validator<T>` function that:
  /// - Returns `null` if validation succeeds and no `next` validator is provided
  /// - Returns the result of the `next` validator if provided and initial
  /// validation succeeds
  /// - Returns an error message string if validation fails
  ///
  /// ## Examples
  /// ```dart
  /// // Basic boolean validation
  /// final validator = Validators.bool();
  /// print(validator(true));       // null (valid)
  /// print(validator('true'));     // null (valid)
  /// print(validator('TRUE'));     // null (valid)
  /// print(validator(' false '));  // null (valid)
  /// print(validator('abc'));      // 'This field requires a valid boolean (true or false).'
  ///
  /// // With case sensitivity
  /// final strictValidator = Validators.bool(null, null, true);
  /// print(strictValidator('True')); // 'This field requires a valid boolean (true or false).'
  /// print(strictValidator('true')); // null (valid)
  ///
  /// // Without trimming
  /// final noTrimValidator = Validators.bool(null, null, false, false);
  /// print(noTrimValidator(' true')); // 'This field requires a valid boolean (true or false).'
  ///
  /// // With custom error message
  /// final customValidator = Validators.bool(null, (input) => 'Invalid boolean: $input');
  /// print(customValidator('abc')); // 'Invalid boolean: abc'
  ///
  /// // With chained validation
  /// final customValidator = Validators.bool((value) =>
  ///     value == true ? 'Must be false' : null);
  /// print(customValidator('true')); // 'Must be false'
  /// ```
  ///
  /// ## Caveats
  /// - If the input is [String], it will be parsed by the [bool.tryParse] method
  /// {@endtemplate}
  static Validator<T> bool<T extends Object>(
          [Validator<c.bool>? next,
          String Function(T input)? boolMsg,
          c.bool caseSensitive = false,
          c.bool trim = true]) =>
      val.isBool(next, boolMsg, caseSensitive, trim);

  /// {@template validator_date_time}
  /// Creates a validator that verifies if an input value is a [DateTime] or can be
  /// parsed into a [DateTime]. If the check succeeds, the transformed value will be
  /// passed to the `next` validator.
  ///
  /// This validator performs two key checks:
  /// 1. Direct validation of `DateTime` types
  /// 2. String parsing validation for string inputs that represent dates
  ///
  /// ## Type Parameters
  /// - `T`: The type of the input value. Must extend `Object` to ensure non-null
  /// values
  ///
  /// ## Parameters
  /// - `next` (`Validator<DateTime>?`): An optional subsequent validator that
  ///   receives the converted datetime value for additional validation
  /// - `dateTimeMsg` (`String Function(T input)?`): Optional custom error message
  ///   generator function that receives the invalid input and returns an error
  ///   message
  ///
  /// ## Returns
  /// Returns a `Validator<T>` function that:
  /// - Returns `null` if validation succeeds and no `next` validator is provided
  /// - Returns the result of the `next` validator if provided and initial
  /// validation succeeds
  /// - Returns an error message string if validation fails
  ///
  /// ## Examples
  /// ```dart
  /// // Basic datetime validation
  /// final validator = Validators.dateTime();
  /// print(validator(DateTime.now()));          // null (valid)
  /// print(validator('2024-12-31'));           // null (valid)
  /// print(validator('2024-12-31T23:59:59'));  // null (valid)
  /// print(validator('not a date'));           // 'This field requires a valid datetime.'
  ///
  /// // With custom error message
  /// final customValidator = Validators.dateTime(
  ///   null,
  ///   (input) => 'Invalid date format: $input'
  /// );
  /// print(customValidator('abc')); // 'Invalid date format: abc'
  ///
  /// // With chained validation
  /// final futureValidator = Validators.dateTime((value) =>
  ///     value.isBefore(DateTime.now()) ? 'Date must be in the future' : null);
  /// print(futureValidator('2020-01-01')); // 'Date must be in the future'
  /// ```
  ///
  /// ## Caveats
  /// - If the input is [String], it will be parsed by the [DateTime.tryParse] method.
  /// - The function parses a subset of ISO 8601, which includes the subset
  /// accepted by RFC 3339.
  /// {@endtemplate}
  static Validator<T> dateTime<T extends Object>([
    Validator<DateTime>? next,
    String Function(T input)? dateTimeMsg,
  ]) =>
      val.dateTime(next, dateTimeMsg);

  // Path validators
  /// {@template validator_matches_allowed_extensions}
  /// A validator function that checks if a file path's extension matches any of
  /// the specified allowed extensions. Returns `null` for valid extensions, or an
  /// error message for invalid ones.
  ///
  /// The validator supports both single-level (e.g., '.txt') and multi-level
  /// (e.g., '.tar.gz') extensions, with configurable case sensitivity.
  ///
  /// ## Parameters
  /// - `extensions` (`List<String>`): List of valid file extensions. Each extension must start
  ///   with a dot (e.g., '.pdf', '.tar.gz'). Empty string is considered a valid extension
  /// - `matchesAllowedExtensionsMsg` (`String Function(List<String>)?`): Optional custom error
  ///   message generator. Receives the list of allowed extensions and returns an error message
  /// - `caseSensitive` (`bool`): Controls whether extension matching is case-sensitive.
  ///   Defaults to `true`
  ///
  /// ## Returns
  /// Returns a `Validator<String>` function that:
  /// - Returns `null` if the input path's extension matches any allowed extension
  /// - Returns an error message (custom or default) if no extension match is found
  ///
  /// ## Throws
  /// - `AssertionError`: When `extensions` list is empty
  /// - `AssertionError`: When any extension in `extensions` doesn't start with a dot
  ///   (except for empty string)
  ///
  /// ## Examples
  /// ```dart
  /// // Single-level extension validation
  /// final validator = matchesAllowedExtensions(['.pdf', '.doc']);
  /// print(validator('document.pdf')); // Returns: null
  /// print(validator('document.txt')); // Returns: error message
  ///
  /// // Multi-level extension validation
  /// final archiveValidator = matchesAllowedExtensions(['.tar.gz', '.zip']);
  /// print(archiveValidator('archive.tar.gz')); // Returns: null
  ///
  /// // Case-insensitive validation
  /// final caseValidator = matchesAllowedExtensions(
  ///   ['.PDF', '.DOC'],
  ///   caseSensitive: false
  /// );
  /// print(caseValidator('document.pdf')); // Returns: null
  /// ```
  ///
  /// ## Caveats
  /// - Extensions must explicitly include the leading dot (use '.txt' not 'txt')
  /// {@endtemplate}
  static Validator<String> matchesAllowedExtensions(
    List<String> extensions, {
    String Function(List<String>)? matchesAllowedExtensionsMsg,
    c.bool caseSensitive = true,
  }) =>
      val.matchesAllowedExtensions(
        extensions,
        matchesAllowedExtensionsMsg: matchesAllowedExtensionsMsg,
        caseSensitive: caseSensitive,
      );

  // String validators

  /// {@template validator_contains}
  /// Creates a validator function that checks if a string contains a specific
  /// substring. The validation can be performed with or without case sensitivity.
  ///
  /// ## Parameters
  /// - `substring` (`String`): The text pattern to search for within the validated string.
  ///   An empty substring will always result in successful validation.
  /// - `caseSensitive` (`bool`): Determines whether the substring matching should be
  ///   case-sensitive. Defaults to `true`. When set to `false`, both the input value
  ///   and substring are converted to lowercase before comparison.
  /// - `containsMsg` (`String Function(String substring, String input)?`): Optional
  ///   callback function that generates a custom error message. Takes the
  ///   substring and the user input as parameters and returns the error message
  ///   string. If not provided, uses the default localized error message.
  ///
  /// ## Returns
  /// Returns a `Validator<String>` function that:
  /// - Returns `null` if the validation passes (substring is found or empty)
  /// - Returns an error message string if the validation fails (substring not found)
  ///
  /// ## Examples
  /// ```dart
  /// // Case-sensitive validation
  /// final validator = contains('test');
  /// print(validator('This is a test')); // Returns: null
  /// print(validator('This is a TEST')); // Returns: error message
  ///
  /// // Case-insensitive validation
  /// final caseInsensitiveValidator = contains('test', caseSensitive: false);
  /// print(caseInsensitiveValidator('This is a TEST')); // Returns: null
  ///
  /// // Custom error message
  /// final customValidator = contains(
  ///   'required',
  ///   containsMsg: (value, _) => 'Text must contain "$value"'
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - Empty substrings are always considered valid and return `null`
  /// {@endtemplate}
  static Validator<String> contains(
    String substring, {
    c.bool caseSensitive = true,
    String Function(String substring, String input)? containsMsg,
  }) =>
      val.contains(
        substring,
        caseSensitive: caseSensitive,
        containsMsg: containsMsg,
      );

  /// {@template validator_has_min_uppercase_chars}
  /// Creates a validator function that checks if the [String] input contains a
  /// minimum number of uppercase characters. The validator returns `null` for
  /// valid input and an error message for invalid input.
  ///
  /// If validation fails and no custom error message generator is provided via
  /// [hasMinUppercaseCharsMsg], returns the default localized error message from
  /// `FormBuilderLocalizations.current.containsUppercaseCharErrorText(min)`.
  ///
  /// ## Parameters
  /// - `min` (`int`): The minimum number of uppercase characters required. Defaults
  ///   to 1.
  /// - `customUppercaseCounter` (`int Function(String)?`): Optional custom function
  ///   to count uppercase characters. If not provided, uses a default Unicode-based
  ///   counter.
  /// - `hasMinUppercaseCharsMsg` (`String Function(String input, int min)?`):
  ///   Optional function to generate custom error messages. Receives the input and
  ///   the minimum uppercase count required and returns an error message string.
  ///
  /// ## Returns
  /// Returns a `Validator<String>` function that takes a string input and returns:
  /// - `null` if the input contains at least [min] uppercase characters
  /// - An error message string if the validation fails
  ///
  /// ## Throws
  /// - `AssertionError`: When [min] is less than 1
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage with default parameters
  /// final validator = hasMinUppercaseChars();
  /// print(validator('Hello')); // Returns null
  /// print(validator('hello')); // Returns error message
  ///
  /// // Custom minimum requirement
  /// final strictValidator = hasMinUppercaseChars(min: 2);
  /// print(strictValidator('HEllo')); // Returns null
  /// print(strictValidator('Hello')); // Returns error message
  ///
  /// // Custom error message
  /// final customValidator = hasMinUppercaseChars(
  ///   hasMinUppercaseCharsMsg: (_, min) => 'Need $min uppercase letters!',
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - The default counter uses language-independent Unicode mapping, which may not
  ///   work correctly for all languages. Custom uppercase counter function should
  ///   be provided for special language requirements
  /// {@endtemplate}
  static Validator<String> hasMinUppercaseChars({
    c.int min = 1,
    c.int Function(String input)? customUppercaseCounter,
    String Function(String input, c.int min)? hasMinUppercaseCharsMsg,
  }) =>
      val.hasMinUppercaseChars(
        min: min,
        customUppercaseCounter: customUppercaseCounter,
        hasMinUppercaseCharsMsg: hasMinUppercaseCharsMsg,
      );

  /// {@template validator_has_min_lowercase_chars}
  /// Creates a validator function that checks if the [String] input contains a
  /// minimum number of lowercase characters. The validator returns `null` for
  /// valid input and an error message for invalid input.
  ///
  /// If validation fails and no custom error message generator is provided via
  /// [hasMinLowercaseCharsMsg], returns the default localized error message from
  /// `FormBuilderLocalizations.current.containsLowercaseCharErrorText(min)`.
  ///
  /// ## Parameters
  /// - `min` (`int`): The minimum number of lowercase characters required. Defaults
  ///   to 1.
  /// - `customLowercaseCounter` (`int Function(String input)?`): Optional custom function
  ///   to count lowercase characters. It receives the user input as parameter.
  ///   If not provided, uses a default Unicode-based counter.
  /// - `hasMinLowercaseCharsMsg` (`String Function(String input, int min)?`):
  ///   Optional function to generate custom error messages. Receives the input and
  ///   the minimum lowercase count required and returns an error message string.
  ///
  /// ## Returns
  /// Returns a `Validator<String>` function that takes a string input and returns:
  /// - `null` if the input contains at least [min] lowercase characters
  /// - An error message string if the validation fails
  ///
  /// ## Throws
  /// - `AssertionError`: When [min] is less than 1
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage with default parameters
  /// final validator = hasMinLowercaseChars();
  /// print(validator('hello')); // Returns null
  /// print(validator('HELLO')); // Returns error message
  ///
  /// // Custom minimum requirement
  /// final strictValidator = hasMinLowercaseChars(min: 2);
  /// print(strictValidator('hEllo')); // Returns null
  /// print(strictValidator('HELlO')); // Returns error message
  ///
  /// // Custom error message
  /// final customValidator = hasMinLowercaseChars(
  ///   hasMinLowercaseCharsMsg: (_, min) => 'Need $min lowercase letters!',
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - The default counter uses language-independent Unicode mapping, which may not
  ///   work correctly for all languages. Custom lowercase counter function should
  ///   be provided for special language requirements
  /// {@endtemplate}
  static Validator<String> hasMinLowercaseChars({
    c.int min = 1,
    c.int Function(String input)? customLowercaseCounter,
    String Function(String input, c.int min)? hasMinLowercaseCharsMsg,
  }) =>
      val.hasMinLowercaseChars(
        min: min,
        customLowercaseCounter: customLowercaseCounter,
        hasMinLowercaseCharsMsg: hasMinLowercaseCharsMsg,
      );

  /// {@template validator_has_min_numeric_chars}
  /// Creates a validator function that checks if the [String] input contains a
  /// minimum number of numeric characters (0-9). The validator returns `null` for
  /// valid input and an error message for invalid input.
  ///
  /// If validation fails and no custom error message generator is provided via
  /// [hasMinNumericCharsMsg], returns the default localized error message from
  /// `FormBuilderLocalizations.current.containsNumberErrorText(min)`.
  ///
  /// ## Parameters
  /// - `min` (`int`): The minimum number of numeric characters required. Defaults
  ///   to 1.
  /// - `customNumericCounter` (`int Function(String input)?`): Optional custom function
  ///   to count numeric characters. If not provided, uses a default regex-based
  ///   counter matching digits 0-9.
  /// - `hasMinNumericCharsMsg` (`String Function(String input, int min)?`):
  ///   Optional function to generate custom error messages. Receives the input and
  ///   the minimum numeric count required and returns an error message string.
  ///
  /// ## Returns
  /// Returns a `Validator<String>` function that takes a string input and returns:
  /// - `null` if the input contains at least [min] numeric characters
  /// - An error message string if the validation fails
  ///
  /// ## Throws
  /// - `AssertionError`: When [min] is less than 1
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage with default parameters
  /// final validator = hasMinNumericChars();
  /// print(validator('hello123')); // Returns null
  /// print(validator('hello')); // Returns error message
  ///
  /// // Custom minimum requirement
  /// final strictValidator = hasMinNumericChars(min: 2);
  /// print(strictValidator('hello12')); // Returns null
  /// print(strictValidator('hello1')); // Returns error message
  ///
  /// // Custom error message
  /// final customValidator = hasMinNumericChars(
  ///   hasMinNumericCharsMsg: (_, min) => 'Need $min numbers!',
  /// );
  ///
  /// // Custom numeric counter for special cases
  /// final customCounter = hasMinNumericChars(
  ///   customNumericCounter: countNumericDigits, // From a specialized package, for example.
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - The default counter uses a regular expression matching digits 0-9, which may
  ///   not work correctly for all languages or number systems. Custom numeric counter
  ///   function should be provided for special numbering requirements
  /// {@endtemplate}
  static Validator<String> hasMinNumericChars({
    c.int min = 1,
    c.int Function(String input)? customNumericCounter,
    String Function(String input, c.int min)? hasMinNumericCharsMsg,
  }) =>
      val.hasMinNumericChars(
        min: min,
        customNumericCounter: customNumericCounter,
        hasMinNumericCharsMsg: hasMinNumericCharsMsg,
      );

  /// {@template validator_has_min_special_chars}
  /// Creates a validator function that checks if the [String] input contains a
  /// minimum number of special characters. The validator returns `null` for
  /// valid input and an error message for invalid input.
  ///
  /// If validation fails and no custom error message generator is provided via
  /// [hasMinSpecialCharsMsg], returns the default localized error message from
  /// `FormBuilderLocalizations.current.containsSpecialCharErrorText(min)`.
  ///
  /// ## Parameters
  /// - `min` (`int`): The minimum number of special characters required. Defaults
  ///   to 1.
  /// - `customSpecialCounter` (`int Function(String)?`): Optional custom function
  ///   to count special characters. If not provided, uses a default calculation
  ///   that considers special characters as any character that is neither
  ///   alphanumeric.
  /// - `hasMinSpecialCharsMsg` (`String Function(String input, int min)?`):
  ///   Optional function to generate custom error messages. Receives the input and
  ///   the minimum special character count required and returns an error message string.
  ///
  /// ## Returns
  /// Returns a `Validator<String>` function that takes a string input and returns:
  /// - `null` if the input contains at least [min] special characters
  /// - An error message string if the validation fails
  ///
  /// ## Throws
  /// - `AssertionError`: When [min] is less than 1
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage with default parameters
  /// final validator = hasMinSpecialChars();
  /// print(validator('hello@world')); // Returns null
  /// print(validator('helloworld')); // Returns error message
  ///
  /// // Custom minimum requirement
  /// final strictValidator = hasMinSpecialChars(min: 2);
  /// print(strictValidator('hello@#world')); // Returns null
  /// print(strictValidator('hello@world')); // Returns error message
  ///
  /// // Custom error message
  /// final customValidator = hasMinSpecialChars(
  ///   hasMinSpecialCharsMsg: (_, min) => 'Need $min special characters!',
  /// );
  ///
  /// // Custom special character counter for US-ASCII
  /// final asciiValidator = hasMinSpecialChars(
  ///   customSpecialCounter: (v) => RegExp('[^A-Za-z0-9]').allMatches(v).length,
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - The default counter uses language-independent Unicode mapping, which may not
  ///   work correctly for all languages. Custom special character counter function
  ///   should be provided for specific character set requirements
  /// {@endtemplate}
  static Validator<String> hasMinSpecialChars({
    c.int min = 1,
    c.int Function(String input)? customSpecialCounter,
    String Function(String input, c.int min)? hasMinSpecialCharsMsg,
  }) =>
      val.hasMinSpecialChars(
        min: min,
        customSpecialCounter: customSpecialCounter,
        hasMinSpecialCharsMsg: hasMinSpecialCharsMsg,
      );

  /// {@template validator_match}
  /// Creates a validator function that checks if the [String] input matches a given
  /// regular expression pattern. The validator returns `null` for valid input and
  /// an error message for invalid input.
  ///
  /// If validation fails and no custom error message is provided via [matchMsg],
  /// returns the default localized error message from
  /// `FormBuilderLocalizations.current.matchErrorText`.
  ///
  /// ## Parameters
  /// - `regex` (`RegExp`): The regular expression pattern to match against the input
  ///   string.
  /// - `matchMsg` (`String Function(String input)?`): Optional custom error message
  /// to display when the validation fails. If not provided, uses the default
  /// localized error message.
  ///
  /// ## Returns
  /// Returns a `Validator<String>` function that takes a string input and returns:
  /// - `null` if the input matches the provided regular expression pattern
  /// - An error message string if the validation fails
  ///
  /// ## Examples
  /// ```dart
  /// // Basic email validation
  /// final emailValidator = match(
  ///   emailRegExp,
  ///   matchMsg: (_)=>'Please enter a valid email address',
  /// );
  /// print(emailValidator('user@example.com')); // Returns null
  /// print(emailValidator('invalid-email')); // Returns error message
  /// ```
  ///
  /// ## Caveats
  /// - Complex regular expressions may impact performance for large inputs
  /// - Consider using more specific validators for common patterns like email
  ///   or phone number validation
  /// {@endtemplate}
  static Validator<String> match(
    RegExp regExp, {
    String Function(String input)? matchMsg,
  }) =>
      val.match(regExp, matchMsg: matchMsg);

  /// {@template validator_uuid}
  /// A validator function that checks if a given string matches the UUID format.
  ///
  /// Creates a validator that ensures the input string conforms to the standard
  /// UUID (Universally Unique Identifier) format, consisting of 32 hexadecimal
  /// digits displayed in 5 groups separated by hyphens (8-4-4-4-12).
  ///
  /// ## Parameters
  /// - `regex` (`RegExp?`): Optional custom regular expression pattern to override
  ///   the default UUID validation pattern. Useful for supporting different UUID
  ///   formats or adding additional constraints.
  /// - `uuidMsg` (`String Function(String input)?`): Optional callback function that
  ///   generates a custom error message based on the invalid input. If not provided,
  ///   defaults to the standard form builder localization error text.
  ///
  /// ## Returns
  /// Returns a `Validator<String>` function that accepts a string input and returns:
  /// - `null` if the input is valid
  /// - An error message string if the input is invalid
  ///
  /// ## Examples
  /// ```dart
  /// // Using default UUID validation
  /// final validator = uuid();
  /// print(validator('123e4567-e89b-12d3-a456-426614174000')); // null
  /// print(validator('invalid-uuid')); // Returns error message
  ///
  /// // Using custom error message
  /// final customValidator = uuid(
  ///   uuidMsg: (input) => 'Invalid UUID format: $input',
  /// );
  ///
  /// // Using custom regex pattern
  /// final customPatternValidator = uuid(
  ///   regex: RegExp(r'^[0-9]{8}-[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{12}$'),
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - The default regex pattern accepts both uppercase and lowercase hexadecimal
  ///   digits (0-9, a-f, A-F)
  /// - The validation only checks the format, not the actual UUID version or
  ///   variant compliance
  /// {@endtemplate}
  static Validator<String> uuid({
    RegExp? regex,
    String Function(String input)? uuidMsg,
  }) =>
      val.uuid(regex: regex, uuidMsg: uuidMsg);

// Collection validators
  /// {@template validator_equal_length}
  /// Creates a validator function that checks if the input collection's length equals
  /// the specified length. The validator returns `null` for valid input and an error
  /// message for invalid input.
  ///
  /// If validation fails and no custom error message generator is provided via
  /// [equalLengthMsg], returns the default localized error message from
  /// `FormBuilderLocalizations.current.equalLengthErrorText(expectedLength)`.
  ///
  /// ## Type Parameters
  /// - `T`: The type of input to validate. Must be a collection, in other words,
  /// it must be one of `String`, `Iterable` or `Map`.
  ///
  /// ## Parameters
  /// - `expectedLength` (`int`): The exact length required. Must be non-negative.
  /// - `equalLengthMsg` (`String Function(T input, int expectedLength)?`): Optional
  ///   function to generate custom error messages. Receives the input and the
  ///   expected length, returning an error message string.
  ///
  /// ## Return Value
  /// A `Validator<T>` function that produces:
  /// - `null` for valid inputs (length == expectedLength)
  /// - An error message string for invalid inputs (length != expectedLength)
  ///
  /// ## Throws
  /// - `ArgumentError` when:
  ///   - [expectedLength] is negative
  ///   - input runtime type is not a collection
  ///
  /// ## Examples
  /// ```dart
  /// // String validation
  /// final stringValidator = equalLength<String>(3);
  /// print(stringValidator('abc')); // Returns null
  /// print(stringValidator('ab')); // Returns error message
  /// print(stringValidator('abcd')); // Returns error message
  ///
  /// // List validation
  /// final listValidator = equalLength<List>(2);
  /// print(listValidator([1, 2])); // Returns null
  /// print(listValidator([1])); // Returns error message
  /// print(listValidator([1, 2, 3])); // Returns error message
  ///
  /// // Custom error message
  /// final customValidator = equalLength<String>(
  ///   5,
  ///   equalLengthMsg: (_, expectedLength) =>
  ///     'Text must be exactly $expectedLength chars long!',
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - Type parameter `T` must be restricted to `String`, `Map`, or `Iterable`.
  /// While the compiler cannot enforce this restriction, it is the developer's
  /// responsibility to maintain this constraint.
  /// - The validator treats non-collection inputs as implementation errors rather
  /// than validation failures. Validate input types before passing them to
  /// this validator.
  /// {@endtemplate}
  static Validator<T> equalLength<T extends Object>(c.int expectedLength,
          {String Function(T input, c.int expectedLength)? equalLengthMsg}) =>
      val.equalLength(
        expectedLength,
        equalLengthMsg: equalLengthMsg,
      );

  /// {@template validator_min_length}
  /// Creates a validator function that checks if the input collection's length is
  /// greater than or equal to `min`. The validator returns `null` for valid input
  /// and an error message for invalid input.
  ///
  /// If validation fails and no custom error message generator is provided via
  /// [minLengthMsg], returns the default localized error message from
  /// `FormBuilderLocalizations.current.minLengthErrorText(min)`.
  ///
  /// ## Type Parameters
  /// - `T`: The type of input to validate. Must be a collection, in other words,
  /// it must be one of `String`, `Iterable` or `Map`.
  ///
  /// ## Parameters
  /// - `min` (`int`): The minimum length required. Must be non-negative.
  /// - `minLengthMsg` (`String Function(T input, int min)?`): Optional
  ///   function to generate custom error messages. Receives the input and the
  ///   minimum length required and returns an error message string.
  ///
  /// ## Return Value
  /// A `Validator<T>` function that produces:
  /// - `null` for valid inputs (length >= min)
  /// - An error message string for invalid inputs (length < min)
  ///
  /// ## Throws
  /// - `ArgumentError` when:
  ///   - [min] is negative
  ///   - input runtime type is not a collection
  ///
  /// ## Examples
  /// ```dart
  /// // String validation
  /// final stringValidator = minLength<String>(3);
  /// print(stringValidator('abc')); // Returns null
  /// print(stringValidator('ab')); // Returns error message
  ///
  /// // List validation
  /// final listValidator = minLength<List>(2);
  /// print(listValidator([1, 2, 3])); // Returns null
  /// print(listValidator([1])); // Returns error message
  ///
  /// // Custom error message
  /// final customValidator = minLength<String>(
  ///   5,
  ///   minLengthMsg: (_, min) => 'Text must be at least $min chars long!',
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - Type parameter `T` must be restricted to `String`, `Map`, or `Iterable`.
  /// While the compiler cannot enforce this restriction, it is the developer's
  /// responsibility to maintain this constraint.
  /// - The validator treats non-collection inputs as implementation errors rather
  /// than validation failures. Validate input types before passing them to
  /// this validator.
  /// {@endtemplate}
  static Validator<T> minLength<T extends Object>(c.int min,
          {String Function(T input, c.int min)? minLengthMsg}) =>
      val.minLength(min, minLengthMsg: minLengthMsg);

  /// {@template validator_max_length}
  /// Creates a validator function that checks if the input collection's length is
  /// less than or equal to max. The validator returns null for valid input
  /// and an error message for invalid input.
  ///
  /// If validation fails and no custom error message generator is provided via
  /// [maxLengthMsg], returns the default localized error message from
  /// `FormBuilderLocalizations.current.maxLengthErrorText(max)`.
  ///
  /// ## Type Parameters
  /// - T: The type of input to validate. Must be a collection, in other words,
  /// it must be one of `String`, `Iterable` or `Map`.
  ///
  /// ## Parameters
  /// - `max` (`int`): The maximum length allowed. Must be non-negative.
  /// - `maxLengthMsg` (`String Function(T input, int max)?`): Optional
  ///   function to generate custom error messages. Receives the input and the
  ///   maximum length allowed and returns an error message string.
  ///
  /// ## Return Value
  /// A `Validator<T>` function that produces:
  /// - null for valid inputs (length <= max)
  /// - An error message string for invalid inputs (length > max)
  ///
  /// ## Throws
  /// - `ArgumentError` when:
  ///   - [max] is negative
  ///   - input runtime type is not a collection
  ///
  /// ## Examples
  /// ```dart
  /// // String validation
  /// final stringValidator = maxLength<String>(5);
  /// print(stringValidator('hello')); // Returns null
  /// print(stringValidator('hello world')); // Returns error message
  ///
  /// // List validation
  /// final listValidator = maxLength<List>(3);
  /// print(listValidator([1, 2])); // Returns null
  /// print(listValidator([1, 2, 3, 4])); // Returns error message
  ///
  /// // Custom error message
  /// final customValidator = maxLength<String>(
  ///   10,
  ///   maxLengthMsg: (_, max) => 'Text must not exceed $max chars!',
  /// );
  /// ```
  /// ## Caveats
  /// - Type parameter `T` must be restricted to `String`, `Map`, or `Iterable`.
  /// While the compiler cannot enforce this restriction, it is the developer's
  /// responsibility to maintain this constraint.
  /// - The validator treats non-collection inputs as implementation errors rather
  /// than validation failures. Validate input types before passing them to
  /// this validator.
  /// {@endtemplate}
  static Validator<T> maxLength<T extends Object>(c.int max,
          {String Function(T input, c.int max)? maxLengthMsg}) =>
      val.maxLength(max, maxLengthMsg: maxLengthMsg);

  /// {@template validator_between_length}
  /// Creates a validator function that checks if the input collection's length falls
  /// within an inclusive range defined by `min` and `max`. The validator returns
  /// `null` for valid input and an error message for invalid input.
  ///
  /// If validation fails and no custom error message generator is provided via
  /// [betweenLengthMsg], returns the default localized error message from
  /// `FormBuilderLocalizations.current.betweenLengthErrorText(min, max)`.
  ///
  /// ## Type Parameters
  /// - `T`: The type of input to validate. Must be a collection, in other words,
  /// it must be one of `String`, `Iterable` or `Map`.
  ///
  /// ## Parameters
  /// - `min` (`int`): The minimum length required. Must be non-negative.
  /// - `max` (`int`): The maximum length allowed. Must be greater than or equal
  ///   to `min`.
  /// - `betweenLengthMsg` (`String Function(T input, {required int min, required int max})?`):
  ///   Optional function to generate custom error messages. Receives the input and the
  ///   minimum and maximum lengths required, returning an error message string.
  ///
  /// ## Return Value
  /// A `Validator<T>` function that produces:
  /// - `null` for valid inputs (min <= length <= max)
  /// - An error message string for invalid inputs (length < min || length > max)
  ///
  /// ## Throws
  /// - `ArgumentError` when:
  ///   - [min] is negative
  ///   - [max] is less than [min]
  ///   - input runtime type is not a collection
  ///
  /// ## Examples
  /// ```dart
  /// // String validation
  /// final stringValidator = betweenLength<String>(3, 5);
  /// print(stringValidator('abc')); // Returns null
  /// print(stringValidator('ab')); // Returns error message
  /// print(stringValidator('abcdef')); // Returns error message
  ///
  /// // List validation
  /// final listValidator = betweenLength<List>(2, 4);
  /// print(listValidator([1, 2, 3])); // Returns null
  /// print(listValidator([1])); // Returns error message
  /// print(listValidator([1, 2, 3, 4, 5])); // Returns error message
  ///
  /// // Custom error message
  /// final customValidator = betweenLength<String>(
  ///   5,
  ///   10,
  ///   betweenLengthMsg: (_, {required min, required max}) =>
  ///     'Text must be between $min and $max chars long!',
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - Type parameter `T` must be restricted to `String`, `Map`, or `Iterable`.
  /// While the compiler cannot enforce this restriction, it is the developer's
  /// responsibility to maintain this constraint.
  /// - The validator treats non-collection inputs as implementation errors rather
  /// than validation failures. Validate input types before passing them to
  /// this validator.
  /// {@endtemplate}
  static Validator<T> betweenLength<T extends Object>(
    c.int min,
    c.int max, {
    String Function(T input, {required c.int min, required c.int max})?
        betweenLengthMsg,
  }) =>
      val.betweenLength(min, max, betweenLengthMsg: betweenLengthMsg);

  // DateTime Validators
  /// {@template validator_after}
  /// Creates a [DateTime] validator that checks if an input date occurs after
  /// `reference`.
  ///
  /// ## Parameters
  /// - `reference` (`DateTime`): The baseline date against which the input will be compared.
  ///   This serves as the minimum acceptable date (exclusive by default).
  /// - `afterMsg` (`String Function(DateTime input, DateTime reference)?`): Optional custom
  ///   error message generator. When provided, it receives both the input and reference
  ///   dates to construct a context-aware error message.
  /// - `inclusive` (`bool`): When set to `true`, allows the input date to exactly match
  ///   the reference date. Defaults to `false`, requiring strictly later dates.
  ///
  /// ## Returns
  /// Returns a `Validator<DateTime>` function that:
  /// - Returns `null` if validation passes (input is after reference)
  /// - Returns an error message string if validation fails
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage requiring date after January 1st, 2025
  /// final validator = Validators.after(DateTime(2025));
  ///
  /// // Inclusive validation allowing exact match
  /// final inclusiveValidator = Validators.after(
  ///   DateTime(2024),
  ///   inclusive: true,
  /// );
  ///
  /// // Custom error message
  /// final customValidator = Validators.after(
  ///   DateTime(2024),
  ///   isAfterMsg: (_, ref) => 'Please select a date after ${ref.toString()}',
  /// );
  /// ```
  /// {@endtemplate}
  static Validator<DateTime> after(
    DateTime reference, {
    String Function(DateTime input, DateTime reference)? afterMsg,
    c.bool inclusive = false,
  }) =>
      val.after(reference, afterMsg: afterMsg, inclusive: inclusive);

  /// {@template validator_before}
  /// Creates a [DateTime] validator that checks if an input date occurs before
  /// `reference`.
  ///
  /// ## Parameters
  /// - `reference` (`DateTime`): The baseline date against which the input will be compared.
  ///   This serves as the maximum acceptable date (exclusive by default).
  /// - `beforeMsg` (`String Function(DateTime input, DateTime reference)?`): Optional custom
  ///   error message generator. When provided, it receives both the input and reference
  ///   dates to construct a context-aware error message.
  /// - `inclusive` (`bool`): When set to `true`, allows the input date to exactly match
  ///   the reference date. Defaults to `false`, requiring strictly earlier dates.
  ///
  /// ## Returns
  /// Returns a `Validator<DateTime>` function that:
  /// - Returns `null` if validation passes (input is before reference)
  /// - Returns an error message string if validation fails. If no custom message is provided,
  ///   falls back to the localized error text from `FormBuilderLocalizations`
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage requiring date before January 1st, 2025
  /// final validator = Validators.before(DateTime(2025));
  ///
  /// // Inclusive validation allowing exact match
  /// final inclusiveValidator = Validators.before(
  ///   DateTime(2024),
  ///   inclusive: true,
  /// );
  ///
  /// // Custom error message
  /// final customValidator = Validators.before(
  ///   DateTime(2024),
  ///   isBeforeMsg: (_, ref) => 'Please select a date before ${ref.toString()}',
  /// );
  /// ```
  /// {@endtemplate}
  static Validator<DateTime> before(
    DateTime reference, {
    String Function(DateTime input, DateTime reference)? beforeMsg,
    c.bool inclusive = false,
  }) =>
      val.before(reference, beforeMsg: beforeMsg, inclusive: inclusive);

  /// {@template validator_between_date_time}
  /// Creates a [DateTime] validator that checks if an input date falls within a specified
  /// range defined by `minReference` and `maxReference`.
  ///
  /// The validator ensures the input date occurs after `minReference` and before
  /// `maxReference`, with optional inclusive boundaries controlled by `minInclusive`
  /// and `maxInclusive` parameters.
  ///
  /// ## Parameters
  /// - `minReference` (`DateTime`): The lower bound of the acceptable date range.
  ///   Input dates must occur after this date (or equal to it if `minInclusive` is true).
  /// - `maxReference` (`DateTime`): The upper bound of the acceptable date range.
  ///   Input dates must occur before this date (or equal to it if `maxInclusive` is true).
  /// - `betweenDateTimeMsg` (`String Function(DateTime, DateTime, DateTime)?`): Optional
  ///   custom error message generator. When provided, it receives the input date and both
  ///   reference dates to construct a context-aware error message.
  /// - `minInclusive` (`bool`): When set to `true`, allows the input date to exactly match
  ///   the `minReference` date. Defaults to `false`.
  /// - `maxInclusive` (`bool`): When set to `true`, allows the input date to exactly match
  ///   the `maxReference` date. Defaults to `false`.
  ///
  /// ## Returns
  /// Returns a `Validator<DateTime>` function that:
  /// - Returns `null` if validation passes (input is within the specified range)
  /// - Returns an error message string if validation fails. If no custom message is provided,
  ///   falls back to the localized error text from `FormBuilderLocalizations`
  ///
  /// ## Throws
  /// - `AssertionError`: When `minReference` is not chronologically before `maxReference`,
  ///   indicating an invalid date range configuration.
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage requiring date between 2023 and 2025
  /// final validator = Validators.betweenDateTime(
  ///   DateTime(2023),
  ///   DateTime(2025),
  /// );
  ///
  /// // Inclusive validation allowing exact matches
  /// final inclusiveValidator = Validators.betweenDateTime(
  ///   DateTime(2023),
  ///   DateTime(2025),
  ///   minInclusive: true,
  ///   maxInclusive: true,
  /// );
  ///
  /// // Custom error message
  /// final customValidator = Validators.betweenDateTime(
  ///   DateTime(2023),
  ///   DateTime(2025),
  ///   betweenDateTimeMsg: (_, min, max) =>
  ///     'Please select a date between ${min.toString()} and ${max.toString()}',
  /// );
  /// ```
  /// {@endtemplate}
  static Validator<DateTime> betweenDateTime(
    DateTime minReference,
    DateTime maxReference, {
    String Function(
            DateTime input, DateTime minReference, DateTime maxReference)?
        betweenDateTimeMsg,
    c.bool leftInclusive = false,
    c.bool rightInclusive = false,
  }) =>
      val.betweenDateTime(minReference, maxReference,
          betweenDateTimeMsg: betweenDateTimeMsg,
          minInclusive: leftInclusive,
          maxInclusive: rightInclusive);

  /// {@template validator_max_file_size}
  /// Validates that a file size in bytes is less than or equal to `max`.
  ///
  /// This validator compares the input integer (representing bytes) against a
  /// maximum size threshold (`max`). The comparison can be performed using
  /// either 1000-based units (B, kB, MB, etc.) or 1024-based units (B, KiB,
  /// MiB, etc.) depending on the selected [base].
  ///
  /// ## Parameters
  /// - `max` (`int`): The maximum allowed file size in bytes
  /// - `base` (`Base`): The base unit system to use for calculations and error messages.
  ///   Defaults to [Base.b1024]
  /// - `maxFileSizeMsg` (`String Function(int input, int max, Base base)?`):
  ///   Optional custom error message generator that receives the input size,
  ///   maximum size, and base to produce a tailored error message
  ///
  /// ## Returns
  /// A [Validator] function that returns `null` when the input is valid (less than or equal
  /// to the maximum size), or an error message string when validation fails
  ///
  /// ## Examples
  /// ```dart
  /// // Create a validator restricting files to 5 MiB using 1024-based units
  /// final validator = maxFileSize(5 * 1024 * 1024);
  ///
  /// // Create a validator restricting files to 5 MB using 1000-based units
  /// final validator = maxFileSize(5 * 1000 * 1000, base: Base.b1000);
  ///
  /// // Using a custom error message
  /// final validator = maxFileSize(
  ///   10 * 1024 * 1024,
  ///   maxFileSizeMsg: (input, max, base) => 'File too large: ${formatBytes(input, base)}',
  /// );
  /// ```
  /// {@endtemplate}
  static Validator<c.int> maxFileSize(
    c.int max, {
    val.Base base = val.Base.b1024,
    String Function(c.int input, c.int max, val.Base base)? maxFileSizeMsg,
  }) =>
      val.maxFileSize(max, base: base, maxFileSizeMsg: maxFileSizeMsg);

  // Generic type validators
  /// {@template validator_in_list}
  /// Creates a validator function that verifies if a given input is in `values`.
  ///
  /// ## Type Parameters
  /// - `T`: The type of elements to validate. Must extend Object?, allowing nullable
  /// types.
  ///
  /// ## Parameters
  /// - `values` (`List<T>`): A non-empty list of valid values to check against. The input
  ///   will be validated against these values.
  /// - `inListMsg` (`String Function(T input, List<T> values)?`): Optional callback
  ///   function that generates a custom error message when validation fails. The function
  ///   receives the invalid input and the list of valid values as parameters. If not provided,
  ///   defaults to the localized error text from FormBuilderLocalizations.
  ///
  /// ## Returns
  /// Returns a `Validator<T>`  function that:
  /// - Returns null if the input value exists in the provided list
  /// - Returns a generated error message if the input is not found in the list.
  ///
  /// ## Throws
  /// - `AssertionError`: Thrown if the provided values list is empty, which would
  /// make any input invalid.
  ///
  /// ## Examples
  /// ```dart
  /// // Creating a validator with a custom error message generator
  /// final countryValidator = Validators.inList(
  ///   ['USA', 'Canada', 'Mexico'],
  ///   isInListMsg: (input, values) =>
  ///     'Country $input is not in allowed list: ${values.join(", ")}',
  /// );
  ///
  /// // Using the validator
  /// final result = countryValidator('Brazil'); // Returns "Country Brazil is not in allowed list: USA, Canada, Mexico"
  /// final valid = countryValidator('USA');     // Returns null (valid)
  /// ```
  /// {@endtemplate}
  static Validator<T> inList<T extends Object?>(
    List<T> values, {
    String Function(T input, List<T> values)? inListMsg,
  }) =>
      val.inList(values, inListMsg: inListMsg);

  /// {@template validator_is_true}
  /// Creates a validator function that checks if a given input represents a `true`
  /// boolean value, either as a direct boolean or as a string that can be parsed
  /// to `true`.
  ///
  /// ## Type Parameters
  /// - `T`: The type of input to validate. Must extend `Object` to allow for both
  /// boolean and string inputs.
  ///
  /// ## Parameters
  /// - `isTrueMsg` (`String Function(T input)?`): Optional callback function to
  /// generate custom error messages for invalid inputs. Receives the invalid
  /// input as a parameter.
  /// - `caseSensitive` (`bool`): Controls whether string comparison is
  /// case-sensitive. Defaults to `false`, making, for example, 'TRUE' and 'true'
  /// equivalent.
  /// - `trim` (`bool`): Determines if leading and trailing whitespace should be
  /// removed from string inputs before validation. Defaults to `true`.
  ///
  /// ## Returns
  /// Returns a `Validator<T>` function that:
  /// - Returns `null` if the input is `true` or parses to `true`
  /// - Returns an error message if the input is invalid, either from `isTrueMsg`
  /// or the default localized text
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage with default settings
  /// final validator = isTrue<String>();
  /// assert(validator('true') == null);      // Valid: case-insensitive match
  /// assert(validator(' TRUE ') == null);     // Valid: trimmed and case-insensitive
  /// assert(validator('t r u e') != null);      // Invalid: returns error message
  /// assert(validator('false') != null);      // Invalid: returns error message
  ///
  /// // Custom configuration
  /// final strictValidator = isTrue<String>(
  ///   caseSensitive: true,
  ///   trim: false,
  ///   isTrueMsg: (input) => 'Value "$input" must be exactly "true"',
  /// );
  /// assert(strictValidator('true') == null);   // Valid
  /// assert(strictValidator('TRUE') != null);   // Invalid: case-sensitive
  /// assert(strictValidator(' true') != null);  // Invalid: no trimming
  /// ```
  /// {@endtemplate}
  static Validator<T> isTrue<T extends Object>(
          {String Function(T input)? isTrueMsg,
          c.bool caseSensitive = false,
          c.bool trim = true}) =>
      val.isTrue(
          isTrueMsg: isTrueMsg, caseSensitive: caseSensitive, trim: trim);

  /// {@template validator_is_false}
  /// Creates a validator function that checks if a given input represents a `false`
  /// boolean value, either as a direct boolean or as a string that can be parsed
  /// to `false`.
  ///
  /// ## Type Parameters
  /// - `T`: The type of input to validate. Must extend `Object` to allow for both
  /// boolean and string inputs.
  ///
  /// ## Parameters
  /// - `isFalseMsg` (`String Function(T input)?`): Optional callback function to
  /// generate custom error messages for invalid inputs. Receives the invalid
  /// input as a parameter.
  /// - `caseSensitive` (`bool`): Controls whether string comparison is
  /// case-sensitive. Defaults to `false`, making, for example, 'FALSE' and 'false'
  /// equivalent.
  /// - `trim` (`bool`): Determines if leading and trailing whitespace should be
  /// removed from string inputs before validation. Defaults to `true`.
  ///
  /// ## Returns
  /// Returns a `Validator<T>` function that:
  /// - Returns `null` if the input is `false` or parses to `false`
  /// - Returns an error message if the input is invalid, either from `isFalseMsg`
  /// or the default localized text
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage with default settings
  /// final validator = isFalse<String>();
  /// assert(validator('false') == null);     // Valid: case-insensitive match
  /// assert(validator(' FALSE ') == null);    // Valid: trimmed and case-insensitive
  /// assert(validator('f a l s e') != null); // Invalid: returns error message
  /// assert(validator('true') != null);      // Invalid: returns error message
  ///
  /// // Custom configuration
  /// final strictValidator = isFalse<String>(
  ///   caseSensitive: true,
  ///   trim: false,
  ///   isFalseMsg: (input) => 'Value "$input" must be exactly "false"',
  /// );
  /// assert(strictValidator('false') == null);  // Valid
  /// assert(strictValidator('FALSE') != null);  // Invalid: case-sensitive
  /// assert(strictValidator(' false') != null); // Invalid: no trimming
  /// ```
  /// {@endtemplate}
  static Validator<T> isFalse<T extends Object>(
          {String Function(T input)? isFalseMsg,
          c.bool caseSensitive = false,
          c.bool trim = false}) =>
      val.isFalse(
          isFalseMsg: isFalseMsg, caseSensitive: caseSensitive, trim: trim);

  // Numeric validators
  /// {@template validator_between}
  /// Creates a validator function that checks if a numeric input falls within a specified
  /// range defined by `min` and `max` values.
  ///
  /// ## Type Parameters
  /// - `T`: A numeric type that extends [num], allowing `int`, `double` or
  /// `num` validations
  ///
  /// ## Parameters
  /// - `min` (`T`): The lower bound of the valid range
  /// - `max` (`T`): The upper bound of the valid range
  /// - `minInclusive` (`bool`): Determines if the lower bound is inclusive. Defaults to `true`
  /// - `maxInclusive` (`bool`): Determines if the upper bound is inclusive. Defaults to `true`
  /// - `betweenMsg` (`String Function(T input, T min, T max, bool minInclusive, bool maxInclusive)?`):
  ///   Optional custom error message generator that takes the input value, inclusivity flags,
  ///   and range bounds as parameters
  ///
  ///
  /// ## Returns
  /// Returns a [Validator] function that:
  /// - Returns `null` if the input falls within the specified range according to the
  ///   inclusivity settings
  /// - Returns an error message string if validation fails, either from the custom
  ///   `betweenMsg` function or the default localized error text from
  ///   [FormBuilderLocalizations]
  ///
  /// ## Throw
  /// - `AssertionError`: when `max` is not greater than or equal to `min`.
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage with inclusive bounds
  /// final ageValidator = between<int>(18, 65); // [18, 65]
  ///
  /// // Exclusive upper bound for decimal values
  /// final priceValidator = between<double>( // [0.0, 100.0)
  ///   0.0,
  ///   100.0,
  ///   maxInclusive: false,
  /// );
  ///
  /// // Custom error message
  /// final scoreValidator = between<double>( //
  ///   0.0,
  ///   10.0,
  ///   betweenMsg: (_, min, max, __, ___) =>
  ///     'Score must be between $min and $max (inclusive)',
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - The default behavior uses inclusive bounds (`>=` and `<=`)
  /// {@endtemplate}
  static Validator<T> between<T extends c.num>(T min, T max,
          {c.bool minInclusive = true,
          c.bool maxInclusive = true,
          String Function(
            T input,
            T min,
            T max,
            c.bool minInclusive,
            c.bool maxInclusive,
          )? betweenMsg}) =>
      val.between(
        min,
        max,
        minInclusive: minInclusive,
        maxInclusive: maxInclusive,
        betweenMsg: betweenMsg,
      );

  /// {@template validator_greater_than}
  /// Creates a validator function that checks if a numeric input exceeds `reference`.
  ///
  /// ## Type Parameters
  /// - `T`: A numeric type that extends [num], allowing `int`, `double` or
  /// `num` validations
  ///
  /// ## Parameters
  /// - `reference` (`T`): The threshold value that the input must exceed
  /// - `greaterThanMsg` (`String Function(T input, T reference)?`): Optional custom error
  ///   message generator that takes the input value and threshold as parameters
  ///
  /// ## Returns
  /// Returns a [Validator] function that:
  /// - Returns `null` if the input is greater than the threshold value `reference`
  /// - Returns an error message string if validation fails, either from the custom
  ///   `greaterThanMsg` function or the default localized error text
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage with integers
  /// final ageValidator = greaterThan<int>(18);
  ///
  /// // Custom error message
  /// final priceValidator = greaterThan<double>(
  ///   0.0,
  ///   greaterThanMsg: (_, ref) => 'Price must be greater than \$${ref.toStringAsFixed(2)}',
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - The validator uses strict greater than comparison (`>`)
  /// {@endtemplate}
  static Validator<T> greaterThan<T extends c.num>(T reference,
          {String Function(c.num input, c.num reference)? greaterThanMsg}) =>
      val.greaterThan(reference, greaterThanMsg: greaterThanMsg);

  /// {@template validator_greater_than_or_equal_to}
  /// Creates a validator function that checks if a numeric input is greater than
  /// or equal to `reference`.
  ///
  /// ## Type Parameters
  /// - `T`: A numeric type that extends [num], allowing `int`, `double` or
  /// `num` validations
  ///
  /// ## Parameters
  /// - `reference` (`T`): The threshold value that the input must be greater than or equal to
  /// - `greaterThanOrEqualToMsg` (`String Function(T input, T reference)?`): Optional custom error
  ///   message generator that takes the input value and threshold as parameters
  ///
  /// ## Returns
  /// Returns a [Validator] function that:
  /// - Returns `null` if the input is greater than or equal to the threshold value
  /// `reference`
  /// - Returns an error message string if validation fails, either from the custom
  ///   `greaterThanOrEqualToMsg` function or the default localized error text from
  ///   [FormBuilderLocalizations]
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage with integers
  /// final ageValidator = greaterThanOrEqualTo<int>(18);
  ///
  /// // Custom error message
  /// final priceValidator = greaterThanOrEqualTo<double>(
  ///   0.0,
  ///   greaterThanOrEqualToMsg: (_, ref) => 'Price must be at least \$${ref.toStringAsFixed(2)}',
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - The validator uses greater than or equal to comparison (`>=`)
  /// {@endtemplate}
  static Validator<T> greaterThanOrEqualTo<T extends c.num>(T reference,
          {String Function(c.num input, c.num reference)?
              greaterThanOrEqualToMsg}) =>
      val.greaterThanOrEqualTo(reference,
          greaterThanOrEqualToMsg: greaterThanOrEqualToMsg);

  /// {@template validator_less_than}
  /// Creates a validator function that checks if a numeric input is less than `reference`.
  ///
  /// ## Type Parameters
  /// - `T`: A numeric type that extends [num], allowing `int`, `double` or
  /// `num` validations
  ///
  /// ## Parameters
  /// - `reference` (`T`): The threshold value that the input must be less than
  /// - `lessThanMsg` (`String Function(T input, T reference)?`): Optional custom error
  ///   message generator that takes the input value and threshold as parameters
  ///
  /// ## Returns
  /// Returns a [Validator] function that:
  /// - Returns `null` if the input is less than the threshold value `reference`
  /// - Returns an error message string if validation fails, either from the custom
  ///   `lessThanMsg` function or the default localized error text
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage with integers
  /// final maxAgeValidator = lessThan<int>(100);
  ///
  /// // Custom error message
  /// final discountValidator = lessThan<double>(
  ///   1.0,
  ///   lessThanMsg: (_, ref) => 'Discount must be less than ${(ref * 100).toStringAsFixed(0)}%',
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - The validator uses strict less than comparison (`<`)
  /// {@endtemplate}
  static Validator<T> lessThan<T extends c.num>(T reference,
          {String Function(c.num input, c.num reference)? lessThanMsg}) =>
      val.lessThan(reference, lessThanMsg: lessThanMsg);

  /// {@template validator_less_than_or_equal_to}
  /// Creates a validator function that checks if a numeric input is less than
  /// or equal to `reference`.
  ///
  /// ## Type Parameters
  /// - `T`: A numeric type that extends [num], allowing `int`, `double` or
  /// `num` validations
  ///
  /// ## Parameters
  /// - `reference` (`T`): The threshold value that the input must be less than or equal to
  /// - `lessThanOrEqualToMsg` (`String Function(T input, T reference)?`): Optional custom error
  ///   message generator that takes the input value and threshold as parameters
  ///
  /// ## Returns
  /// Returns a [Validator] function that:
  /// - Returns `null` if the input is less than or equal to the threshold value
  /// `reference`
  /// - Returns an error message string if validation fails, either from the custom
  ///   `lessThanOrEqualToMsg` function or the default localized error text from
  ///   [FormBuilderLocalizations]
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage with integers
  /// final maxAgeValidator = lessThanOrEqualTo<int>(100);
  ///
  /// // Custom error message
  /// final maxPriceValidator = lessThanOrEqualTo<double>(
  ///   999.99,
  ///   lessThanOrEqualToMsg: (_, ref) => 'Price cannot exceed \$${ref.toStringAsFixed(2)}',
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - The validator uses less than or equal to comparison (`<=`)
  /// {@endtemplate}
  static Validator<T> lessThanOrEqualTo<T extends c.num>(T reference,
          {String Function(c.num input, c.num reference)?
              lessThanOrEqualToMsg}) =>
      val.lessThanOrEqualTo(reference,
          lessThanOrEqualToMsg: lessThanOrEqualToMsg);

  // User information validators

  /// {@template validator_email}
  /// A validator function that checks if a given string is a valid email address.
  /// Uses either a custom or default RFC 5322 compliant regular expression for validation.
  ///
  /// ## Parameters
  /// - `regex` (`RegExp?`): Optional custom regular expression for email validation.
  ///   If not provided, uses a default RFC 5322 compliant pattern that supports:
  ///   - ASCII characters
  ///   - Unicode characters (including IDN domains)
  ///   - Special characters in local part
  ///   - Quoted strings
  ///   - Multiple dots
  ///
  /// - `emailMsg` (`String Function(String input)?`): Optional custom error message
  ///   generator function that takes the invalid input and returns a custom error
  ///   message. If not provided, uses the default localized error text.
  ///
  /// ## Returns
  /// Returns a `Validator<String>` function that:
  /// - Returns `null` if the email is valid
  /// - Returns an error message string if the email is invalid
  ///
  /// ## Examples
  /// Basic usage with default settings:
  /// ```dart
  /// final emailValidator = email();
  /// final result = emailValidator('user@example.com');
  /// print(result); // null (valid email)
  /// ```
  ///
  /// Using custom regex and error message:
  /// ```dart
  /// final customValidator = email(
  ///   regex: RegExp(r'^[a-zA-Z0-9.]+@company\.com$'),
  ///   emailMsg: (input) => '$input is not a valid company email',
  /// );
  /// ```
  /// {@endtemplate}
  static Validator<String> email({
    RegExp? regex,
    String Function(String input)? emailMsg,
  }) =>
      val.email(regex: regex, emailMsg: emailMsg);

  /// {@template validator_password}
  /// Creates a composite validator for password validation that enforces multiple
  /// password strength requirements simultaneously.
  ///
  /// This validator combines multiple validation rules including length constraints,
  /// character type requirements (uppercase, lowercase, numbers, and special characters),
  /// and allows for custom error message overriding.
  ///
  /// ## Parameters
  /// - `minLength` (`int`): Minimum required length for the password. Defaults to `16`
  /// - `maxLength` (`int`): Maximum allowed length for the password. Defaults to `32`
  /// - `minUppercaseCount` (`int`): Minimum required uppercase characters. Defaults to `1`
  /// - `minLowercaseCount` (`int`): Minimum required lowercase characters. Defaults to `1`
  /// - `minNumberCount` (`int`): Minimum required numeric characters. Defaults to `1`
  /// - `minSpecialCharCount` (`int`): Minimum required special characters. Defaults to `1`
  /// - `passwordMsg` (`String Function(String input)?`): Optional custom error message
  ///   that overrides all validation error messages. When `null`, individual validator
  ///   messages are used.
  ///
  /// ## Returns
  /// Returns a `Validator<String>` that combines all specified password requirements
  /// into a single validator. The validator returns null if all conditions are met,
  /// otherwise returns the appropriate error message.
  ///
  /// ## Examples
  /// ```dart
  /// // Default password validation
  /// final validator = password();
  ///
  /// // Custom requirements
  /// final strictValidator = Validator.password(
  ///   minLength: 12,
  ///   minUppercaseCount: 2,
  ///   minSpecialCharCount: 2,
  ///   passwordMsg: (_)=>'Password does not meet security requirements'
  /// );
  /// ```
  ///
  /// ## Caveats
  /// - When `passwordMsg` is provided, individual validation failure details
  ///   are not available to the user.
  /// {@endtemplate}
  static Validator<String> password({
    c.int minLength = 8,
    c.int maxLength = 32,
    c.int minUppercaseCount = 1,
    c.int minLowercaseCount = 1,
    c.int minNumberCount = 1,
    c.int minSpecialCharCount = 1,
    String Function(String input)? passwordMsg,
  }) =>
      val.password(
        minLength: minLength,
        maxLength: maxLength,
        minUppercaseCount: minUppercaseCount,
        minLowercaseCount: minLowercaseCount,
        minNumberCount: minNumberCount,
        minSpecialCharCount: minSpecialCharCount,
        passwordMsg: passwordMsg,
      );

  /// {@template validator_phoneNumber}
  /// A validator function for phone number validation that supports various international
  /// phone number formats with optional country codes, area codes, and separators.
  ///
  /// The validator checks if the input string matches a flexible phone number pattern
  /// that accommodates:
  /// - Optional leading '+' for international numbers
  /// - Country codes (1-4 digits)
  /// - Area codes with optional parentheses
  /// - Multiple number groups separated by spaces, dots, or hyphens
  ///
  /// ## Parameters
  /// - `regex` (`RegExp?`): Optional custom regular expression pattern for phone
  ///   number validation. If not provided, defaults to the internal `_phoneNumberRegex`
  ///   pattern that supports international formats
  /// - `phoneNumberMsg` (`String Function(String input)?`): Optional callback function
  ///   that generates a custom error message based on the invalid input. If not
  ///   provided, uses the default error message from `FormBuilderLocalizations`
  ///
  /// ## Returns
  /// Returns `null` if the phone number is valid according to the specified pattern,
  /// otherwise returns an error message string. The error message can be either:
  /// - A custom message generated by the provided `phoneNumberMsg` callback
  /// - The default localized error text from `FormBuilderLocalizations`
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage with default regex
  /// final validator = phoneNumber();
  /// print(validator('+1 (555) 123-4567')); // Returns: null
  /// print(validator('invalid')); // Returns: error message
  ///
  /// // Custom regex and error message
  /// final customValidator = phoneNumber(
  ///   regex: RegExp(r'^\d{10}$'),
  ///   phoneNumberMsg: (input) => 'Invalid number: $input',
  /// );
  /// ```
  /// {@endtemplate}
  static Validator<String> phoneNumber({
    RegExp? regex,
    String Function(String input)? phoneNumberMsg,
  }) =>
      val.phoneNumber(regex: regex, phoneNumberMsg: phoneNumberMsg);

  // Finance validators
  /// {@template validator_credit_card}
  /// A validator function for credit card number validation that supports major card
  /// types and implements the Luhn algorithm for number verification.
  ///
  /// The validator performs a two-step validation process:
  /// 1. Matches the input against patterns for major credit card providers
  /// 2. Validates the number using the Luhn algorithm to ensure mathematical
  ///   validity
  ///
  /// The validator supports major credit card formats including:
  /// - Visa (13 and 16 digits)
  /// - MasterCard (16 digits)
  /// - American Express (15 digits)
  /// - Discover (16 digits)
  /// - Diners Club (14 digits)
  /// - JCB (15 or 16 digits)
  ///
  /// ## Parameters
  /// - `regex` (`RegExp?`): Optional custom regular expression pattern for credit
  ///   card validation. If not provided, defaults to the internal `_creditCardRegex`
  ///   pattern that supports major card providers
  /// - `creditCardMsg` (`String Function(String input)?`): Optional callback function
  ///   that generates a custom error message based on the invalid input. If not
  ///   provided, uses the default error message from `FormBuilderLocalizations`
  ///
  /// ## Returns
  /// Returns `null` if the credit card number is valid according to both the pattern
  /// matching and Luhn algorithm verification. Otherwise returns an error message
  /// string that can be either:
  /// - A custom message generated by the provided `creditCardMsg` callback
  /// - The default localized error text from `FormBuilderLocalizations`
  ///
  /// ## Examples
  /// ```dart
  /// // Basic usage with default regex
  /// final validator = creditCard();
  /// print(validator('4111111111111111')); // Returns: null (valid Visa format)
  /// print(validator('invalid')); // Returns: error message
  ///
  /// // Custom regex and error message
  /// final customValidator = creditCard(
  ///   regex: RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$'), // Visa cards only
  ///   creditCardMsg: (input) => 'Invalid card number: $input',
  /// );
  /// ```
  /// {@endtemplate}
  static Validator<String> creditCard({
    RegExp? regex,
    String Function(String input)? creditCardMsg,
  }) =>
      val.creditCard(regex: regex, creditCardMsg: creditCardMsg);

// Network validators

  /// {@template validator_ip}
  /// Creates a validator function for IP address validation, supporting both IPv4 and IPv6 formats.
  /// The validator ensures that input strings conform to the specified IP address version's format
  /// and structure requirements.
  ///
  /// ## Parameters
  /// - `version` (`IpVersion`): Specifies the IP address version to validate against.
  ///   Currently supports version 4 (`iPv4`), 6 (`iPv6`) or both (`any`).
  /// - `regex` (`RegExp?`): Optional custom regular expression pattern for IP address
  ///   validation. If provided, this pattern will be used instead of the default
  ///   version-specific patterns.
  /// - `ipMsg` (`String Function(String input)?`): Optional custom error message
  ///   generator function. Takes the invalid input string and returns a custom error
  ///   message. If not provided, defaults to the standard localized error message.
  ///
  /// ## Returns
  /// Returns a `Validator<String>` function that takes a string input and returns:
  /// - `null` if the input is a valid IP address according to the specified version
  /// - An error message string if the input is invalid
  ///
  /// ## Examples
  /// ```dart
  /// // Basic IPv4 validation
  /// final ipv4Validator = ip();
  /// print(ipv4Validator('192.168.1.1')); // null (valid)
  /// print(ipv4Validator('256.1.2.3')); // Returns error message (invalid)
  ///
  /// // Custom error message for IPv6
  /// final ipv6Validator = ip(
  ///   version: IpVersion.iPv6,
  ///   ipMsg: (input) => 'Invalid IPv6 address: $input',
  /// );
  /// ```
  /// ## Caveats
  /// - The validator does not verify if the IP address is actually accessible or
  ///   assigned on the network.
  /// {@endtemplate}
  static Validator<String> ip({
    IpVersion version = IpVersion.iPv4,
    RegExp? regex,
    String Function(String input)? ipMsg,
  }) =>
      val.ip(
        version: version,
        regex: regex,
        ipMsg: ipMsg,
      );

  /// {@template validator_url}
  /// A validator function that checks if a given string represents a valid URL
  /// based on specified criteria. This validator supports customizable URL
  /// validation including protocol verification, TLD requirements, and host
  /// filtering.
  ///
  /// ## Parameters
  /// - `protocols` (`List<String>`): List of allowed protocols. Defaults to
  ///   `['http', 'https', 'ftp']` if not specified
  /// - `requireTld` (`bool`): Whether the URL must contain a top-level domain.
  ///   Defaults to `true`
  /// - `requireProtocol` (`bool`): Whether the URL must include a protocol.
  ///   Defaults to `false`
  /// - `allowUnderscore` (`bool`): Whether underscores are permitted in the URL.
  ///   Defaults to `false`
  /// - `hostAllowList` (`List<String>`): List of explicitly allowed host names.
  ///   Empty by default
  /// - `hostBlockList` (`List<String>`): List of blocked host names.
  ///   Empty by default
  /// - `regex` (`RegExp?`): Optional custom regular expression for additional
  ///   URL validation
  /// - `urlMsg` (`String Function(String input)?`): Custom error message generator
  ///   function that takes the invalid URL as input
  ///
  /// ## Returns
  /// Returns `null` if the URL is valid according to all specified criteria.
  /// Otherwise, returns an error message string, either custom-generated via
  /// `urlMsg` or the default localized URL error text.
  ///
  /// ## Examples
  /// ```dart
  /// // Basic URL validation
  /// final validator = url();
  /// print(validator('https://example.com')); // Returns: null
  ///
  /// // Custom protocol validation
  /// final ftpValidator = url(
  ///   protocols: ['ftp'],
  ///   requireProtocol: true
  /// );
  /// print(ftpValidator('ftp://server.com')); // Returns: null
  ///
  /// // With host filtering
  /// final restrictedValidator = url(
  ///   hostBlockList: ['example.com'],
  ///   hostAllowList: ['trusted-domain.com']
  /// );
  /// ```
  /// {@endtemplate}
  static Validator<String> url({
    List<String> protocols = val.kDefaultUrlValidationProtocols,
    c.bool requireTld = true,
    c.bool requireProtocol = false,
    c.bool allowUnderscore = false,
    List<String> hostAllowList = const <String>[],
    List<String> hostBlockList = const <String>[],
    RegExp? regex,
    String Function(String input)? urlMsg,
  }) =>
      val.url(
        protocols: protocols,
        requireTld: requireTld,
        requireProtocol: requireProtocol,
        allowUnderscore: allowUnderscore,
        hostAllowList: hostAllowList,
        hostBlockList: hostBlockList,
        regex: regex,
        urlMsg: urlMsg,
      );
}
