import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tp12/presentation/pages/PickThemeQuizz.dart';
import 'package:tp12/presentation/pages/resultpage.dart';
import 'package:tp12/presentation/widgets/PickTheme.dart';
import 'package:tp12/presentation/widgets/quizzwidget.dart';
import '/data/models/question.dart';
import '/data/models/theme.dart' as t;

class QuizzPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuizzPage('', '');
}

class _QuizzPage extends State<QuizzPage> {
  final String title;
  final String theme;
  _QuizzPage(this.title, this.theme);

  var _questions = [];

  CollectionReference questions =
      FirebaseFirestore.instance.collection("questions");
  String? imgtheme = "";
  @override
  Widget build(BuildContext context) {
    var name = ModalRoute.of(context)!.settings.arguments;
    var theme = ModalRoute.of(context)!.settings.arguments as t.Theme;
    name = theme.name;
    imgtheme = theme.imgthm;

    return FutureBuilder<QuerySnapshot>(
      future: questions.where('theme', isEqualTo: name.toString()).get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (questions.where('theme', isEqualTo: name).get() != null) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && snapshot.data == null) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<Question> _questions = getQuestions(snapshot);
            if (_questions.isNotEmpty) {
              return quizzWidget(context, _questions, imgtheme!);
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return _pasdequestion(context);
        }
      },
    );
  }

  getQuestions(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map((doc) => new Question(
              doc["texte"].toString(),
              doc["theme"].toString(),
              doc["answer"],
            ))
        .toList();
  }
}

_pasdequestion(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () => {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PickThemeQuizz(),
          settings: RouteSettings(),
        ),
      )
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Pas de questions"),
    content: Text(
        "Nous n'avons pas de questions pour ce theme, choisissez un autre."),
    actions: [okButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class Counter extends ChangeNotifier {
  int _counter = 0;
  int _score = 0;
  bool answered = false;

  int get getCounter => _counter;

  int get getScore => _score;

  bool get getAnswered => answered;

  void incrementCounter(BuildContext context, int n) {
    if (_counter == n - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondPage(),
          settings: RouteSettings(
            arguments: _score,
          ),
        ),
      );
      _counter = 0;
      _score = 0;
    } else {
      _counter++;
    }
    answered = false;
    notifyListeners();
  }

  void incrementScore() {
    _score += 1;
    notifyListeners();
  }

  void setAnswered(bool bool) {
    answered = bool;
  }
}
