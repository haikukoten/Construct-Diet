import 'package:construct_diet/globalization/vocabulary.dart';

import 'diet.dart';

class Diets {
  static List<Diet> load() {
    var local = [
      Diet(Vocabluary.getWord('Greek'), [1, 2, 4, 7, 8, 10], 14, 7, 830),
      Diet(Vocabluary.getWord('Bulgarian'), [1, 3, 5, 8, 10], 14, 10, 580),
      Diet(Vocabluary.getWord('Carbohydrate-free'), [1, 2, 8], 14, 8, 740),
      Diet(Vocabluary.getWord('Protein'), [1, 2, 3, 4, 5, 7, 8, 10], 14, 10,
          700),
      Diet(Vocabluary.getWord('French'), [1, 2, 3, 4, 7, 10], 14, 8, 552),
      Diet(Vocabluary.getWord('Buckwheat'), [3, 5, 8], 14, 12, 970),
      Diet(Vocabluary.getWord('Chinese'), [1, 2, 4, 10], 14, 10, 570),
      Diet(Vocabluary.getWord('Brazilian'), [1, 2, 3, 4], 14, 9, 550),
      Diet(Vocabluary.getWord('Macrobiotic'), [2, 3, 4, 7], 14, 7, 710),
      Diet(Vocabluary.getWord('Bean'), [1, 2, 3, 4, 7, 8], 14, 8, 660),
      Diet(Vocabluary.getWord('Egg'), [1, 2, 3, 4, 9], 14, 7, 880),
      Diet(Vocabluary.getWord('Asian'), [1, 2, 3, 4, 7, 8, 10], 14, 8, 1060),
      Diet(Vocabluary.getWord('Japanese'), [1, 2, 3, 4, 7, 8], 13, 8, 695),
      Diet(Vocabluary.getWord('Italian'), [1, 3, 4, 7, 8, 9], 12, 6, 810),
      Diet(Vocabluary.getWord('Cabbage'), [1, 2, 3, 4, 8], 10, 10, 771),
      Diet(Vocabluary.getWord('Courgette'), [1, 2, 3, 4, 8, 9], 10, 6, 620),
      Diet(Vocabluary.getWord('Vitamin-protein'), [1, 2, 3, 4, 8, 9, 10], 10, 7,
          1000),
      Diet(Vocabluary.getWord('Date'), [3, 5, 8, 10], 10, 8, 850),
      Diet(Vocabluary.getWord('Apple'), [3, 7], 7, 7, 675),
      Diet(Vocabluary.getWord('Kefir-apple'), [3, 8], 7, 6, 673)
    ];
    return local;
  }
}
