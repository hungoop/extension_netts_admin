
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/models/models.dart';

abstract class ThemeEvent {}

class OnChangeTheme extends ThemeEvent {
  final ThemeModel? theme;
  final String? font;
  final DarkOption? darkOption;

  OnChangeTheme({
    this.theme,
    this.font,
    this.darkOption,
  });
}
