import 'package:flutter/material.dart';
import 'package:simple_web_viewer/screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      title: 'Web View',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 212, 127, 0)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
