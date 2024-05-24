# Form Builder Validators

Form Builder Validators set of validators for any `FormField` widget or widgets that extend the `FormField` class - *e.g.*, `TextFormField`, `DropdownFormField`, *et cetera*. It provides standard ready-made validation rules and a way to compose new validation rules combining multiple rules, including custom ones.

Also included is the `l10n` / `i18n` of error text messages to multiple languages.

[![Pub Version](https://img.shields.io/pub/v/form_builder_validators?logo=flutter&style=for-the-badge)](https://pub.dev/packages/form_builder_validators)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/flutter-form-builder-ecosystem/form_builder_validators/base.yaml?branch=main&logo=github&style=for-the-badge)](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/actions/workflows/base.yaml)
[![Codecov](https://img.shields.io/codecov/c/github/flutter-form-builder-ecosystem/form_builder_validators?logo=codecov&style=for-the-badge)](https://codecov.io/gh/flutter-form-builder-ecosystem/form_builder_validators/)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/flutter-form-builder-ecosystem/form_builder_validators?logo=codefactor&style=for-the-badge)](https://www.codefactor.io/repository/github/flutter-form-builder-ecosystem/form_builder_validators)
---

> ## Migrating from version 7 to 8
>
> To migrate from v7 to v8, remove `context` as a parameter to validator functions. For example, `FormBuilderValidators.required(context)` becomes `FormBuilderValidators.required()` without `context` passed in.

## Contents

- [Features](#features)
- [Validators](#validators)
    - [Supported languages](#supported-languages)
- [Use](#use)
    - [Setup](#setup)
    - [Basic use](#basic-use)
    - [Specific uses](#specific-uses)
        - [Composing multiple validators](#composing-multiple-validators)
        - [Modify the default error message in a specific language](#modify-the-default-error-message-in-a-specific-language)
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

Available built-in validators include:

- `FormBuilderValidators.creditCard()` - requires the field's value to be a valid credit card number.
- `FormBuilderValidators.date()` - requires the field's value to be a valid date string.
- `FormBuilderValidators.email()` - requires the field's value to be a valid email address.
- `FormBuilderValidators.equal()` - requires the field's value to be equal to the provided object.
- `FormBuilderValidators.integer()` - requires the field's value to be an integer.
- `FormBuilderValidators.ip()` - requires the field's value to be a valid IP address.
- `FormBuilderValidators.match()` - requires the field's value to match the provided regex pattern.
- `FormBuilderValidators.notMatch()` - requires the field's value to not match the provided regex pattern.
- `FormBuilderValidators.max()` - requires the field's value to be less than or equal to the provided number.
- `FormBuilderValidators.maxLength()` - requires the length of the field's value to be less than or equal to the provided maximum size.
- `FormBuilderValidators.maxWordsCount()` - requires the word count of the field's value to be less than or equal to the provided maximum count.
- `FormBuilderValidators.min()` - requires the field's value to be greater than or equal to the provided number.
- `FormBuilderValidators.minLength()` - requires the length of the field's value to be greater than or equal to the provided minimum length.
- `FormBuilderValidators.minWordsCount()` - requires the word count of the field's value to be greater than or equal to the provided minimum count.
- `FormBuilderValidators.equalLength()` - requires the length of the field's value to be equal to the provided minimum length.
- `FormBuilderValidators.numeric()` - requires the field's value to be a valid number.
- `FormBuilderValidators.required()` - requires the field to have a non-empty value.
- `FormBuilderValidators.url()` - requires the field's value to be a valid URL.

### Supported languages

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
- Indonesian (id)
- Italian (it)
- Japanese (ja)
- Korean (ko)
- Lao (lo)
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

1. Add method to `validators.dart` with your Dart documentation
2. Implement tests
3. Add to [validators](#validators) with name and description
4. Add message error translated on all languages (yes, all languages). To accomplish this need:
   a. Add property to all `intl_*.arb` files, in alphabetic order.
   b. Translate message in all languages.
   c. Run `flutter gen-l10n` command
5. Submit PR

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
