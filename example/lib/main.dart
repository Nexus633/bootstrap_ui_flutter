import 'package:bootstrap_flutter/bootstrap_flutter.dart';
import 'package:flutter/material.dart';
import 'ui/shell/showcase_shell.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, _) {
        return MaterialApp(
          title: 'Bootstrap UI',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode, // Reagiert auf Systemeinstellungen!
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: BsThemeData.lightTheme.bodyBg,
            extensions: [
              BsThemeData.lightTheme,
            ], // Hier hängen wir dein UI-Kit ein
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: BsThemeData.darkTheme.bodyBg,
            extensions: [BsThemeData.darkTheme], // Und hier das Dark Theme
          ),
          home: const ShowcaseShell(), // ← nur das
        );
      },
    );
  }
}
