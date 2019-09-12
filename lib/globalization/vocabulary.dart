class Vocabluary {
  // Vars
  static String _appLanguage = 'en';
  static List<String> _appLanguages = <String>['en', 'ru'];

  // TODO: Lang from json
  static Map<String, Map<String, String>> _wordManager = {
    'en': {
      'language_name': 'English',

      /** main **/
      /* dialog */
      'Yes': 'Yes',
      'No': 'No',
      'Cancel': 'Cancel',
      'Changes applied': 'Changes applied',
      'To display the changes, run the application again.':
          "To display the changes, run the application again.",

      /* diagnosisList */
      'Weight deficit': 'Weight deficit',
      'Underweight': 'Underweight',
      'Normal weight': 'Normal weight',
      'Overweight': 'Overweight',
      'Class I obesity': 'Class I obesity',
      'Class II obesity': 'Class II obesity',
      'Class III obesity': 'Class III obesity',

      /* Info Card */
      'Specify your parameters': 'Specify your parameters',
      'Click to edit': 'Click to edit',

      /* TabContent */
      'Result': 'Result',
      'Preferences': 'Preferences',
      'Other': 'Other',

      /** favorite_tab **/
      /* foodList */
      'Meat products': 'Meat products',
      'Fish products': 'Fish products',
      'Fruit': 'Fruits',
      'Vegetables': 'Vegetables',
      'Cereals': 'Cereals',
      'Citrus': 'Citrus',
      'Gluten': 'Gluten',
      'Lactose': 'Lactose',
      'Glucose': 'Glucose',

      /* InfoLabel */
      'Choose diets to suit your taste': 'Choose diets to suit your taste',
      'Choose which foods you want to see in your diets and which to remove from the diet.':
          'Choose which foods you want to see in your diets and which to remove from the diet.',

      /** more_tab **/
      /* Developer edge menu */
      'Developer\'s menu': 'Developer\'s menu',
      'Use the UI for iOS': 'Use the UI for iOS',
      'Affects the appearance of components':
          'Affects the appearance of components',

      /* InfoLabel */
      'Version': 'Version',
      'Build': 'build',

      /* Settings */
      'Settings': 'Settings',

      /* Language Card */
      'Language': 'Language',

      /* Theme Card */
      'Go to the dark side': 'Go to the dark side',
      'Activate a dark theme': 'Activate a dark theme',

      /* Refresh Setting Card */
      'Reset the settings': 'Reset the settings',
      'After resetting settings, restart the app.':
          'After resetting settings, restart the app.',

      /* Contributors Card */
      'Project Contributors': 'Project Contributors',
      'People who have made a certain contribution to the project.':
          'People who have made a certain contribution to the project.',

      /* Social Card */
      'We\'re on social media': 'We\'re on social media',

      /* Button */
      'best regards, team oneLab': 'best regards, team oneLab',

      /** result_tab **/
      'Health information': 'Health information',
      /* Allowable weight */
      'Allowable weight': 'Allowable weight',
      /* MODEL: Weight model */
      'LeftWModel': 'from ',
      'MiddleWModel': ' kg to ',
      'MiddleRightWModel': ' kg (ideal - ',
      'RightWModel': ' kg)',

      /* Overweight */
      'Missing': 'Missing',
      'kg': 'kg',

      /* index */
      'Body mass index': 'Body mass index',

      /* Diets bli */
      'Diets not found': 'Diets not found',
      'No need for weight lose': 'No need for weight lose',
      'Try changing the preferences filter':
          'Try changing the preferences filter',
      'The most suitable diet': 'The most suitable diet',
      'Diets': 'Diets',
      'Click on the diet to show more information':
          'Click on the diet to show more information',

      /** diet_info_page **/

      /* Match */
      'Match your preferences': 'Match your preferences',
      'Diet efficiency': 'Diet efficiency',
      'kg in': 'kg in',
      'days': 'days',

      /* Clorie */
      'Calorie diet': 'Calorie diet',
      'kcal': 'kcal',

      /* FoodStruct */
      'Nutrition structure': 'Nutrition structure',

      /* engine */
      'diet': 'diet',
      'Show search engine results': 'Show search engine results',
      'More information about diet': 'More information about diet',

      /* foodList */
      'List Meat products': 'meat products',
      'List Fish products': 'fish products',
      'List Fruit': 'fruits',
      'List Vegetables': 'vegetables',
      'List Cereals': 'cereals',
      'List Citrus': 'citrus',
      'List Gluten': 'contains gluten',
      'List Lactose': 'contains lactose',
      'List Glucose': 'contains glucose',

      /** edit_page **/
      'Body parameters': 'Body parameters',
      'cm': 'cm',
      'years old': 'years old',
      'Age': 'Age',
      'Height': 'Height',
      'Weight': 'Weight',
      'Female': 'female',
      'Male': 'male',
      'Gender': 'Gender',

      /** data_model **/
      /* DietsList */
      'Greek': 'Greek',
      'Bulgarian': 'Bulgarian',
      'Carbohydrate-free': 'Carbohydrate-free',
      'Protein': 'Protein',
      'French': 'French',
      'Buckwheat': 'Buckwheat',
      'Chinese': 'Chinese',
      'Brazilian': 'Brazilian',
      'Macrobiotic': 'Macrobiotic',
      'Bean': 'Bean',
      'Egg': 'Egg',
      'Asian': 'Asian',
      'Japanese': 'Japanese',
      'Italian': 'Italian',
      'Cabbage': 'Cabbage',
      'Courgette': 'Courgette',
      'Vitamin-protein': 'Vitamin-protein',
      'Date': 'Date',
      'Apple': 'Apple',
      'Kefir-apple': 'Kefir-apple',
    },
    'ru': {
      'language_name': 'Русский',

      /** main **/
      /* dialog */
      'Yes': 'Да',
      'No': 'Нет',
      'Cancel': 'Отмена',
      'Changes applied': 'Изменения применены',
      'To display the changes, run the application again.':
          "Для отображения изменений, запустите приложение снова.",

      /* diagnosisList */
      'Weight deficit': 'Выраженный недостаток веса',
      'Underweight': 'Недостаточный вес',
      'Normal weight': 'Нормальный вес',
      'Overweight': 'Избыточный вес',
      'Class I obesity': 'Первая степень ожирения',
      'Class II obesity': 'Вторая степень ожирения',
      'Class III obesity': 'Третья степень ожирения',

      /* InfoLabel */
      'Specify your parameters': 'Укажите свои параметры',
      'Click to edit': 'Нажмите для редактирования',

      /* TabContent */
      'Result': 'Результат',
      'Preferences': 'Предпочтения',
      'Other': 'Другое',

      /** favorite_tab **/
      /* foodList */
      'Meat products': 'Мясные продукты',
      'Fish products': 'Рыбные продукты',
      'Fruit': 'Фрукты',
      'Vegetables': 'Овощи',
      'Cereals': 'Крупы',
      'Citrus': 'Цитрусовые',
      'Gluten': 'Глютен',
      'Lactose': 'Лактоза',
      'Glucose': 'Глюкоза',

      /* InfoLabel */
      'Choose diets to suit your taste': 'Подбирайте диеты под свой вкус',
      'Choose which foods you want to see in your diets and which to remove from the diet.':
          'Выберите, какие продукты вы желаете видеть в диетах, а какие нужно отсеить из выдачи.',

      /** more_tab **/
      /* Developer edge menu */
      'Developer\'s menu': 'Меню разработчика',
      'Use the UI for iOS': 'Использовать интерфейс для iOS',
      'Affects the appearance of components': 'Влияет на внешность компонентов',

      /* Info Card */
      'Version': 'Версия',
      'Build': 'сборка',

      /* Settings */
      'Settings': 'Настройки',

      /* Language Card */
      'Language': 'Язык интерфейса',

      /* Theme Card */
      'Go to the dark side': 'Перейти на тёмную сторону',
      'Activate a dark theme': 'Активировать тёмную тему',

      /* Refresh Setting Card */
      'Reset the settings': 'Сбросить настройки',
      'After resetting settings, restart the app.':
          'После сброса запустите приложение снова.',

      /* Contributors Card */
      'Project Contributors': 'Участники проекта',
      'People who have made a certain contribution to the project.':
          'Люди, сделавшие определённый вклад в проект.',

      /* Social Card */
      'We\'re on social media': 'Мы в социальных сетях',

      /* Button */
      'best regards, team oneLab': 'с любовью, команда oneLab',

      /** result_tab **/
      'Health information': 'Сведения о здоровье',
      /* Allowable weight */
      'Allowable weight': 'Допустимый вес',
      /* MODEL: Weight model */
      'LeftWModel': 'от ',
      'MiddleWModel': ' кг до ',
      'MiddleRightWModel': ' кг (идеально - ',
      'RightWModel': ' кг)',

      /* Overweight */
      'Missing': 'Отсутствует',
      'kg': 'кг',

      /* index */
      'Body mass index': 'Индекс массы тела',

      /* Diets bli */
      'Diets not found': 'Диеты не найдены',
      'No need for weight lose': 'Нет необходимости в похудении',
      'Try changing the preferences filter':
          'Попробуйте изменить фильтр по предпочтениям',
      'The most suitable diet': 'Самая подходящая диета',
      'Diets': 'Диеты',
      'Click on the diet to show more information':
          'Нажмите на диету, чтобы показать больше информации',

      /** diet_info_page **/

      /* Match */
      'Match your preferences':
          'Совпадение с вашими параметрами и предпочтениями',
      'Diet efficiency': 'Эффективность диеты',
      'kg in': 'кг за',
      'days': 'дней',

      /* Clorie */
      'Calorie diet': 'Калорийность диеты',
      'kcal': 'ккал',

      /* FoodStruct */
      'Nutrition structure': 'Структура питания',

      /* engine */
      'diet': 'диета',
      'Show search engine results': 'Показать результаты поисковой системы',
      'More information about diet': 'Подробная информация',

      /* foodList */
      'List Meat products': 'мясные продукты',
      'List Fish products': 'рыбные продукты',
      'List Fruit': 'фрукты',
      'List Vegetables': 'овощи',
      'List Cereals': 'крупы',
      'List Citrus': 'цитрусовые',
      'List Gluten': 'содержит глютен',
      'List Lactose': 'содержит лактозу',
      'List Glucose': 'содержит глюкозу',

      /** edit_page **/
      'Body parameters': 'Параметры тела',
      'cm': 'см',
      'years old': 'лет',
      'Age': 'Возраст',
      'Height': 'Рост',
      'Weight': 'Вес',
      'Female': 'женский',
      'Male': 'мужской',
      'Gender': 'Пол',

      /** data_model **/
      /* DietsList */
      'Greek': 'Греческая',
      'Bulgarian': 'Болгарская',
      'Carbohydrate-free': 'Безуглеводная',
      'Protein': 'Белковая',
      'French': 'Французская',
      'Buckwheat': 'Гречневая',
      'Chinese': 'Китайская',
      'Brazilian': 'Бразильская',
      'Macrobiotic': 'Макробиотическая',
      'Bean': 'Бобовая',
      'Egg': 'Яичная',
      'Asian': 'Азиатская',
      'Japanese': 'Японская',
      'Italian': 'Итальянская',
      'Cabbage': 'Капустная',
      'Courgette': 'Кабачковая',
      'Vitamin-protein': 'Витаминно-белковая',
      'Date': 'Финиковая',
      'Apple': 'Яблочная',
      'Kefir-apple': 'Кефирно-яблочная',
    },
  };

  static String getWord(String wordID) {
    return _wordManager[_appLanguage][wordID];
  }

  static void setLanguage(String lang) {
    _appLanguage = checkLanguage(lang);
  }

  static String getCurrentLanguage() {
    return _appLanguage;
  }

  static String checkLanguage(String lang) {
    if (_appLanguages.contains(lang))
      return lang;
    else
      return _appLanguage;
  }

  static List<Map<String, String>> getLanguages() {
    return [
      for (int i = 0; i < _wordManager.length; i++)
        {
          'code': _appLanguages[i],
          'name': _wordManager[_appLanguages[i]]['language_name']
        }
    ];
  }
}
