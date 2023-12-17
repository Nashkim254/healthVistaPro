part of 'localizations.dart';

String? getTranslated(BuildContext context, String key) {
  return LocalizationService.of(context).translate(key);
}
