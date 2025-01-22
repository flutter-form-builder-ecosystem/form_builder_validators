// coverage:ignore-file
import 'package:flutter/widgets.dart';

import '../form_builder_validators.dart';
//import 'validators/constants.dart'; // Uncomment after removing the deprecated code.
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

/// A class that is used as an aggregator/namespace for all the available
/// validators in this package.
final class Validators {
  // Composition validators
  /// {@macro validator_and}
  static Validator<T> and<T extends Object>(
    List<Validator<T>> validators, {
    String prefix = '',
    String suffix = '',
    String? separator,
    bool printErrorAsSoonAsPossible = true,
  }) =>
      val.and<T>(validators,
          prefix: prefix,
          suffix: suffix,
          separator: separator,
          printErrorAsSoonAsPossible: printErrorAsSoonAsPossible);

  /// {@macro validator_or}
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
  /// {@macro validator_validate_if}
  static Validator<T> validateIf<T extends Object?>(
          bool Function(T value) condition, Validator<T> v) =>
      val.validateIf<T>(condition, v);

  /// {@macro validator_skip_if}
  static Validator<T> skipIf<T extends Object?>(
          bool Function(T value) condition, Validator<T> v) =>
      val.skipIf<T>(condition, v);

  // Debug print validator
  /// {@macro validator_debug_print_validator}
  static Validator<T> debugPrintValidator<T extends Object?>(
          {Validator<T>? next, String Function(T input)? logOnInput}) =>
      val.debugPrintValidator(next: next, logOnInput: logOnInput);

  // Equality validators
  /// {@macro validator_is_equal}
  static Validator<T> isEqual<T extends Object?>(
    T value, {
    String Function(T input, T referenceValue)? isEqualMsg,
  }) =>
      val.isEqual(value, isEqualMsg: isEqualMsg);

  /// {@macro validator_is_not_equal}
  static Validator<T> isNotEqual<T extends Object?>(
    T value, {
    String Function(T input, T referenceValue)? isNotEqualMsg,
  }) =>
      val.isNotEqual(value, isNotEqualMsg: isNotEqualMsg);

  // Required validators
  /// {@macro validator_is_required}
  static Validator<T?> isRequired<T extends Object>([
    Validator<T>? next,
    String? isRequiredMsg,
  ]) =>
      val.isRequired(next, isRequiredMsg);

  /// {@macro validator_validate_with_default}
  static Validator<T?> validateWithDefault<T extends Object>(
          T defaultValue, Validator<T> next) =>
      val.validateWithDefault(defaultValue, next);

  /// {@macro validator_is_optional}
  static Validator<T?> isOptional<T extends Object>([
    Validator<T>? next,
    String Function(T input, String nextErrorMsg)? isOptionalMsg,
  ]) =>
      val.isOptional(next, isOptionalMsg);

  // Transform Validator

  /// {@macro validator_transform_and_validate}
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
  /// {@macro validator_is_string}
  static Validator<T> isString<T extends Object>([
    Validator<String>? next,
    String Function(T input)? isStringMsg,
  ]) =>
      val.isString(next, isStringMsg);

  /// {@macro validator_is_int}
  static Validator<T> isInt<T extends Object>([
    Validator<int>? next,
    String Function(T input)? isIntMsg,
  ]) =>
      val.isInt(next, isIntMsg);

  /// {@macro validator_is_num}
  static Validator<T> isNum<T extends Object>([
    Validator<num>? next,
    String Function(T input)? isNumMsg,
  ]) =>
      val.isNum(next, isNumMsg);

  /// {@macro validator_is_bool}
  static Validator<T> isBool<T extends Object>(
          [Validator<bool>? next,
          String Function(T input)? isBoolMsg,
          bool caseSensitive = false,
          bool trim = true]) =>
      val.isBool(next, isBoolMsg, caseSensitive, trim);

  /// {@macro validator_is_date_time}
  static Validator<T> isDateTime<T extends Object>([
    Validator<DateTime>? next,
    String Function(T input)? isDateTimeMsg,
  ]) =>
      val.isDateTime(next, isDateTimeMsg);

  // Path validators
  /// {@macro validator_matches_allowed_extensions}
  static Validator<String> matchesAllowedExtensions(
    List<String> extensions, {
    String Function(List<String>)? matchesAllowedExtensionsMsg,
    bool caseSensitive = true,
  }) =>
      val.matchesAllowedExtensions(
        extensions,
        matchesAllowedExtensionsMsg: matchesAllowedExtensionsMsg,
        caseSensitive: caseSensitive,
      );

  // String validators
  /// {@macro validator_password}
  static Validator<String> password({
    int minLength = 8,
    int maxLength = 32,
    int minUppercaseCount = 1,
    int minLowercaseCount = 1,
    int minNumberCount = 1,
    int minSpecialCharCount = 1,
    String? passwordMsg,
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

  // PROVISORY IMPLEMENTATION (start)
  /// {@macro validator_email}
  static Validator<String> email({
    RegExp? regex,
    String? emailMsg,
  }) =>
      val.email(regex: regex, emailMsg: emailMsg);

  // PROVISORY IMPLEMENTATION (end)

  /// {@macro validator_has_min_uppercase_chars}
  static Validator<String> hasMinUppercaseChars({
    int min = 1,
    int Function(String)? customUppercaseCounter,
    String Function(String input, int min)? hasMinUppercaseCharsMsg,
  }) =>
      val.hasMinUppercaseChars(
        min: min,
        customUppercaseCounter: customUppercaseCounter,
        hasMinUppercaseCharsMsg: hasMinUppercaseCharsMsg,
      );

  /// {@macro validator_has_min_lowercase_chars}
  static Validator<String> hasMinLowercaseChars({
    int min = 1,
    int Function(String)? customLowercaseCounter,
    String Function(String input, int min)? hasMinLowercaseCharsMsg,
  }) =>
      val.hasMinLowercaseChars(
        min: min,
        customLowercaseCounter: customLowercaseCounter,
        hasMinLowercaseCharsMsg: hasMinLowercaseCharsMsg,
      );

  /// {@macro validator_has_min_numeric_chars}
  static Validator<String> hasMinNumericChars({
    int min = 1,
    int Function(String)? customNumericCounter,
    String Function(String input, int min)? hasMinNumericCharsMsg,
  }) =>
      val.hasMinNumericChars(
        min: min,
        customNumericCounter: customNumericCounter,
        hasMinNumericCharsMsg: hasMinNumericCharsMsg,
      );

  /// {@macro validator_has_min_special_chars}
  static Validator<String> hasMinSpecialChars({
    int min = 1,
    int Function(String)? customSpecialCounter,
    String Function(String input, int min)? hasMinSpecialCharsMsg,
  }) =>
      val.hasMinSpecialChars(
        min: min,
        customSpecialCounter: customSpecialCounter,
        hasMinSpecialCharsMsg: hasMinSpecialCharsMsg,
      );

  /// {@macro validator_match}
  static Validator<String> match(
    RegExp regex, {
    String Function(String input)? matchMsg,
  }) =>
      val.match(regex, matchMsg: matchMsg);

  // TODO implement the other string validators here...

// Collection validators
  /// {@macro validator_min_length}
  static Validator<T> minLength<T extends Object>(int min,
          {String Function(T input, int min)? minLengthMsg}) =>
      val.minLength(min, minLengthMsg: minLengthMsg);

  /// {@macro validator_max_length}
  static Validator<T> maxLength<T extends Object>(int max,
          {String Function(T input, int max)? maxLengthMsg}) =>
      val.maxLength(max, maxLengthMsg: maxLengthMsg);

  /// {@macro validator_between_length}
  static Validator<T> betweenLength<T extends Object>(
    int min,
    int max, {
    String Function(T input, {required int min, required int max})?
        betweenLengthMsg,
  }) =>
      val.betweenLength(min, max, betweenLengthMsg: betweenLengthMsg);

  /// {@macro validator_equal_length}
  static Validator<T> equalLength<T extends Object>(int expectedLength,
          {String Function(T input, int expectedLength)? equalLengthMsg}) =>
      val.equalLength(
        expectedLength,
        equalLengthMsg: equalLengthMsg,
      );

  // DateTime Validators
  /// {@macro validator_is_after}
  static Validator<DateTime> isAfter(
    DateTime reference, {
    String Function(DateTime input, DateTime reference)? isAfterMsg,
    bool inclusive = false,
  }) =>
      val.isAfter(reference, isAfterMsg: isAfterMsg, inclusive: inclusive);

  /// {@macro validator_is_before}
  static Validator<DateTime> isBefore(
    DateTime reference, {
    String Function(DateTime input, DateTime reference)? isBeforeMsg,
    bool inclusive = false,
  }) =>
      val.isBefore(reference, isBeforeMsg: isBeforeMsg, inclusive: inclusive);

  /// {@macro validator_is_date_time_between}
  static Validator<DateTime> isDateTimeBetween(
    DateTime minReference,
    DateTime maxReference, {
    String Function(
            DateTime input, DateTime minReference, DateTime maxReference)?
        isDateTimeBetweenMsg,
    bool leftInclusive = false,
    bool rightInclusive = false,
  }) =>
      val.isDateTimeBetween(minReference, maxReference,
          isDateTimeBetweenMsg: isDateTimeBetweenMsg,
          minInclusive: leftInclusive,
          maxInclusive: rightInclusive);

  /// {@macro validator_is_in_the_past}
  static Validator<DateTime> isInThePast({
    String Function(DateTime input)? isInThePastMsg,
  }) =>
      val.isInThePast(isInThePastMsg: isInThePastMsg);

  /// {@macro validator_is_in_the_future}
  static Validator<DateTime> isInTheFuture({
    String Function(DateTime input)? isInTheFutureMsg,
  }) =>
      val.isInTheFuture(isInTheFutureMsg: isInTheFutureMsg);

  // Generic type validators
  /// {@macro validator_contains_element}
  static Validator<T> containsElement<T extends Object?>(
    List<T> values, {
    String Function(T input, List<T> values)? containsElementMsg,
  }) =>
      val.containsElement(values, containsElementMsg: containsElementMsg);

  /// {@macro validator_is_true}
  static Validator<T> isTrue<T extends Object>(
          {String Function(T input)? isTrueMsg,
          bool caseSensitive = false,
          bool trim = true}) =>
      val.isTrue(
          isTrueMsg: isTrueMsg, caseSensitive: caseSensitive, trim: trim);

  /// {@macro validator_is_false}
  static Validator<T> isFalse<T extends Object>(
          {String Function(T input)? isFalseMsg,
          bool caseSensitive = false,
          bool trim = false}) =>
      val.isFalse(
          isFalseMsg: isFalseMsg, caseSensitive: caseSensitive, trim: trim);

  // Numeric validators
  /// {@macro validator_greater_than}
  static Validator<T> greaterThan<T extends num>(T reference,
          {String Function(num input, num reference)? greaterThanMsg}) =>
      val.greaterThan(reference, greaterThanMsg: greaterThanMsg);

  /// {@macro validator_greater_than_or_equal_to}
  static Validator<T> greaterThanOrEqualTo<T extends num>(T reference,
          {String Function(num input, num reference)?
              greaterThanOrEqualToMsg}) =>
      val.greaterThanOrEqualTo(reference,
          greaterThanOrEqualToMsg: greaterThanOrEqualToMsg);

  /// {@macro validator_less_than}
  static Validator<T> lessThan<T extends num>(T reference,
          {String Function(num input, num reference)? lessThanMsg}) =>
      val.lessThan(reference, lessThanMsg: lessThanMsg);

  /// {@macro validator_less_than_or_equal_to}
  static Validator<T> lessThanOrEqualTo<T extends num>(T reference,
          {String Function(num input, num reference)? lessThanOrEqualToMsg}) =>
      val.lessThanOrEqualTo(reference,
          lessThanOrEqualToMsg: lessThanOrEqualToMsg);

  /// {@macro validator_between}
  static Validator<T> between<T extends num>(T min, T max,
          {bool minInclusive = true,
          bool maxInclusive = true,
          String Function(
            T input,
            T min,
            T max,
            bool minInclusive,
            bool maxInclusive,
          )? betweenMsg}) =>
      val.between(
        min,
        max,
        minInclusive: minInclusive,
        maxInclusive: maxInclusive,
        betweenMsg: betweenMsg,
      );
}
