import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:iclock/widgets/indication_pane.dart';
import 'package:iclock/widgets/separator.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateTime _currentTime;
  late Timer _timer;
  int _currentHour = 0, _currentMin = 0, _currentSec = 0;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
        _currentHour = int.parse(DateFormat('HH').format(_currentTime));
        _currentMin = int.parse(DateFormat('mm').format(_currentTime));
        _currentSec = int.parse(DateFormat('ss').format(_currentTime));
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]); // Réinitialise l'orientation préférée
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        removeLeft: true,
        removeRight: true,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xFF161617),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IndicatorPane(valueToDisplay: _currentHour),
              const SizedBox(
                width: 15,
              ),
              Separator(),
              const SizedBox(
                width: 15,
              ),
              IndicatorPane(valueToDisplay: _currentMin),
              const SizedBox(
                width: 15,
              ),
              Separator(),
              const SizedBox(
                width: 15,
              ),
              IndicatorPane(valueToDisplay: _currentSec)
            ],
          ),
        ),
      ),
    );
  }
}
