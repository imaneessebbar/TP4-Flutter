import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tp12/data/config.dart';
import 'package:tp12/presentation/pages/firstpage.dart';
import 'package:tp12/presentation/pages/quizzpage.dart';
import 'package:tp12/data/config.dart';
import 'package:tp12/presentation/widgets/MyTheme.dart';
import 'presentation/pages/addTheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      print("theme changed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Counter(),
        ),
        ChangeNotifierProvider.value(
          value: MyTheme(),
        ),
      ],
      child: MaterialApp(
        title: 'Questions/Réponses',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: currentTheme.currentTheme(),
        home: FirstPage(title: "Questions/Réponses"),
      ),
    );
  }
}
