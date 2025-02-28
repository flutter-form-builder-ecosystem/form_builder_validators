// coverage:ignore-file
import 'profanity.dart';

/// English profanity list.
class ProfanityId extends Profanity {
  /// Creates a new instance of the profanity list.
  ProfanityId([super.locale = 'id']);

  @override
  List<String> get profanityList => <String>[
        'anjing',
        'babi',
        'bangsat',
        'bego',
        'bodoh',
        'brengsek',
        'cukimai',
        'goblok',
        'idiot',
        'jancok',
        'kampret',
        'kontol',
        'koplak',
        'lonte',
        'memek',
        'ngentot',
        'ngewe',
        'pepek',
        'tai',
        'tolol',
        'waria'
      ];
}
