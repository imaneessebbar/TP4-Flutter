import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tp12/data/config.dart';
import 'package:tp12/presentation/widgets/MyTheme.dart';
import '/data/models/question.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _score = ModalRoute.of(context)!.settings.arguments;
    bool _isdark = currentTheme.getisDark();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          " Résulats ",
          textAlign: TextAlign.center,
        ),
        actions: [
          Switch(
            value: _isdark,
            onChanged: (value) {
              currentTheme.switchTheme();
              _isdark = !_isdark;
              print("theme changé");
            },
          ),
        ],
      ),
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              width: MediaQuery.of(context).size.width / 10 * 9,
              height: MediaQuery.of(context).size.height / 3,
              child: Text(
                "Bravo! Vous avez terminé le quizz. \n",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              top: -200,
            ),
            Positioned(
              width: MediaQuery.of(context).size.width / 10 * 9,
              height: MediaQuery.of(context).size.height / 3,
              child: Text(
                "Votre score est : \t $_score",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              top: -100,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple, onPrimary: Colors.white),
              child: const Text('Recommencer'),
            ),
          ],
        ),
      ),
    );
  }
}
