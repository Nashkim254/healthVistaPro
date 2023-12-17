part of 'localizations.dart';

class LocalizationService {
  late final Locale locale;
  static late Locale currentLocale;

  LocalizationService(this.locale) {
    currentLocale = locale;
  }

  static LocalizationService of(BuildContext context) {
    return Localizations.of(context, LocalizationService);
  }

  late Map<String, String> _localizedString;

  Future<void> setLocale() async {
    ///initialize memory
    String locale = SharedPrefs.getLocale() ?? "en";
    load(languageCode: locale);
  }

  Future<void> load({String? languageCode}) async {
    final jsonString = await rootBundle
        .loadString('lib/Localization/Lang/${languageCode ?? locale.languageCode}.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    _localizedString = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String? translate(String key) {
    return _localizedString[key];
  }

  static const supportedLocales = [Locale('en', 'US'), Locale('ar', 'AR')];

  static Locale? localeResolutionCallBack(Locale? locale, Iterable<Locale>? supportedLocales) {
    if (supportedLocales != null && locale != null) {
      return supportedLocales.firstWhere((element) => element.languageCode == locale.languageCode,
          orElse: () => supportedLocales.first);
    }

    return null;
  }

  static const LocalizationsDelegate<LocalizationService> delegate = _LocalizationServiceDelegate();

  static const localizationsDelegate = [delegate];
}

class _LocalizationServiceDelegate extends LocalizationsDelegate<LocalizationService> {
  const _LocalizationServiceDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<LocalizationService> load(Locale locale) async {
    LocalizationService service = LocalizationService(locale);
    await service.load();
    return service;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LocalizationService> old) {
    return false;
  }
}

class LocalizationController extends ChangeNotifier {
  String currentLanguage = '';
  String currentLang = '';
  bool isEnglish = true;
  bool isArabic = true;
  void toggleLanguage() {
    currentLanguage = LocalizationService.currentLocale.languageCode == 'en' ? 'ar' : 'en';
    currentLang = '';
    notifyListeners();
  }
}
