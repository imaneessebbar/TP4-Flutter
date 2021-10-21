import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tp12/data/config.dart';
import 'package:tp12/presentation/widgets/MyTheme.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestion();
}

class _AddQuestion extends State<AddQuestion> {
  final _getTheme = TextEditingController();
  bool? _answer = true;
  SwitchMode() {
    Provider.of<MyTheme>(context, listen: false).switchTheme();
  }

  bool _isdark = currentTheme.getisDark();

  @override
  Widget build(BuildContext context) {
    var name = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text(
            " Ajouter une Question",
            textAlign: TextAlign.center,
          ),
          actions: [
            Switch(
              value: _isdark,
              onChanged: (value) {
                setState(() {
                  currentTheme.switchTheme();
                  _isdark = !_isdark;
                });
              },
            ),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  top: 200,
                  width: MediaQuery.of(context).size.width / 3 * 2,
                  child: TextField(
                    controller: _getTheme,
                    cursorColor: Colors.deepPurple,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Entrer la question'),
                  )),
              Positioned(
                top: MediaQuery.of(context).size.height / 3 + 50,
                child: Text("Réponse : "),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 9, 100, 0, 0),
                child: ListTile(
                  title: const Text('Vrai'),
                  leading: Radio<bool>(
                    value: true,
                    activeColor: Colors.deepPurple,
                    groupValue: _answer,
                    onChanged: (bool? value) {
                      setState(() {
                        _answer = value;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 9 * 4, 100, 0, 0),
                child: ListTile(
                  title: const Text('Faux'),
                  leading: Radio<bool>(
                    value: false,
                    activeColor: Colors.deepPurple,
                    groupValue: _answer,
                    onChanged: (bool? value) {
                      setState(() {
                        _answer = value;
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height / 3 + 200,
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple, onPrimary: Colors.white),
                    onPressed: () => pressButton(context, name.toString()),
                    child: Text(
                      "Ajouter",
                    ),
                  ))
            ],
          ),
        ));
  }

  void pressButton(BuildContext context, String name) {
    if (_getTheme.text != "") {
      _addQuestion(name.toString(), _getTheme.text, _answer);
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
        content: Text("Veillez saisir une question"),
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

  Future<void> _addQuestion(String name, String texte, bool? _answer) {
    CollectionReference themes =
        FirebaseFirestore.instance.collection('questions');

    return themes.add({
      'theme': name.toLowerCase(),
      'texte': texte.toLowerCase(),
      'answer': _answer
    });
  }
}
