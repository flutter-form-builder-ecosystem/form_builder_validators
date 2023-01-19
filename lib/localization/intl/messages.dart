import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'messages_ar.dart';
import 'messages_bn.dart';
import 'messages_bs.dart';
import 'messages_ca.dart';
import 'messages_cs.dart';
import 'messages_de.dart';
import 'messages_el.dart';
import 'messages_en.dart';
import 'messages_es.dart';
import 'messages_et.dart';
import 'messages_fa.dart';
import 'messages_fr.dart';
import 'messages_hr.dart';
import 'messages_hu.dart';
import 'messages_id.dart';
import 'messages_it.dart';
import 'messages_ja.dart';
import 'messages_ko.dart';
import 'messages_lo.dart';
import 'messages_mn.dart';
import 'messages_ms.dart';
import 'messages_nl.dart';
import 'messages_pl.dart';
import 'messages_pt.dart';
import 'messages_ro.dart';
import 'messages_ru.dart';
import 'messages_sk.dart';
import 'messages_sl.dart';
import 'messages_sw.dart';
import 'messages_ta.dart';
import 'messages_th.dart';
import 'messages_tr.dart';
import 'messages_uk.dart';
import 'messages_zh.dart';

/// Callers can lookup localized strings with an instance of FormBuilderLocalizationsImpl
/// returned by `FormBuilderLocalizationsImpl.of(context)`.
///
/// Applications need to include `FormBuilderLocalizationsImpl.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'intl/messages.dart';
///
/// return MaterialApp(
///   localizationsDelegates: FormBuilderLocalizationsImpl.localizationsDelegates,
///   supportedLocales: FormBuilderLocalizationsImpl.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the FormBuilderLocalizationsImpl.supportedLocales
/// property.
abstract class FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImpl(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FormBuilderLocalizationsImpl? of(BuildContext context) {
    return Localizations.of<FormBuilderLocalizationsImpl>(context, FormBuilderLocalizationsImpl);
  }

  static const LocalizationsDelegate<FormBuilderLocalizationsImpl> delegate = _FormBuilderLocalizationsImplDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('bs'),
    Locale('ca'),
    Locale('cs'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('et'),
    Locale('fa'),
    Locale('fr'),
    Locale('hr'),
    Locale('hu'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('lo'),
    Locale('mn'),
    Locale('ms'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('sk'),
    Locale('sl'),
    Locale('sw'),
    Locale('ta'),
    Locale('th'),
    Locale('tr'),
    Locale('uk'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant')
  ];

  /// Error Text for required field
  ///
  /// In en, this message translates to:
  /// **'This field cannot be empty.'**
  String get requiredErrorText;

  /// Error Text for required field
  ///
  /// In en, this message translates to:
  /// **'Value must be greater than or equal to {min}.'**
  String minErrorText(Object min);

  /// Error Text for required field
  ///
  /// In en, this message translates to:
  /// **'Value must have a length greater than or equal to {minLength}'**
  String minLengthErrorText(Object minLength);

  /// Error Text for required field
  ///
  /// In en, this message translates to:
  /// **'Value must be less than or equal to {max}'**
  String maxErrorText(Object max);

  /// Error Text for required field
  ///
  /// In en, this message translates to:
  /// **'Value must have a length less than or equal to {maxLength}'**
  String maxLengthErrorText(Object maxLength);

  /// Error Text for required field
  ///
  /// In en, this message translates to:
  /// **'Value must have a length equal to {length}'**
  String equalLengthErrorText(Object length);

  /// Error Text for email field
  ///
  /// In en, this message translates to:
  /// **'This field requires a valid email address.'**
  String get emailErrorText;

  /// Error Text for integer validator
  ///
  /// In en, this message translates to:
  /// **'This field requires a valid integer.'**
  String get integerErrorText;

  /// Error Text for equal validator
  ///
  /// In en, this message translates to:
  /// **'This field value must be equal to {value}.'**
  String equalErrorText(Object value);

  /// Error Text for not-equal validator
  ///
  /// In en, this message translates to:
  /// **'This field value must not be equal to {value}.'**
  String notEqualErrorText(Object value);

  /// Error Text for URL field
  ///
  /// In en, this message translates to:
  /// **'This field requires a valid URL address.'**
  String get urlErrorText;

  /// Error Text for pattern field
  ///
  /// In en, this message translates to:
  /// **'Value does not match pattern.'**
  String get matchErrorText;

  /// Error Text for numeric field
  ///
  /// In en, this message translates to:
  /// **'Value must be numeric.'**
  String get numericErrorText;

  /// Error Text for credit card field
  ///
  /// In en, this message translates to:
  /// **'This field requires a valid credit card number.'**
  String get creditCardErrorText;

  /// Error Text for IP address field
  ///
  /// In en, this message translates to:
  /// **'This field requires a valid IP.'**
  String get ipErrorText;

  /// Error Text for date string field
  ///
  /// In en, this message translates to:
  /// **'This field requires a valid date string.'**
  String get dateStringErrorText;
}

class _FormBuilderLocalizationsImplDelegate extends LocalizationsDelegate<FormBuilderLocalizationsImpl> {
  const _FormBuilderLocalizationsImplDelegate();

  @override
  Future<FormBuilderLocalizationsImpl> load(Locale locale) {
    return SynchronousFuture<FormBuilderLocalizationsImpl>(lookupFormBuilderLocalizationsImpl(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'bn', 'bs', 'ca', 'cs', 'de', 'el', 'en', 'es', 'et', 'fa', 'fr', 'hr', 'hu', 'id', 'it', 'ja', 'ko', 'lo', 'mn', 'ms', 'nl', 'pl', 'pt', 'ro', 'ru', 'sk', 'sl', 'sw', 'ta', 'th', 'tr', 'uk', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_FormBuilderLocalizationsImplDelegate old) => false;
}

FormBuilderLocalizationsImpl lookupFormBuilderLocalizationsImpl(Locale locale) {

  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh': {
  switch (locale.scriptCode) {
    case 'Hant': return FormBuilderLocalizationsImplZhHant();
   }
  break;
   }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return FormBuilderLocalizationsImplAr();
    case 'bn': return FormBuilderLocalizationsImplBn();
    case 'bs': return FormBuilderLocalizationsImplBs();
    case 'ca': return FormBuilderLocalizationsImplCa();
    case 'cs': return FormBuilderLocalizationsImplCs();
    case 'de': return FormBuilderLocalizationsImplDe();
    case 'el': return FormBuilderLocalizationsImplEl();
    case 'en': return FormBuilderLocalizationsImplEn();
    case 'es': return FormBuilderLocalizationsImplEs();
    case 'et': return FormBuilderLocalizationsImplEt();
    case 'fa': return FormBuilderLocalizationsImplFa();
    case 'fr': return FormBuilderLocalizationsImplFr();
    case 'hr': return FormBuilderLocalizationsImplHr();
    case 'hu': return FormBuilderLocalizationsImplHu();
    case 'id': return FormBuilderLocalizationsImplId();
    case 'it': return FormBuilderLocalizationsImplIt();
    case 'ja': return FormBuilderLocalizationsImplJa();
    case 'ko': return FormBuilderLocalizationsImplKo();
    case 'lo': return FormBuilderLocalizationsImplLo();
    case 'mn': return FormBuilderLocalizationsImplMn();
    case 'ms': return FormBuilderLocalizationsImplMs();
    case 'nl': return FormBuilderLocalizationsImplNl();
    case 'pl': return FormBuilderLocalizationsImplPl();
    case 'pt': return FormBuilderLocalizationsImplPt();
    case 'ro': return FormBuilderLocalizationsImplRo();
    case 'ru': return FormBuilderLocalizationsImplRu();
    case 'sk': return FormBuilderLocalizationsImplSk();
    case 'sl': return FormBuilderLocalizationsImplSl();
    case 'sw': return FormBuilderLocalizationsImplSw();
    case 'ta': return FormBuilderLocalizationsImplTa();
    case 'th': return FormBuilderLocalizationsImplTh();
    case 'tr': return FormBuilderLocalizationsImplTr();
    case 'uk': return FormBuilderLocalizationsImplUk();
    case 'zh': return FormBuilderLocalizationsImplZh();
  }

  throw FlutterError(
    'FormBuilderLocalizationsImpl.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
