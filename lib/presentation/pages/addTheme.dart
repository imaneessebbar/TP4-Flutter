import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tp12/data/config.dart';
import 'package:tp12/presentation/widgets/MyTheme.dart';

class AddTheme extends StatelessWidget {
  final _getTheme = TextEditingController();
  bool _isdark = currentTheme.getisDark();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text(
            " Ajouter un thème",
            textAlign: TextAlign.center,
          ),
          actions: [
            Switch(
              value: _isdark,
              onChanged: (value) {
                currentTheme.switchTheme();
                _isdark = !_isdark;
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
                  top: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width / 3 * 2,
                  child: TextField(
                    controller: _getTheme,
                    decoration: const InputDecoration(
                        fillColor: Colors.deepPurple,
                        border: OutlineInputBorder(),
                        hintText: 'Nom du theme'),
                  )),
              Positioned(
                  top: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width / 3 * 2,
                  child: TextField(
                    controller: _getTheme,
                    decoration: const InputDecoration(
                        fillColor: Colors.deepPurple,
                        border: OutlineInputBorder(),
                        hintText: 'Nom du theme'),
                  )),
              Positioned(
                  top: MediaQuery.of(context).size.height / 9 * 2,
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple, onPrimary: Colors.white),
                    onPressed: () => {pressButton(context)},
                    child: Text(
                      "Ajouter",
                    ),
                  ))
            ],
          ),
        ));
  }

  pressButton(BuildContext context) {
    if (_getTheme.text != "" && _getTheme.text != null) {
      _AddTheme(_getTheme.text);
      _getTheme.text = "";
      AlertDialog alert = AlertDialog(
        title: Text("Success"),
        content: Text("Ajouter avec succès! "),
        actions: [],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      AlertDialog alert = AlertDialog(
        title: Text("Champs vide"),
        content: Text("Veillez saisir un thème"),
        actions: [],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  Future<void> _AddTheme(String texte) {
    CollectionReference themes = FirebaseFirestore.instance.collection('theme');
    return themes
        .add({'name': texte.toLowerCase(), 'imgthm': ""})
        .then((value) => print("Theme Added"))
        .catchError((error) => print("Failed to add theme: $error"));
  }
}
