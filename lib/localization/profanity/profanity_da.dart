// coverage:ignore-file
import 'profanity.dart';

/// English profanity list.
class ProfanityDa extends Profanity {
  /// Creates a new instance of the profanity list.
  ProfanityDa([super.locale = 'da']);

  @override
  List<String> get profanityList => <String>[
        'anus',
        'bøsserøv',
        'cock',
        'fisse',
        'fissehår',
        'fuck',
        'hestepik',
        'kussekryller',
        'lort',
        'luder',
        'pik',
        'pikhår',
        'pikslugeri',
        'piksutteri',
        'pis',
        'røv',
        'røvhul',
        'røvskæg',
        'røvspræke',
        'shit'
      ];
}
