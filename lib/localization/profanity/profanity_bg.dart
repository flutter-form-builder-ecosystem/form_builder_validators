// coverage:ignore-file
import 'profanity.dart';

/// English profanity list.
class ProfanityBg extends Profanity {
  /// Creates a new instance of the profanity list.
  ProfanityBg([super.locale = 'bg']);

  @override
  List<String> profanityList = <String>[
    'гъз',
    'ебан',
    'путка',
    'кур',
    'мамка ти',
    'курва',
    'лайно',
    'кочина',
    'педераст',
    'секс',
    'боклук',
    'пикня',
    'майка ти',
    'гомик',
    'ебаняк'
  ];
}
