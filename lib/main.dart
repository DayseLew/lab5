//212287
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import './dashboard.dart';
import './engineer/add_engineer.dart';
import './otp_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> factories = [
    {
      'name': 'Factory 1',
      'power_consumption': 0.0,
      'steam_pressure': 0.0,
      'steam_flow': 0.0,
      'water_level': 0.0,
      'power_freq': 0.0,
      'date': '--:--',
      'engineer_list': [
        {'name': 'Jim', 'phone': '013768392'},
        {'name': 'Kim', 'phone': '017490271'},
        {'name': 'Charlie', 'phone': '012840234'},
      ],
    },
    {
      'name': 'Factory 2',
      'power_consumption': 1549.7,
      'steam_pressure': 34.19,
      'steam_flow': 22.82,
      'water_level': 55.14,
      'power_freq': 50.08,
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString(),
      'engineer_list': [
        {'name': 'Sarah', 'phone': '0185933324'},
        {'name': 'Jason', 'phone': '0159293893'},
      ],
    },
  ];
  int currentFactoryIndex = 0;

  void updateCurrentFactory(int index) {
    setState(() {
      currentFactoryIndex = index;
    });
  }

  void updateEngineerList(String name, String phone) {
    setState(() {
      factories[currentFactoryIndex]['engineer_list'].add({
        'name': name,
        'phone': phone,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          ),
          initialRoute: '/otp',
          routes: {
            '/otp': (context) => OTPMain(step: 1),
            '/': (context) => Dashboard(
              factories: factories,
              currentFactoryIndex: currentFactoryIndex,
              updateCurrentFactory: updateCurrentFactory,
            ),
            '/addEngineer': (context) => EngineerForm(
              factories: factories,
              currentFactoryIndex: currentFactoryIndex,
              updateEngineerList: updateEngineerList,
            ),
          },
        );
      },
    );
  }
}
