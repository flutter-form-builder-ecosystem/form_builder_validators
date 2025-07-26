# Changelog

## 12.0.0
- Deprecated `FormBuilderValidators` class with its static methods as validators.
- Created a new API for the validators.
  - Removed the `checkNullOrEmpty` parameter.
  - Restructured validators (maintained some intact, removed others, split some into elementary ones)
  - Decoupled null check and type check from the remaining validators.

## 11.2.0

- Fix password validator when not showing default error message
- Upgrade intl to 0.20.0
- Update constraints to Dart 3.8
- Update constraints to Flutter 3.32
- Add linux setup on example

## 11.1.2

- Update intl constraints to allow versions until 0.21.0

## 11.1.1

- Fix issue when build fails due to missing l10n files

## 11.1.0

- Add Latvian language support
- Add float validator
- Add hexadecimal validator
- Align between validator input types with other validators
- Split up BaseValidator into TranslatedValidator so only that one needs to provide a translation
- Update constraints to min Dart 3.6
- Update constraints to min Flutter 3.27.0

## 11.0.0

- Split up validators into smaller pieces
- Use a BaseValidator for all validators
- Add optional check (default: true) for null value on every validator
- When using a Regex it is now possible to provide your own
- Re-land generated l10n files
- Add Bulgarian

### Breaking changes

- See Readme: <https://github.com/flutter-form-builder-ecosystem/form_builder_validators?tab=readme-ov-file#v10-to-v11>

### New validators

- Add creditCardExpirationDate
- Add creditCardCVC
- Add colorCode
- Add phoneNumber
- Add uppercase
- Add lowercase
- Add file extension
- Add max file size
- Add notMatch
- Add range
- Add dateTime
- Add date range
- Add time
- Add is true
- Add is false
- Add special characters
- Add numeric characters
- Add lowercase characters
- Add uppercase characters
- Add password
- Add alphabetical
- Add uuid
- Add json
- Add latitude
- Add longitude
- Add base64
- Add path
- Add port number
- Add mac address
- Add startWith
- Add endWith
- Add contains
- Add between
- Add containsElement
- Add transform
- Add IBAN
- Add BIC
- Add skipWhen
- Add log
- Add aggregate
- Add unique
- Add ISBN
- Add singleLine
- Add defaultValue
- Add datePast
- Add dateFuture
- Add SSN (Social Security Number (USA))
- Add fileName
- Add negative number
- Add positive number
- Add not zero number
- Add zip code
- Add MIME type
- Add timezone
- Add city
- Add country
- Add first name
- Add last name
- Add passport number
- Add state
- Add street
- Add prime number
- Add DUNS
- Add language code
- Add license plate
- Add VIN number

## 10.0.1

- Fix regression (include l10n files)

## 10.0.0

- Update intl to 0.19.0
- Update constraints to Dart 3.4
- Built with Flutter 3.22.0
- Improve CI
- Improve Dutch language
- Add Norwegian

## 9.1.0

- Fix MN translation typo
- Fix remove full stop at end of error message for max validation
- Update intl to 0.18.1
- Improve readme
- Built with Flutter 3.13

## 9.0.0

- Update constraints to Flutter 3.10
- Update intl to 0.18.0
- Update constraints to Dart 3.0

## 9.0.0-dev.2

- Update constraints to Dart 3.0

## 9.0.0-dev.1

- Update constraints to Flutter 3.10
- Update intl to 0.18.0

## 8.6.1

- Add missed translations for some languages

## 8.6.0

- Add missed translations for all languages
- Add support for more languages
  - Swedish

## 8.5.0

- New validators for minWordsCount & maxWordsCount
- Simplify arb files and correct intl_zh.arb
- Build with Flutter 3.7.5
- Add support for more languages
  - Mongolian
  - Nepali and burmese
  - Albanian
  - Vietnamese

## 8.4.0

- Refactor l10n generator. Thanks [@ipcjs]()
- Add property to allow empty on equalLength validator. Thanks [@CircleCurve](https://github.com/CircleCurve)
- Add support for more languages
  - Czech. Thanks [@edlman](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/pull/3)
  - Bosnian and Croatian. Thanks [@abratanovic](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/pull/9)
  - Malay. Thanks [@azmilazizi](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/pull/13)
  - Thai. Thanks [@narospol](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/pull/19)
  - Tamil. Thanks [@Purus](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/pull/26)
  - Greek. Thanks [@nrallakis](https://github.com/flutter-form-builder-ecosystem/form_builder_validators/pull/27)

## 8.3.0

- Apply license BSD-3-clause
- Refactor readme
- Remove unused dependency
- Add web example

## 8.2.1

- Added Czech language support

## 8.2.0

- Added equalLength validator
- Added turkish language support
- Moved repository

## 8.1.1

- Fixed issue where email validator trims string before validation

## 8.1.0

- Added Romanian (ro) language support

## 8.0.0

- **BREAKING CHANGE**: Avoid passing context to validator functions.
- Added Swahili (sw) language support

## 7.9.0

- Added Bangla (bn) language support

## 7.8.0

- Added Estonian (et) language support
- Improved and corrected Arabic translations

## 7.7.0

- Added Catalan (ca) language support

## 7.6.1

- Fixed duplicate `en` locale translations. Fixes #969

## 7.6.0

- Added Ukrainian (uk) language support

## 7.5.0

- Added Lao (lo) language support
- Added Dutch (nl) language support

## 7.4.0

- Added Russian (ru) language support

## 7.3.0

- Added support for Slovenian (sl)
- Added Chinese language support - both traditional (zh_Hant) and simplified (zh_Hans)

## 7.2.0

- Added language support for Indonesian (id)

## 7.1.0

- Added language support for Korean (ko)

## 7.0.0

- New Package 🎉🎊 - Split from and no dependency on flutter_form_builder(<https://pub.dev/packages/flutter_form_builder>)
- Added Arabic and Persian/Farsi support
- Use `intl_utils` package for localization
- Minor type fixes
- Documentation and example improvements

## 7.0.0-RC.1

- `maxLength` and `minLength` validators can now work with `Iterable` field values length

## 7.0.0-RC.0

- Added Arabic and Persian/Farsi support

## 7.0.0-beta.0

- Use `intl_utils` package for localization
- Documentation and example improvements - added instructions for localization
- Minor type fixes

## 7.0.0-alpha.2

- Improvements to package documentation and example

## 7.0.0-alpha.1

- Split into own package from `flutter_form_builder`
