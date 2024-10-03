// import 'package:i18n_extension/i18n_extension.dart';
// import 'package:i18n_extension/io/import.dart';
//
// class BaseI18n {
//   static TranslationsByLocale translations = Translations.byLocale("pt");
//
//   static Future<void> loadTranslations() async {
//     translations +=
//         await GettextImporter().fromAssetDirectory("i18n/texts.json");
//   }
// }
//
// extension Localization on String {
//   String get i18n => localize(this, BaseI18n.translations);
//
//   String plural(int value) => localizePlural(value, this, BaseI18n.translations);
//
//   String fill(List<Object> params) => localizeFill(this, params);
// }
