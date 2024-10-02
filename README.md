# Form Builder Validators

Form Builder Validators set of validators for any `FormField` widget or widgets that extend the `FormField` class - _e.g._, `TextFormField`, `DropdownFormField`, _et cetera_. It provides standard ready-made validation rules and a way to compose new validation rules combining multiple rules, including custom ones.

Also included is the `l10n` / `i18n` of error text messages to multiple languages.

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
  - [Bool validators](#bool-validators)
  - [Collection validators](#collection-validators)
  - [Core validators](#core-validators)
  - [Datetime validators](#datetime-validators)
  - [File validators](#file-validators)
  - [Finance validators](#finance-validators)
  - [Identity validators](#identity-validators)
  - [Network validators](#network-validators)
  - [Numeric validators](#numeric-validators)
  - [String validators](#string-validators)
  - [Use-case validators](#use-case-validators)
  - [Extension method validators](#extension-method-validators)
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

This package comes with several most common `FormFieldValidator`s such as required, numeric, mail,
URL, min, max, minLength, maxLength, minWordsCount, maxWordsCount, IP, credit card, etc., with default `errorText` messages.

### Bool validators

- `FormBuilderValidators.hasLowercaseChars()` - requires the field's to contain a specified number of lowercase characters.
- `FormBuilderValidators.hasNumericChars()` - requires the field's to contain a specified number of numeric characters.
- `FormBuilderValidators.hasSpecialChars()` - requires the field's to contain a specified number of special characters.
- `FormBuilderValidators.hasUppercaseChars()` - requires the field's to contain a specified number of uppercase characters.
- `FormBuilderValidators.isFalse()` - requires the field's to be false.
- `FormBuilderValidators.isTrue()` - requires the field's to be true.

### Collection validators

- `FormBuilderValidators.containsElement()` - requires the field's to be in the provided list.
- `FormBuilderValidators.equalLength()` - requires the length of the field's value to be equal to the provided minimum length.
- `FormBuilderValidators.maxLength()` - requires the length of the field's value to be less than or equal to the provided maximum size.
- `FormBuilderValidators.minLength()` - requires the length of the field's value to be greater than or equal to the provided minimum length.
- `FormBuilderValidators.range()` - requires the field's to be within a range.
- `FormBuilderValidators.unique()` - requires the field's to be unique in the provided list.

### Core validators

- `FormBuilderValidators.aggregate()` - runs the validators in parallel, collecting all errors.
- `FormBuilderValidators.compose()` - runs each validator against the value provided.
- `FormBuilderValidators.conditional()` - conditionally runs a validator against the value provided.
- `FormBuilderValidators.defaultValue()` - runs the validator using the default value when the provided value is null.
- `FormBuilderValidators.equal()` - requires the field's value to be equal to the provided object.
- `FormBuilderValidators.log()` - runs the validator and logs the value at a specific point in the validation chain.
- `FormBuilderValidators.notEqual()` - requires the field's value to be not equal to the provided object.
- `FormBuilderValidators.or()` - runs each validator against the value provided and passes when any works.
- `FormBuilderValidators.required()` - requires the field to have a non-empty value.
- `FormBuilderValidators.skipWhen()` - runs the validator and skips the validation when a certain condition is met.
- `FormBuilderValidators.transform()` - transforms the value before running the validator.

### Datetime validators

- `FormBuilderValidators.dateFuture()` - requires the field's value to be in the future.
- `FormBuilderValidators.datePast()` - requires the field's value to be a in the past.
- `FormBuilderValidators.dateRange()` - requires the field's value to be a within a date range.
- `FormBuilderValidators.dateTime()` - requires the field's value to be a valid date time.
- `FormBuilderValidators.date()` - requires the field's value to be a valid date string.
- `FormBuilderValidators.time()` - requires the field's value to be a valid time string.
- `FormBuilderValidators.timeZone()` - requires the field's value to be a valid time zone.

### File validators

- `FormBuilderValidators.fileExtension()` - requires the field's value to a valid file extension.
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

```Dart
TextFormField(
    decoration: InputDecoration(labelText: 'Name'),
    autovalidateMode: AutovalidateMode.always,
    validator: FormBuilderValidators.required(),
),
```

See [pub.dev example tab](https://pub.dev/packages/form_builder_validators/example) or [github code](example/lib/main.dart) for more details

### Specific uses

#### Composing multiple validators

The `FormBuilderValidators` class comes with a handy static function named `compose()`, which takes a list of `FormFieldValidator` functions. Composing allows you to create once and reuse validation rules across multiple fields, widgets, or apps.

On validation, each validator is run, and if any validator returns a non-null value (i.e., a String), validation fails, and the `errorText` for the field is set as the returned string.

Example:

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

- [Solve open issues](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/issues), [prioritizing bugs](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/labels/bug)

## Ecosystem

Take a look at [our fantastic ecosystem](https://github.com/flutter-form-builder-ecosystem) and all packages in there

## Thanks to

[All contributors](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/graphs/contributors)
