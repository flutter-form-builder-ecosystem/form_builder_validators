import 'messages.dart';

/// The translations for Burmese (`my`).
class FormBuilderLocalizationsImplMy extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplMy([String locale = 'en']) : super(locale);

  @override
  String get requiredErrorText => 'ဤအကွက်သည် ဗလာမဖြစ်နိုင်ပါ။';

  @override
  String minErrorText(Object min) {
    return 'တန်ဖိုးထက် ကြီးသည် သို့မဟုတ် ညီမျှရပါမည်။ $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'တန်ဖိုးသည် အရှည်ထက် ကြီးသည် သို့မဟုတ် ညီမျှရပါမည်။ $minLength';
  }

  @override
  String maxErrorText(Object max) {
    return 'တန်ဖိုးထက် နည်းသည် သို့မဟုတ် ညီမျှရပါမည်။ $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'တန်ဖိုးသည် အရှည်ထက်နည်းသော သို့မဟုတ် ညီမျှရပါမည်။ $maxLength';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'တန်ဖိုးနှင့် ညီမျှသော အလျားရှိရမည်။ $length';
  }

  @override
  String get emailErrorText => 'ဤအကွက်တွင် မှန်ကန်သော အီးမေးလ်လိပ်စာတစ်ခု လိုအပ်ပါသည်။';

  @override
  String get integerErrorText => 'ဤအကွက်သည် မှန်ကန်သော ကိန်းပြည့်တစ်ခု လိုအပ်သည်။';

  @override
  String equalErrorText(Object value) {
    return 'ဤအကွက်တန်ဖိုးသည် တူညီရပါမည်။ $value.';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'ဤအကွက်တန်ဖိုးသည် တူညီမည်မဟုတ်ပါ။ $value.';
  }

  @override
  String get urlErrorText => 'ဤအကွက်သည် မှန်ကန်သော URL လိပ်စာတစ်ခု လိုအပ်သည်။';

  @override
  String get matchErrorText => 'တန်ဖိုးသည် ပုံစံနှင့် မကိုက်ညီပါ။';

  @override
  String get numericErrorText => 'တန်ဖိုးသည် ဂဏန်းဖြစ်ရမည်။';

  @override
  String get creditCardErrorText => 'ဤအကွက်တွင် မှန်ကန်သော ခရက်ဒစ်ကတ်နံပါတ်တစ်ခု လိုအပ်သည်။';

  @override
  String get ipErrorText => 'ဤအကွက်သည် တရားဝင် IP လိုအပ်သည်။';

  @override
  String get dateStringErrorText => 'ဤအကွက်တွင် မှန်ကန်သော ရက်စွဲစာကြောင်း လိုအပ်သည်။';
}
