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
1. Required validators: makes a field optional or required.
2. Type validators: checks the type of the field.
3. Other validators: makes other types of checking.

Generally, we build a validator composing those three types in the following way:
<requiredValidator>(<typeValidator>(<otherValidator>()))



### Collection validators

- `Validators.equalLength(expectedLength)`: Checks if the field contains a collection (must be a `String`, `Iterable`, or `Map`) with length equals `expectedLength`.
- `Validators.minLength(min)`: Checks if the field contains a collection (must be a `String`, `Iterable`, or `Map`) with length greater than or equal to `min`.
- `Validators.maxLength(max)`: Checks if the field contains a collection (must be a `String`, `Iterable`, or `Map`) with length less than or equal to `max`.
- `Validators.betweenLength(min, max)`: Checks if the field contains a collection (must be a `String`, `Iterable`, or `Map`) with length between `min` and `max`, inclusive.

### Core validators

#### Composition validators

- `Validators.and(validators)`: Validates the field by requiring it to pass all validators in the provided list of validators: `validators`.
- `Validators.or(validators)`: Validates the field by requiring it to pass at least one of the validators in the provided list of validators: `validators`.
 
#### Conditional validators

- `Validators.validateIf(condition, v)`: Validates the field with validator `v` only if `condition` is `true`.
- `Validators.skipIf(condition, v)`: Validates the field with validator `v` only if `condition` is `false`.

#### Debug print validator
- `Validators.debugPrintValidator()`: Print, for debug purposes, the user input value.
 
#### Equality validators

TODO remove every verb `is` from the name of the validators. 
- `Validators.isEqual(value)`: Checks if the field contains an input that is equal to `value` (==).
- `Validators.isNotEqual(value)`: Checks if the field contains an input that is not equal to `value` (!=).
 
#### Required validators

- `Validators.isRequired(next)`: Makes the field required by checking if it contains a non-null and non-empty value, passing it to the `next` validator as a not-nullable type.
- `Validators.isOptional(next)`: Makes the field optional by passing it to the `next` validator if it contains a non-null and non-empty value. If the field is null or empty, null is returned.
- `Validators.validateWithDefault(defaultValue, next)`: Validates the field with `next` validator. If the input is null, it uses the `defaultValue` instead.

#### Transform validators

- `Validators.transformAndValidate<IN, OUT>(transformFunction, next:next)`: Transforms an input from `IN` type to `OUT` type through the function `transformFunction` and pass it to the `next` validator.

### Datetime validators

- `Validators.isAfter(reference)`: Checks if the field contains a `DateTime` that is after `reference`.
- `Validators.isBefore(reference)`: Checks if the field contains a `DateTime` that is before `reference`.
TODO replace isDateTimeBetween with betweenDateTime
- `Validators.isDateTimeBetween(minReference, maxReference)`: Checks if the field contains a `DateTime` that is after `minReference` and before `maxReference`.
- TODO `FormBuilderValidators.date()` - requires the field's value to be a valid date string.
- TODO `FormBuilderValidators.time()` - requires the field's value to be a valid time string.
- TODO `FormBuilderValidators.timeZone()` - requires the field's value to be a valid time zone.

### File validators

- TODO `FormBuilderValidators.fileExtension()` - requires the field's value to a valid file extension.
- TODO `FormBuilderValidators.fileName()` - requires the field's to be a valid file name.
- TODO `FormBuilderValidators.fileSize()` - requires the field's to be less than the max size.
- TODO `FormBuilderValidators.mimeType()` - requires the field's value to a valid MIME type.
- TODO `FormBuilderValidators.path()` - requires the field's to be a valid file or folder path.

### Finance validators

- TODO `FormBuilderValidators.bic()` - requires the field's to be a valid BIC.
- TODO `FormBuilderValidators.creditCardCVC()` - requires the field's value to be a valid credit card CVC number.
- TODO `FormBuilderValidators.creditCardExpirationDate()` - requires the field's value to be a valid credit card expiration date and can check if not expired yet.
- `Validators.creditCard()`: Checks if the field contains a valid credit card number.
- TODO `FormBuilderValidators.iban()` - requires the field's to be a valid IBAN.

### Generic Type Validators
Validators that check a generic type user input.

- `Validators.isInList(values)`: Checks if the field contains a value that is in the list `values`.
- `Validators.isTrue()`: Checks if the field contains a boolean or a parsable `String` of the `true` value.
- `Validators.isFalse()`: Checks if the field contains a boolean or a parsable `String` of the `false` value.

### Miscellaneous validators

- TODO `FormBuilderValidators.base64()` - requires the field's to be a valid base64 string.
- TODO `FormBuilderValidators.colorCode()` - requires the field's value to be a valid color code.
- TODO `FormBuilderValidators.duns()` - requires the field's value to be a valid DUNS.
- TODO `FormBuilderValidators.isbn()` - requires the field's to be a valid ISBN.
- TODO `FormBuilderValidators.json()` - requires the field's to be a valid json string.
- TODO `FormBuilderValidators.languageCode()` - requires the field's to be a valid language code.
- TODO `FormBuilderValidators.licensePlate()` - requires the field's to be a valid license plate.
- TODO `FormBuilderValidators.vin()` - requires the field's to be a valid VIN number.
 
### Network validators

- `Validators.ip()`: Checks if the field contains a properly formatted `Internet Protocol` (IP) address.
- `Validators.url()`: Checks if the field contains a properly formatted `Uniform Resource Locators` (URL).
- TODO `FormBuilderValidators.email()` - requires the field's value to be a valid email address.
- TODO `FormBuilderValidators.latitude()` - requires the field's to be a valid latitude. - `FormBuilderValidators.longitude()` - requires the field's to be a valid longitude.
- TODO `FormBuilderValidators.macAddress()` - requires the field's to be a valid MAC address.
- TODO `FormBuilderValidators.phoneNumber()` - requires the field's value to be a valid phone number.
- TODO `FormBuilderValidators.portNumber()` - requires the field's to be a valid port number.

### Numeric validators

- `Validators.between(min, max)`: Checks if the field contains a number that is in the range [min, max].
- `Validators.greaterThan(reference)`: Checks if the field contains a number that is greater than `reference`.
- `Validators.greaterThanOrEqualTo(reference)`: Checks if the field contains a number that is greater than or equal to `reference`.
- `Validators.lessThan(reference)`: Checks if the field contains a number that is less than `reference`.
- `Validators.lessThanOrEqualTo(reference)`: Checks if the field contains a number that is less than or equal to `reference`.
- TODO `FormBuilderValidators.evenNumber()` - requires the field's to be an even number.
- TODO `FormBuilderValidators.negativeNumber()` - requires the field's to be a negative number.
- TODO `FormBuilderValidators.notZeroNumber()` - requires the field's to be not a number zero.
- TODO `FormBuilderValidators.oddNumber()` - requires the field's to be an odd number.
- TODO `FormBuilderValidators.positiveNumber()` - requires the field's to be a positive number.
- TODO `FormBuilderValidators.prime()` - requires the field's to be a prime number.

### Path Validators
- `Validators.matchesAllowedExtensions(extensions)`: Checks if the field contains a `String` that is in the list `extensions`.

### String validators

- `Validators.contains(substring)` - Checks if the field contains the `substring`.
- TODO `FormBuilderValidators.endsWith()` - requires the substring to be the end of the field's value.
- TODO `FormBuilderValidators.startsWith()` - requires the substring to be the start of the field's value.
- TODO `FormBuilderValidators.lowercase()` - requires the field's value to be lowercase.
- TODO `FormBuilderValidators.uppercase()` - requires the field's value to be uppercase.
- `Validators.hasMinUppercaseChars(min:min)` - Checks if the field has a minimum number of uppercase chars.
- `Validators.hasMinLowercaseChars(min:min)` - Checks if the field has a minimum number of lowercase chars.
- `Validators.hasMinNumericChars(min:min)` - Checks if the field has a minimum number of numeric chars.
- `Validators.hasMinSpecialChars(min:min)` - Checks if the field has a minimum number of special chars.
- `Validators.match(regExp)` - Checks if the field matches with the regular expression `regExp`.
- TODO `FormBuilderValidators.matchNot()` - requires the field's value to not match the provided regex pattern.
- `Validators.uuid()` - Checks if the field is a valid Universally Unique Identifier (UUID).
- TODO `FormBuilderValidators.alphabetical()` - requires the field's to contain only alphabetical characters.
- TODO `FormBuilderValidators.maxWordsCount()` - requires the word count of the field's value to be less than or equal to the provided maximum count.
- TODO `FormBuilderValidators.minWordsCount()` - requires the word count of the field's value to be greater than or equal to the provided minimum count.
- TODO `FormBuilderValidators.singleLine()` - requires the field's string to be a single line of text.

### Type Validators
- `Validators.isString(next)`: Checks if the field contains a valid `String` and passes the input as `String` to the `next` validator.
- `Validators.isInt(next)`: Checks if the field contains a valid `int` or parsable `String` to `int` and passes the input as `int` to the `next` validator.
- `Validators.isDouble(next)`: Checks if the field contains a valid `double` or parsable `String` to `double` and passes the input as `double` to the `next` validator.
- `Validators.isNum(next)`: Checks if the field contains a valid `num` or parsable `String` to `num` and passes the input as `num` to the `next` validator.
- `Validators.isBool(next)`: Checks if the field contains a valid `bool` or parsable `String` to `bool` and passes the input as `bool` to the `next` validator.
- `Validators.isDateTime(next)`: Checks if the field contains a valid `DateTime` or parsable `String` to `DateTime` and passes the input as `DateTime` to the `next` validator.

### User Information validators

- `Validators.email()`: Checks if the field contains a valid email.
- `Validators.password()`: Checks if the field contains a valid password. A password may require some 
conditions to be met in order to be considered as valid.
- `Validators.phoneNumber()`: Checks if the field contains a valid phone number.
- TODO `FormBuilderValidators.city()` - requires the field's value to be a valid city name.
- TODO `FormBuilderValidators.country()` - requires the field's value to be a valid country name.
- TODO `FormBuilderValidators.firstName()` - requires the field's value to be a valid first name.
- TODO `FormBuilderValidators.lastName()` - requires the field's value to be a valid last name.
- TODO `FormBuilderValidators.passportNumber()` - requires the field's value to be a valid passport number.
- TODO `FormBuilderValidators.ssn()` - requires the field's to be a valid SSN (Social Security Number).
- TODO `FormBuilderValidators.state()` - requires the field's value to be a valid state name.
- TODO `FormBuilderValidators.street()` - requires the field's value to be a valid street name.
- TODO `FormBuilderValidators.username()` - requires the field's to be a valid username that matched required conditions.
- TODO `FormBuilderValidators.zipCode()` - requires the field's to be a valid zip code.

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
        FormBuilderLocalizations.delegate,
    ],
```

### Basic use

```dart
TextFormField(
    decoration: InputDecoration(labelText: 'Name'),
    autovalidateMode: AutovalidateMode.always,
    validator: Validators.isRequired(),
),
```

See [pub.dev example tab](https://pub.dev/packages/form_builder_validators/example) or [github code](example/lib/main.dart) for more details

### Specific uses

#### Composing multiple validators

The `FormBuilderValidators` class comes with a handy static function named `compose()`, which takes a list of `FormFieldValidator` functions. Composing allows you to create once and reuse validation rules across multiple fields, widgets, or apps.

On validation, each validator is run, and if any validator returns a non-null value (i.e., a String), validation fails, and the `errorText` for the field is set as the returned string.

Example:

TODO update this example (checkpoint)
```Dart
TextFormField(
    decoration: InputDecoration(labelText: 'Age'),
    keyboardType: TextInputType.number,
    autovalidateMode: AutovalidateMode.always,
    validator: FormBuilderValidators.compose([
        /// Makes this field required
        FormBuilderValidators.required(),

        /// Ensures the value entered is numeric - with a custom error message
        FormBuilderValidators.numeric(errorText: 'La edad debe ser numérica.'),

        /// Sets a maximum value of 70
        FormBuilderValidators.max(70),

        /// Include your own custom `FormFieldValidator` function, if you want
        /// Ensures positive values only. We could also have used `FormBuilderValidators.min(0)` instead
        (val) {
            final number = int.tryParse(val);
            if (number == null) return null;
            if (number < 0) return 'We cannot have a negative age';
            return null;
        },
    ]),
),
```

#### Modify the default error message in a specific language

see [override_form_builder_localizations_en](example/lib/override_form_builder_localizations_en.dart) for more detail.

## Migrations

### v10 to v11

- All validators now first check for null or empty value and return an error if so. You can set `checkNullOrEmpty` to `false` if you want to avoid this behavior.
- `dateString()` changed to `date()` for constancy in api naming. Simply change the name to fix the code.
- The positional parameter for the validator  [`match()`](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/blob/93d6fb230c706a6415a3a85973fc37fabbd82588/lib/src/form_builder_validators.dart#L1433) is not a `String` pattern anymore, but a `RegExp` regex.

### v7 to v8

Remove `context` as a parameter to validator functions. For example, `FormBuilderValidators.required(context)` becomes `FormBuilderValidators.required()` without `context` passed in.

## How this package works
This package comes with several most common `FormFieldValidator`s such as required, numeric, mail,
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
    1. Tangled validator logic: Each validator must handle both validation rules and null checking,
       making the code harder to understand and maintain.
    1. Code duplication: When composing validators, the same null-checking logic must be repeated
       across multiple validators, violating the DRY principle.
    1. Poor separation of concerns: A validator named `isEven` should focus solely on checking if a
       number is even. It shouldn't need to handle null cases or type validation - those are separate
       responsibilities that deserve their own focused validators.
    1. Verbose implementations: The combination of null checks, type validation, and business logic
       in each validator results in unnecessarily lengthy code that's harder to test and maintain.
    1. Potential problems with null safety: imagine an unsafe version of isEven that simply uses
       the `!` operator to throw an error during runtime if the user input is null:
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

String? Function(int?) isRequired(String? Function(int) next){
  return (int? userInput) {
    return (userInput != null) ? next(userInput):'This field is required';
  };
}

// Important: isEven() does not return a FormFieldValidator, but the composition isRequired(isEven()), does.
final validator = isRequired(isEven());
```

By introducing this level of indirection, we achieve:
    1. Clean separation between null checks and validation logic
    1. More composable validators
    1. Specific error messages for missing vs invalid input
    1. Type-safe validator chains

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

1. Add a new validator to one of the folders in the `src` folder.
2. Implement it using the `BaseValidator` or `TranslatedValidator` class. Override the `validateValue` method and let the base class handle the null check in the `validate` method.
3. When using a `TranslatedValidator, Override the `translatedErrorText` property and return the correct translation from `FormBuilderLocalizations.current.`.
4. Make sure to pass `errorText` and `checkNullOrEmpty` to the base class.
5. Add static method to `form_builder_validators.dart` that uses the new validator.
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


