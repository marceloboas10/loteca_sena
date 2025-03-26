import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loteria/app/pages/home/home_page.dart';

void main() {
  runApp(const Loteria());
}

class Loteria extends StatefulWidget {
  const Loteria({super.key});

  @override
  State<Loteria> createState() => _LoteriaState();
}

class _LoteriaState extends State<Loteria> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white, size: 28),
            centerTitle: true,
            backgroundColor: Color(0xFF00B37E),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          scaffoldBackgroundColor: const Color(0xFF036548),
          useMaterial3: true),
      home: const HomePage(),
    );
  }
}
