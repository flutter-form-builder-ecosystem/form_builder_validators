# Form Builder Validators

Form Builder Validators offers a set of validators for any `FormField` widget or widgets that extend the `FormField` class - _e.g._, `TextFormField`, `DropdownFormField`, _et cetera_. It provides standard ready-made validation rules and a way to compose new validation rules combining multiple rules, including custom ones.

Also it includes the `l10n` / `i18n` of error text messages to multiple languages.

[![Pub Version](https://img.shields.io/pub/v/form_builder_validators?logo=flutter&style=for-the-badge)](https://pub.dev/packages/form_builder_validators)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/flutter-form-builder-ecosystem/form_builder_validators/base.yaml?branch=main&logo=github&style=for-the-badge)](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/actions/workflows/base.yaml)
[![Codecov](https://img.shields.io/codecov/c/github/flutter-form-builder-ecosystem/form_builder_validators?logo=codecov&style=for-the-badge)](https://codecov.io/gh/flutter-form-builder-ecosystem/form_builder_validators/)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/flutter-form-builder-ecosystem/form_builder_validators?logo=codefactor&style=for-the-badge)](https://www.codefactor.io/repository/github/flutter-form-builder-ecosystem/form_builder_validators)

---

## Call for Maintainers 

> We are looking for maintainers to contribute to the development and maintenance of Flutter Form Builder Ecosystem. Is very important to keep the project alive and growing, so we need your help to keep it up to date and with new features. You can contribute in many ways, we describe some of them in [Support](#support) section.

## Contents

- [Features](#features)
- [Validators](#validators)
  - [Collection validators](#collection-validators)
  - [Core validators](#core-validators)
    - [Composition validators](#composition-validators)
    - [Conditional validators](#conditional-validators)
    - [Debug print validator](#debug-print-validator)
    - [Equality validators](#equality-validators)
    - [Required validators](#required-validators)
    - [Transform validators](#transform-validators)
  - [Datetime validators](#datetime-validators)
  - [File validators](#file-validators)
  - [Finance validators](#finance-validators)
  - [Generic type validators](#generic-type-validators)
  - [Miscellaneous validators](#miscellaneous-validators)
  - [Network validators](#network-validators)
  - [Numeric validators](#numeric-validators)
  - [Path validators](#path-validators)
  - [String validators](#string-validators)
  - [Type validators](#type-validators)
  - [User information validators](#user-information-validators)
- [Supported languages](#supported-languages)
- [Use](#use)
  - [Setup](#setup)
  - [Basic use](#basic-use)
  - [Specific uses](#specific-uses)
    - [Composing multiple validators](#composing-multiple-validators)
    - [Modify the default error message in a specific language](#modify-the-default-error-message-in-a-specific-language)
- [Migrations](#migrations)
  - [v7 to v8](#v7-to-v8)
  - [v10 to 11](#v10-to-v11)
- [How this package works](#how-this-package-works)
- [Support](#support)
  - [Contribute](#contribute)
    - [Add new supported language](#add-new-supported-language)
    - [Add new validator](#add-new-validator)
  - [Questions and answers](#questions-and-answers)
  - [Donations](#donations)
- [Roadmap](#roadmap)
- [Ecosystem](#ecosystem)
- [Thanks to](#thanks-to)

## Features

- Ready-made validation rules
- Compose multiple reusable validation rules
- Default error messages in multiple languages

## Validators

This package comes with several most common `FormFieldValidator`s such as required, numeric, email,
URL, min, max, minLength, maxLength, minWordsCount, maxWordsCount, IP, credit card, etc., with default `errorText` messages.

Generally, the validators are separated in three main groups:
1. Field Requirement Validators: makes a field optional or required.
2. Type Validators: checks the type of the field.
3. Other validators: make any other kind of check that is not related to null/emptiness or type validation.

Generally, we build a validator composing those three types in the following way:
`<fieldRequirementValidator>(<typeValidator>(<otherValidator>()))`

For example: 
- Make the field required, check if it is of type `num` or a `String` parsable to num and then check if 
it is greater than 10.
`Validators.required(Validators.num(Validators.greaterThan(10)))`

As easy as that! This validator is meant to be used with form fields like in the following example:
```dart
// Example from the folder `examples`
TextFormField(
  decoration: const InputDecoration(
    labelText: 'Min Value Field',
    prefixIcon: Icon(Icons.exposure_neg_1),
  ),
  keyboardType: TextInputType.number,
  validator: Validators.required(Validators.num(Validators.greaterThan(10))),
  textInputAction: TextInputAction.next,
  autovalidateMode: AutovalidateMode.always,
);
```


### Collection validators

- `Validators.equalLength(expectedLength)`: Checks if the field contains a collection (must be a `String`, `Iterable`, or `Map`) with length equals `expectedLength`.
- `Validators.minLength(min)`: Checks if the field contains a collection (must be a `String`, `Iterable`, or `Map`) with length greater than or equal to `min`.
- `Validators.maxLength(max)`: Checks if the field contains a collection (must be a `String`, `Iterable`, or `Map`) with length less than or equal to `max`.
- `Validators.betweenLength(min, max)`: Checks if the field contains a collection (must be a `String`, `Iterable`, or `Map`) with length between `min` and `max`, inclusive.

### Core validators

#### Composition validators

- `Validators.and(validators)`: Validates the field by requiring it to pass all validators in the `validators` list.
- `Validators.or(validators)`: Validates the field by requiring it to pass at least one of the validators in the `validators` list.
 
#### Conditional validators

- `Validators.validateIf(condition, v)`: Validates the field with validator `v` only if `condition` is `true`.
- `Validators.skipIf(condition, v)`: Validates the field with validator `v` only if `condition` is `false`.

#### Debug print validator
- `Validators.debugPrintValidator()`: Print, for debug purposes, the user input value.
 
#### Equality validators

- `Validators.equal(value)`: Checks if the field contains an input that is equal to `value` (==).
- `Validators.notEqual(value)`: Checks if the field contains an input that is not equal to `value` (!=).
 
#### Field Requirement Validators

- `Validators.required(next)`: Makes the field required by checking if it contains a non-null and non-empty value, passing it to the `next` validator as a not-nullable type.
- `Validators.optional(next)`: Makes the field optional by passing it to the `next` validator if it contains a non-null and non-empty value. If the field is null or empty, null is returned.
- `Validators.validateWithDefault(defaultValue, next)`: Validates the field with `next` validator. If the input is null, it uses the `defaultValue` instead.

#### Transform validators

- `Validators.transformAndValidate<IN, OUT>(transformFunction, next:next)`: Transforms an input from `IN` type to `OUT` type through the function `transformFunction` and pass it to the `next` validator.

### Datetime validators

- `Validators.after(reference)`: Checks if the field contains a `DateTime` that is after `reference`.
- `Validators.before(reference)`: Checks if the field contains a `DateTime` that is before `reference`.
- `Validators.betweenDateTime(minReference, maxReference)`: Checks if the field contains a `DateTime` that is after `minReference` and before `maxReference`.

### File validators

- TODO [ ] `FormBuilderValidators.fileSize()` - requires the field's to be less than the max size.

### Finance validators

- TODO [ ] `FormBuilderValidators.bic()` - requires the field's to be a valid BIC.
- TODO [ ] `FormBuilderValidators.iban()` - requires the field's to be a valid IBAN.

### Generic Type Validators
Validators that check a generic type user input.

- `Validators.inList(values)`: Checks if the field contains a value that is in the list `values`.
- `Validators.isTrue()`: Checks if the field contains a boolean or a parsable `String` of the `true` value.
- `Validators.isFalse()`: Checks if the field contains a boolean or a parsable `String` of the `false` value.

### Miscellaneous validators

- TODO [ ] `FormBuilderValidators.colorCode()` - requires the field's value to be a valid color code.
- TODO `FormBuilderValidators.isbn()` - requires the field's to be a valid ISBN.
 
### Network validators

- `Validators.ip()`: Checks if the field contains a properly formatted `Internet Protocol` (IP) address. It may check for either `IPv4`, or `IPv6` or even for both.
- `Validators.url()`: Checks if the field contains a properly formatted `Uniform Resource Locators` (URL).
- TODO [ ] `FormBuilderValidators.email()` - requires the field's value to be a valid email address.
- TODO [ ] `FormBuilderValidators.macAddress()` - requires the field's to be a valid MAC address.

### Numeric validators

- `Validators.between(min, max)`: Checks if the field contains a number that is in the inclusive range [min, max].
- `Validators.greaterThan(reference)`: Checks if the field contains a number that is greater than `reference`.
- `Validators.greaterThanOrEqualTo(reference)`: Checks if the field contains a number that is greater than or equal to `reference`.
- `Validators.lessThan(reference)`: Checks if the field contains a number that is less than `reference`.
- `Validators.lessThanOrEqualTo(reference)`: Checks if the field contains a number that is less than or equal to `reference`.

### Path Validators
- `Validators.matchesAllowedExtensions(extensions)`: Checks if the field contains a `String` that is in the list `extensions`.

### String validators

- `Validators.contains(substring)` - Checks if the field contains the `substring`.
- TODO [ ] `FormBuilderValidators.endsWith()` - requires the substring to be the end of the field's value.
- TODO [ ] `FormBuilderValidators.startsWith()` - requires the substring to be the start of the field's value.
- TODO [ ] `FormBuilderValidators.lowercase()` - requires the field's value to be lowercase.
- TODO [ ] `FormBuilderValidators.uppercase()` - requires the field's value to be uppercase.
- `Validators.hasMinUppercaseChars(min:min)` - Checks if the field has a minimum number of uppercase chars.
- `Validators.hasMinLowercaseChars(min:min)` - Checks if the field has a minimum number of lowercase chars.
- `Validators.hasMinNumericChars(min:min)` - Checks if the field has a minimum number of numeric chars.
- `Validators.hasMinSpecialChars(min:min)` - Checks if the field has a minimum number of special chars.
- `Validators.match(regExp)` - Checks if the field matches with the regular expression `regExp`.
- `Validators.uuid()` - Checks if the field is a valid Universally Unique Identifier (UUID).
- TODO [ ] `FormBuilderValidators.maxWordsCount()` - requires the word count of the field's value to be less than or equal to the provided maximum count.
- TODO [ ] `FormBuilderValidators.minWordsCount()` - requires the word count of the field's value to be greater than or equal to the provided minimum count.

### Type Validators
- `Validators.string(next)`: Checks if the field contains a valid `String` and passes the input as `String` to the `next` validator.
- `Validators.int(next)`: Checks if the field contains a valid `int` or parsable `String` to `int` and passes the input as `int` to the `next` validator.
- `Validators.double(next)`: Checks if the field contains a valid `double` or parsable `String` to `double` and passes the input as `double` to the `next` validator.
- `Validators.num(next)`: Checks if the field contains a valid `num` or parsable `String` to `num` and passes the input as `num` to the `next` validator.
- `Validators.bool(next)`: Checks if the field contains a valid `bool` or parsable `String` to `bool` and passes the input as `bool` to the `next` validator.
- `Validators.dateTime(next)`: Checks if the field contains a valid `DateTime` or parsable `String` to `DateTime` and passes the input as `DateTime` to the `next` validator.

### User Information validators

- `Validators.email()`: Checks if the field contains a valid email.
- `Validators.password()`: Checks if the field contains a valid password. A password may require some 
conditions to be met in order to be considered as valid.
- `Validators.phoneNumber()`: Checks if the field contains a valid phone number.

## Supported languages

Validators support default `errorText` messages in these languages:

- Albanian (al)
- Arabic (ar)
- Bangla (bn)
- Bosnian (bs)
- Bulgarian (bg)
- Catalan (ca)
- Chinese Simplified (zh_Hans)
- Chinese Traditional (zh_Hant)
- Croatian (hr)
- Czech (cs)
- Danish (da)
- Dutch (nl)
- English (en)
- Estonian (et)
- Finnish (fi)
- Farsi/Persian (fa)
- French (fr)
- German (de)
- Greek (el)
- Hebrew (he)
- Hungarian (hu)
- Hindi (hi)
- Indonesian (id)
- Italian (it)
- Japanese (ja)
- Kurdish (ku)
- Korean (ko)
- Khmer (km)
- Lao (lo)
- Latvian (lv)
- Malay (ms)
- Mongolian (mn)
- Norwegian (no)
- Polish (pl)
- Portuguese (pt)
- Romanian (ro)
- Russian (ru)
- Slovak (sk)
- Slovenian (sl)
- Spanish (es)
- Swahili (sw)
- Swedish (se)
- Tamil(ta)
- Thai (th)
- Turkish (tr)
- Ukrainian (uk)
- Vietnamese (vi)

And you can still add your custom error messages.

## Use

### Setup

The default error message is in English. To allow for localization of default error messages within your app, add `FormBuilderLocalizations.delegate` in the list of your app's `localizationsDelegates`. 

For example, in your `MaterialApp`:
```Dart
return MaterialApp(
    supportedLocales: [
        Locale('de'),
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('it'),
        ...
    ],
    localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate, // here
    ],
```

### Basic use

In the following example, we have a required field for the `Name` of the user:
```dart
TextFormField(
    decoration: InputDecoration(labelText: 'Name'),
    autovalidateMode: AutovalidateMode.always,
    validator: Validators.required(),
),
```

See [pub.dev example tab](https://pub.dev/packages/form_builder_validators/example) or [github code](example/lib/main.dart) for more details

### Specific uses

#### Composing multiple validators with the logical `AND` semantics

The `Validators` class comes with a handy static function named `and()`, which takes a list of `Validator` functions. Composing allows you to create once and reuse validation rules across multiple fields, widgets, or apps.

On validation, each validator is run, and if any validator returns a non-null value (i.e., a String), validation fails, and the `errorText` for the field is set as the first returned string or as a composition of all failures.

In the following example, we have a form field for the user's `Age`, which is **required**, must be **numeric** (with custom error message if not numeric given by *"La edad debe ser numérica."*), must be **less than 70**, and, finally, must be **non-negative** (with custom non-negative validator):
```Dart
TextFormField(
    decoration: InputDecoration(labelText: 'Age'),
    keyboardType: TextInputType.number,
    autovalidateMode: AutovalidateMode.always,
    validator: Validators.required(
      Validators.and(<Validator<String>>[
        Validators.num(Validators.lessThan(70), (_) => 'La edad debe ser numérica.'),

        /// Include your own custom `Validator` function, if you want.
        /// Ensures positive values only. We could also have used `Validators.greaterThanOrEqualTo(0)` instead.
        (String? val) {
            if (val != null) {
              final int? number = int.tryParse(val);
              // todo bug here: if it is not int, it accepts negative
              // numbers
              if (number == null) return null;
              if (number < 0) return 'We cannot have a negative age';
            }
            return null;
        }
      ]))
),
```

#### Modify the default error message in a specific language

see [override_form_builder_localizations_en](example/lib/override_form_builder_localizations_en.dart) for more detail.

## Migrations
### v11 to v12
- Deprecate `FormBuilderValidators` class with its static methods as validators.
- Instead, you should use `Validators` class.
- The next items of this section show how to convert from the old API functions to the closest equivalent using the new APIs. For each item, we try to show how the conversion is made from a validator with all its parameters being used, thus, if your case is simples, probably it will be enough to ignore the additional parameters in the example.
#### checkNullOrEmpty
Before specifying the equivalent to each validator, it is important to deal with the `checkNullOrEmpty` parameter. Every validator from the old API has this parameters, thus we are going to use this section to specify how to handle this situation for most of the cases and we will assume that this aspect is already handled for the following sections. 

The conditions are:
- `checkNullOrEmpty = true`: 
```dart
// Old API
FormBuilderValidators.someValidator(..., checkNullOrEmpty:true);

// New API
Validators.required(Validators.someEquivalentValidator(...));

```
- `checkNullOrEmpty = false`: 
```dart
// Old API
FormBuilderValidators.someValidator(..., checkNullOrEmpty:false);

// New API
Validators.optional(Validators.someEquivalentValidator(...));
```

#### Bool validators

For the following group of validators (`hasLowercaseChars`, `hasNumericChars`, `hasSpecialChars`, and `hasUppercaseChars`), it is expected to receive a `String` as user input. Thus, if your form widget does not guarantee a `String` input (e.g. it may receive an `Object`), you must wrap the equivalent validator with the type validator for strings (`Validators.string`). 
Apply the following logic to the next items:

```dart
// Replace "Something" with the actual name of the validator
// Old API - No type checking needed
FormBuilderValidators.hasMinSomethingChars(...);

// New API - With type checking
Validators.string(Validators.hasMinSomethingChars(...));
```

- `FormBuilderValidators.hasLowercaseChars`
```dart
// Old API
FormBuilderValidators.hasLowercaseChars(
  atLeast: 3,
  regex: RegExp(r'[a-z]'),
  errorText: 'Need at least 3 lowercase letters'
);

// New API equivalent
Validators.hasMinLowercaseChars(
  min: 3,
  customLowercaseCounter: (input) => RegExp(r'[a-z]').allMatches(input).length,
  hasMinLowercaseCharsMsg: (_, __) => 'Need at least 3 lowercase letters'
);
```

- `FormBuilderValidators.hasNumericChars`
```dart
// Old API
FormBuilderValidators.hasNumericChars(
  atLeast: 2,
  regex: RegExp(r'[0-9]'),
  errorText: 'Need at least 2 numbers'
);

// New API equivalent
Validators.hasMinNumericChars(
  min: 2,
  customNumericCounter: (input) => RegExp(r'[0-9]').allMatches(input).length,
  hasMinNumericCharsMsg: (_, __) => 'Need at least 2 numbers'
);
```

- `FormBuilderValidators.hasSpecialChars`
```dart
// Old API
FormBuilderValidators.hasSpecialChars(
  atLeast: 1,
  regex: RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
  errorText: 'Need at least 1 special character'
);

// New API equivalent
Validators.hasMinSpecialChars(
  min: 1,
  customSpecialCounter: (input) => RegExp(r'[!@#$%^&*(),.?":{}|<>]').allMatches(input).length,
  hasMinSpecialCharsMsg: (_, __) => 'Need at least 1 special character'
);
```

- `FormBuilderValidators.hasUppercaseChars`
```dart
// Old API
FormBuilderValidators.hasUppercaseChars(
  atLeast: 2,
  regex: RegExp(r'[A-Z]'),
  errorText: 'Need at least 2 uppercase letters'
);

// New API equivalent
Validators.hasMinUppercaseChars(
  min: 2,
  customUppercaseCounter: (input) => RegExp(r'[A-Z]').allMatches(input).length,
  hasMinUppercaseCharsMsg: (_, __) => 'Need at least 2 uppercase letters'
);
```
    
For the remaining `isFalse` and `isTrue`, it is not necessary to wrap them with `Validators.string` even if the form widget does not provide `String` input.


- `FormBuilderValidators.isFalse`
```dart
// Old API
FormBuilderValidators.isFalse(
  errorText: 'Value must be false'
);

// New API equivalent
Validators.isFalse(
  isFalseMsg: (_) => 'Value must be false'
);
```

- `FormBuilderValidators.isTrue`
```dart
// Old API
FormBuilderValidators.isTrue(
  errorText: 'Value must be true'
);

// New API equivalent
Validators.isTrue(
  isTrueMsg: (_) => 'Value must be true'
);
```

#### Collection validators
- `FormBuilderValidators.containsElement`
```dart
// Old API
FormBuilderValidators.containsElement(
  [v1, v2, v3],
  errorText: 'Value must be in the list'
);

// New API equivalent
Validators.inList(
  [v1, v2, v3],
  inListMsg: (_, __) => 'Value must be in the list'
);
```
- `FormBuilderValidators.equalLength`
  - The parameter `allowEmpty` was removed and [additional logic](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/collection/equal_length_validator.dart#L40) must be provided to handle the case in which this parameter is true. 

```dart
// Old API
FormBuilderValidators.equalLength(
  8,
  allowEmpty: false,
  errorText: 'Must be exactly 8 characters'
);

// New API equivalent
Validators.equalLength(
  8,
  equalLengthMsg: (_, __) => 'Must be exactly 8 characters'
);

// Note: The parameter `allowEmpty` was removed.
// To handle allowEmpty: true case, use something like:
Validators.or([
  Validators.equalLength(0),
  Validators.equalLength(8)
]);
```

- `FormBuilderValidators.maxLength`
```dart
// Old API
FormBuilderValidators.maxLength(
  50,
  errorText: 'Must be no more than 50 characters'
);

// New API equivalent
Validators.maxLength(
  50,
  maxLengthMsg: (_, __) => 'Must be no more than 50 characters'
);
```

- `FormBuilderValidators.minLength`
```dart
// Old API
FormBuilderValidators.minLength(
  8,
  errorText: 'Must be at least 8 characters'
);

// New API equivalent
Validators.minLength(
  8,
  minLengthMsg: (_, __) => 'Must be at least 8 characters'
);
```

- `FormBuilderValidators.range` (for collections)
```dart
// Old API (inclusive: true)
FormBuilderValidators.range(
  3,
  10,
  inclusive: true,
  errorText: 'Length must be between 3 and 10'
);

// New API equivalent
Validators.betweenLength(
  3,
  10,
  betweenLengthMsg: (_) => 'Length must be between 3 and 10'
);

/******************************************************************************/

// Old API (inclusive: false)
FormBuilderValidators.range(
  3,
  10,
  inclusive: false,
  errorText: 'Length must be between 4 and 9'
);

// New API equivalent
Validators.betweenLength(
  4,
  9,
  betweenLengthMsg: (_) => 'Length must be between 4 and 9'
);
```

- `FormBuilderValidators.range` (for numeric values)
```dart
// Old API
FormBuilderValidators.range(
  1,
  100,
  inclusive: true,
  errorText: 'Value must be between 1 and 100'
);

// New API equivalent
Validators.between(
  1,
  100,
  minInclusive: true,
  maxInclusive: true,
  betweenMsg: (_, __, ___, ____, _____) => 'Value must be between 1 and 100'
);
```
- `FormBuilderValidators.unique([v1, v2, v3], errorText:'some error')`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/collection/unique_validator.dart#L32), thus, a custom validator should be implemented.
  - Example: 

```dart
Validator<T> unique<T extends Object>(List<T> values, {String? errorText}){
  return (input){
    return values.where((element) => element == input).length > 1? errorText:null;
  };

}
```
        
### Core validators

- `FormBuilderValidators.aggregate`
```dart
// Old API
FormBuilderValidators.aggregate([
  validator1,
  validator2,
  validator3
]);

// New API equivalent
Validators.and(
  [validator1, validator2, validator3],
  separator: '\n',
  printErrorAsSoonAsPossible: false
);
```

- `FormBuilderValidators.compose`
```dart
// Old API
FormBuilderValidators.compose([
  validator1,
  validator2
]);

// New API equivalent
Validators.and([
  validator1,
  validator2
]);
```

- `FormBuilderValidators.conditional`
```dart
// Old API
FormBuilderValidators.conditional(
  (value) => value != null,
  validator
);

// New API equivalent
Validators.validateIf(
  (value) => value != null,
  validator
);
```

- `FormBuilderValidators.defaultValue`
```dart
// Old API
FormBuilderValidators.defaultValue(
  'Default',
  validator
);

// New API equivalent
Validators.validateWithDefault(
  'Default',
  validator
);
```

- `FormBuilderValidators.equal`
```dart
// Old API
FormBuilderValidators.equal(
  expectedValue,
  'Must match the expected value'
);

// New API equivalent
Validators.equal(
  expectedValue,
  equalMsg: (_, __) => 'Must match the expected value'
);
```

- `FormBuilderValidators.log`
```dart
// Old API
FormBuilderValidators.log(
  (value) => print('Validating: $value'),
  'Error message'
);

// New API equivalent
Validators.debugPrintValidator(
  (input) => print('Validating: $input') ?? 'Error message'
);
```

- `FormBuilderValidators.notEqual`
```dart
// Old API
FormBuilderValidators.notEqual(
  forbiddenValue,
  'Must not match the forbidden value'
);

// New API equivalent
Validators.notEqual(
  forbiddenValue,
  notEqualMsg: (_, __) => 'Must not match the forbidden value'
);
```

- `FormBuilderValidators.or`
```dart
// Old API
FormBuilderValidators.or([
  validator1,
  validator2
]);

// New API equivalent
Validators.or([
  validator1,
  validator2
]);
```

- `FormBuilderValidators.required`
```dart
// Old API
FormBuilderValidators.required(
  'This field is required'
);

// New API equivalent
Validators.required(
  null,
  'This field is required'
);
```

- `FormBuilderValidators.skipWhen`
```dart
// Old API
FormBuilderValidators.skipWhen(
  (value) => value == null,
  validator
);

// New API equivalent
Validators.skipIf(
  (value) => value == null,
  validator
);
```

- `FormBuilderValidators.transform`
```dart
// Old API
FormBuilderValidators.transform(
  (value) => value?.toString().trim(),
  validator
);

// New API equivalent
Validators.transformAndValidate(
  (value) => value?.toString().trim(),
  next: validator
);
```

### Datetime validators

- `FormBuilderValidators.dateFuture()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/datetime/date_future_validator.dart#L29), thus, a custom validator should be implemented.
  - Example: 

```dart
// Old API:
FormBuilderValidators.dateFuture(errorText: 'Date must be in the future');

// New API (closest):
Validators.dateTime(Validators.after(DateTime.now(), afterMsg: (_, __)=>'Date must be in the future'));

``` 

- `FormBuilderValidators.datePast()`:there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/datetime/date_past_validator.dart#L29), thus, a custom validator should be implemented.
  - Example: 

```dart
// Old API:
FormBuilderValidators.datePast(errorText: 'Date must be in the past');

// New API (closest):
Validators.dateTime(Validators.before(DateTime.now(), beforeMsg: (_, __)=>'Date must be in the past'));

``` 

- `FormBuilderValidators.dateRange()`

```dart
// Old API
FormBuilderValidators.dateRange(
  minDate,
  maxDate,
  errorText: 'Date must be between min and max dates'
);

// New API equivalent
Validators.dateTime(
  Validators.betweenDateTime(
    minDate,
    maxDate,
    betweenDateTimeMsg: (_, __, ___) => 'Date must be between min and max dates'
  ),
);
```

- `FormBuilderValidators.dateTime()`: this validator only checks if the input of type `DateTime?` is not null. Something close would be the following example: 

```dart
// Old API:
FormBuilderValidators.dateTime(errorText: 'Invalid date time');

// New API (close):
final errorText = 'Invalid date time';
Validators.required(Validators.dateTime(null, (_)=>errorText), errorText);
```

- `FormBuilderValidators.date()`
```dart
// Old API
FormBuilderValidators.date(errorText: 'Invalid date time');

// New API
Validators.dateTime(null, (_)=>'Invalid date time');
```
- `FormBuilderValidators.time()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/datetime/time_validator.dart#L48). But it is a combination of `Validators.dateTime` with `Validators.match` using some specific regex.

- `FormBuilderValidators.timeZone()`: there is no equivalent to [this validator](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/17e982bb849dc68365f8fbc93d5a2323ee891c89/lib/src/datetime/timezone_validator.dart#L75). 
Something close would be:
```dart
Validators.inList(validTimezones, inListMsg: (_, __)=> 'Invalid timezone')
```

### File validators

- `FormBuilderValidators.fileExtension()`
```dart
// Old API:
FormBuilderValidators.fileExtension(
  ['pdf', 'txt', 'png'],
  errorText: 'Invalid extension',
);

// New API:
Validators.matchesAllowedExtensions(
  // Actually, the extension is '.pdf' and not 'pdf'
  ['.pdf', '.txt', '.png'],
  matchesAllowedExtensionsMsg:(_)=>'Invalid extension',
  caseSensitive: false,
);
```
TODO continue from here!!!
- `FormBuilderValidators.fileName()` - requires the field's to be a valid file name.
- `FormBuilderValidators.fileSize()` - requires the field's to be less than the max size.
- `FormBuilderValidators.mimeType()` - requires the field's value to a valid MIME type.
- `FormBuilderValidators.path()` - requires the field's to be a valid file or folder path.

### Finance validators

- `FormBuilderValidators.bic()` - requires the field's to be a valid BIC.
- `FormBuilderValidators.creditCardCVC()` - requires the field's value to be a valid credit card CVC number.
- `FormBuilderValidators.creditCardExpirationDate()` - requires the field's value to be a valid credit card expiration date and can check if not expired yet.
- `FormBuilderValidators.creditCard()` - requires the field's value to be a valid credit card number.
- `FormBuilderValidators.iban()` - requires the field's to be a valid IBAN.

### Identity validators

- `FormBuilderValidators.city()` - requires the field's value to be a valid city name.
- `FormBuilderValidators.country()` - requires the field's value to be a valid country name.
- `FormBuilderValidators.firstName()` - requires the field's value to be a valid first name.
- `FormBuilderValidators.lastName()` - requires the field's value to be a valid last name.
- `FormBuilderValidators.passportNumber()` - requires the field's value to be a valid passport number.
- `FormBuilderValidators.password()` - requires the field's to be a valid password that matched required conditions.
- `FormBuilderValidators.ssn()` - requires the field's to be a valid SSN (Social Security Number).
- `FormBuilderValidators.state()` - requires the field's value to be a valid state name.
- `FormBuilderValidators.street()` - requires the field's value to be a valid street name.
- `FormBuilderValidators.username()` - requires the field's to be a valid username that matched required conditions.
- `FormBuilderValidators.zipCode()` - requires the field's to be a valid zip code.

### Network validators

- `FormBuilderValidators.email()` - requires the field's value to be a valid email address.
- `FormBuilderValidators.ip()` - requires the field's value to be a valid IP address.
- `FormBuilderValidators.latitude()` - requires the field's to be a valid latitude.
- `FormBuilderValidators.longitude()` - requires the field's to be a valid longitude.
- `FormBuilderValidators.macAddress()` - requires the field's to be a valid MAC address.
- `FormBuilderValidators.phoneNumber()` - requires the field's value to be a valid phone number.
- `FormBuilderValidators.portNumber()` - requires the field's to be a valid port number.
- `FormBuilderValidators.url()` - requires the field's value to be a valid URL.

### Numeric validators

- `FormBuilderValidators.between()` - requires the field's to be between two numbers.
- `FormBuilderValidators.evenNumber()` - requires the field's to be an even number.
- `FormBuilderValidators.integer()` - requires the field's value to be an integer.
- `FormBuilderValidators.max()` - requires the field's value to be less than or equal to the provided number.
- `FormBuilderValidators.min()` - requires the field's value to be greater than or equal to the provided number.
- `FormBuilderValidators.negativeNumber()` - requires the field's to be a negative number.
- `FormBuilderValidators.notZeroNumber()` - requires the field's to be not a number zero.
- `FormBuilderValidators.numeric()` - requires the field's value to be a valid number.
- `FormBuilderValidators.oddNumber()` - requires the field's to be an odd number.
- `FormBuilderValidators.positiveNumber()` - requires the field's to be a positive number.
- `FormBuilderValidators.prime()` - requires the field's to be a prime number.

### String validators

- `FormBuilderValidators.alphabetical()` - requires the field's to contain only alphabetical characters.
- `FormBuilderValidators.contains()` - requires the substring to be in the field's value.
- `FormBuilderValidators.endsWith()` - requires the substring to be the end of the field's value.
- `FormBuilderValidators.lowercase()` - requires the field's value to be lowercase.
- `FormBuilderValidators.matchNot()` - requires the field's value to not match the provided regex pattern.
- `FormBuilderValidators.match()` - requires the field's value to match the provided regex pattern.
- `FormBuilderValidators.maxWordsCount()` - requires the word count of the field's value to be less than or equal to the provided maximum count.
- `FormBuilderValidators.minWordsCount()` - requires the word count of the field's value to be greater than or equal to the provided minimum count.
- `FormBuilderValidators.singleLine()` - requires the field's string to be a single line of text.
- `FormBuilderValidators.startsWith()` - requires the substring to be the start of the field's value.
- `FormBuilderValidators.uppercase()` - requires the field's value to be uppercase.

### Use-case validators

- `FormBuilderValidators.base64()` - requires the field's to be a valid base64 string.
- `FormBuilderValidators.colorCode()` - requires the field's value to be a valid color code.
- `FormBuilderValidators.duns()` - requires the field's value to be a valid DUNS.
- `FormBuilderValidators.isbn()` - requires the field's to be a valid ISBN.
- `FormBuilderValidators.json()` - requires the field's to be a valid json string.
- `FormBuilderValidators.languageCode()` - requires the field's to be a valid language code.
- `FormBuilderValidators.licensePlate()` - requires the field's to be a valid license plate.
- `FormBuilderValidators.uuid()` - requires the field's to be a valid uuid.
- `FormBuilderValidators.vin()` - requires the field's to be a valid VIN number.

### Extension method validators

Used for chaining and combining multiple validators.

- `FormBuilderValidator.and()` - Combines the current validator with another validator using logical AND.
- `FormBuilderValidator.or()` - Combines the current validator with another validator using logical OR.
- `FormBuilderValidator.when()` - Adds a condition to apply the validator only if the condition is met.
- `FormBuilderValidator.unless()` - Adds a condition to apply the validator only if the condition is not met.
- `FormBuilderValidator.transform()` - Transforms the value before applying the validator.
- `FormBuilderValidator.skipWhen()` - Skips the validator if the condition is met.
- `FormBuilderValidator.log()` - Logs the value during the validation process.
- `FormBuilderValidator.withErrorMessage()` - Overrides the error message of the current validator.

### v10 to v11

- All validators now first check for null or empty value and return an error if so. You can set `checkNullOrEmpty` to `false` if you want to avoid this behavior.
- `dateString()` changed to `date()` for constancy in api naming. Simply change the name to fix the code.
- The positional parameter for the validator  [`match()`](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/93d6fb230c706a6415a3a85973fc37fabbd82588/lib/src/form_builder_validators.dart#L1433) is not a `String` pattern anymore, but a `RegExp` regex.

### v7 to v8

Remove `context` as a parameter to validator functions. For example, `FormBuilderValidators.required(context)` becomes `FormBuilderValidators.required()` without `context` passed in.

## How this package works
This package comes with several most common `Validator`s and `FormFieldValidator`s such as required, numeric, mail,
URL, min, max, minLength, maxLength, minWordsCount, maxWordsCount, IP, credit card, etc., with default `errorText` messages.

- But what is a `FormFieldValidator`?
  It is a function that takes user input of any nullable type and returns either null (for valid input) or
  an error message string (for invalid input). The input parameter can be `String?`, `int?`, `num?`, or any
  other nullable type that represents user-provided data. The input must be nullable since form fields may
  be empty, resulting in null values.

For example, here's a `FormFieldValidator` that checks if a number is even:
```dart
String? isEven(int? userInput) {
  return (userInput != null && userInput % 2 == 0) ? null : 'This field must be even';
}
```
The challenge with the previous approach is that we must handle null checks in every validator
implementation. This leads to:
    1. Tangled validator logic: Each validator must handle both validation rules and null checking,making the code harder to understand and maintain.
    2. Code duplication: When composing validators, the same null-checking logic must be repeated across multiple validators, violating the DRY principle.
    3. Poor separation of concerns: A validator named `isEven` should focus solely on checking if a number is even. It shouldn't need to handle null cases or type validation - those are separate responsibilities that deserve their own focused validators.
    4. Verbose implementations: The combination of null checks, type validation, and business logic in each validator results in unnecessarily lengthy code that's harder to test and maintain.
    5. Potential problems with null safety: imagine an unsafe version of isEven that simply uses the `!` operator to throw an error during runtime if the user input is null:
```dart
/// `userInput` may not be null.
String? isEven(int? userInput) {
  return (userInput! % 2 == 0) ? null : 'This field must be even';
}
```

This package introduces a more precise approach that separates null-value handling from the actual
validation logic. Instead of the previous isEven implementation, we can compose two focused validators:

```dart
String? Function(int) isEven(){ 
  return (int userInput){
    return (userInput % 2 == 0) ? null:'This field must be even';
  };
}

String? Function(int?) required(String? Function(int) next){
  return (int? userInput) {
    return (userInput != null) ? next(userInput):'This field is required';
  };
}

// Important: isEven() does not return a FormFieldValidator, but the composition required(isEven()), does.
final validator = required(isEven());
```

By introducing this level of indirection, we achieve:
    1. Clean separation between null checks and validation logic
    2. More composable validators
    3. Specific error messages for missing vs invalid input
    4. Type-safe validator chains

## Support

### Contribute

You have some ways to contribute to this package.

- Beginner: Reporting bugs or requesting new features
- Intermediate: Answer questions, implement new features (from issues or not), and create pull requests
- Advanced: Join [organization](#ecosystem) like a member and help to code, manage issues, discuss new features, and other things

See the [contribution file](https://github.com/flutter-form-builder-ecosystem/.github/blob/main/CONTRIBUTING.md) for more details

#### Add new supported language

We welcome efforts to internationalize/localize the package by translating the default validation `errorText` strings for built-in validation rules.

1. Add ARB files

   Create one ARB file inside the `lib/l10n` folder for each locale you need to add support. Name the files in the following way: `intl_<LOCALE_ISO_CODE>.arb`. For example: `intl_fr.arb` or `intl_fr_FR.arb`.

2. Translate the error messages

   Copy and paste the contents of `intl_en.arb` into your newly created ARB file. Then translate the error messages by overwriting the default messages.

3. Generate localization code

   To generate boilerplate code for localization, run the generate command inside the package directory where `pubspec.yaml` file is located:

   `flutter gen-l10n`

   The command will automatically create/update files inside the `lib/localization` directory, including your newly added locale support. The files in here are only necessary for local development and will not be committed to Github.

4. Update README

   Remember to update README, adding the new language (and language code) under [Supported languages section](#supported-languages) in alphabetic order, so that everyone knows your new language is now supported!

5. Submit PR

   Submit your PR and be of help to millions of developers all over the world!

#### Add new validator

1. Add a new validator to one of the folders in the `src/validators` folder.
2. Implement it as a function which returns `Validator<T>` with `T` being the type of
the user input to be validated.
3. Add the @macro tag for documentation using the template name: `validator_<validator_snake_case_name>`.
This will refer to the actual documentation, which will be on the `Validators` static method.
4. If your validator uses localized error message, you can use `FormBuilderLocalizations.current.<name_of_localized_message>`
Next we have the example of the numeric validator `greaterThan`. As we can see, it has its `@macro` docstring, it uses a
localized error message (`FormBuilderLocalizations.current.greaterThanErrorText(reference)`) and it returns
`Validator<T extends num>`:
    ```dart
    /// {@macro validator_greater_than}
    Validator<T> greaterThan<T extends num>(T reference,
        {String Function(T input, T reference)? greaterThanMsg}) {
      return (T input) {
        return input > reference
            ? null
            : greaterThanMsg?.call(input, reference) ??
            FormBuilderLocalizations.current.greaterThanErrorText(reference);
      };
    }
    ```
5. Add the validator as static method to `form_builder_validators.dart` in the `Validators` class. Do
not forget to add documentation to the new static method, using the `@template` element to give a name
to the docstring. Follow the pattern: `validator_<validator_snake_case_name>`.
Here, an example of how to add the static method of the validator to the `Validators` class:
    ```dart
    final class Validators{
      //Other validators...

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
    } 
    // OBS.: the core package is imported with prefix c to avoid name collision!
    ```
6. Implement tests
7. Add to [validators](#validators) with name and description
8. Add message error translated on all languages (yes, all languages). To accomplish this need:
   a. Add property to all `intl_*.arb` files, in alphabetic order.
   b. Translate message in all languages.
   c. Run `flutter gen-l10n` command
9. Run dart `dart fix --apply` and `dart format .`
10. Submit PR

### Questions and answers

You can ask questions or search for answers on [Github discussion](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/discussions) or on [StackOverflow](https://stackoverflow.com/questions/tagged/flutter-form-builder)

### Donations

Donate or become a sponsor of Flutter Form Builder Ecosystem

[![Become a Sponsor](https://opencollective.com/flutter-form-builder-ecosystem/tiers/sponsor.svg?avatarHeight=56)](https://opencollective.com/flutter-form-builder-ecosystem)

## Roadmap

- [API refactor to improve performance and behavior](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/pull/129)
- [Solve open issues](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/issues), [prioritizing bugs](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/labels/bug)

## Ecosystem

Take a look at [our fantastic ecosystem](https://github.com/flutter-form-builder-ecosystem) and all packages in there

## Thanks to

[All contributors](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/graphs/contributors)


