import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp12/data/config.dart';
import 'package:tp12/presentation/pages/quizzpage.dart';
import 'package:tp12/presentation/widgets/MyTheme.dart';

Widget quizzWidget(BuildContext context, List questions, String imgtheme) {
  if (imgtheme == "") {
    imgtheme =
        "https://www.ksb-fluidexperts.fr/wp-content/uploads/2020/12/QUIZZ-2048x1345.jpg";
  }
  var _counter = Provider.of<Counter>(context).getCounter;
  var _score = Provider.of<Counter>(context).getScore;
  var _answred = Provider.of<Counter>(context).getAnswered;

  void _incrementScore(BuildContext context) {
    Provider.of<Counter>(context, listen: false).incrementScore();
  }

  void _nextQuestion(BuildContext context, int n) {
    Provider.of<Counter>(context, listen: false).incrementCounter(context, n);
  }

  void _RightAnswer(BuildContext context) {
    _incrementScore(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Bonne réponse !"),
    ));
  }

  void _WrongAnswer(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Oups, raté !"),
    ));
  }

  void _check(bool answer, bool rightanswer, BuildContext context) {
    var _answred = Provider.of<Counter>(context, listen: false).getAnswered;
    Provider.of<Counter>(context, listen: false).setAnswered(!_answred);
    if (answer == rightanswer) {
      _RightAnswer(context);
    } else {
      _WrongAnswer(context);
    }
  }

  bool _isdark = currentTheme.getisDark();

  if (questions.length == 0 && questions == null) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text(
            " Questions / Réponses",
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
          child: Text("No question found in this theme"),
        ));
  } else {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          " Questions / Réponses",
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
                top: 20,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple[100],
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    'Question ${_counter + 1} ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )),
            Positioned(
              top: 55,
              child: Container(
                width: MediaQuery.of(context).size.width / 10 * 9,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(imgtheme),
                      fit: BoxFit.fill,
                    ),
                    border: Border.all(
                      color: Colors.deepPurple,
                      width: 3,
                    ),
                    shape: BoxShape.rectangle),
              ),
            ),
            Positioned(
              top: 350,
              width: MediaQuery.of(context).size.width / 10 * 9,
              height: 150,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.deepPurple[100],
                  border: Border.all(
                    color: Colors.deepPurple,
                    width: 3,
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${questions[_counter].texte} ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 540,
                width: MediaQuery.of(context).size.width / 10 * 9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              currentTheme.getBackroungColorIcon())),
                      onPressed: () => _answred == true
                          ? null
                          : _check(true, questions[_counter].answer, context),
                      child: Column(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            color: Colors.deepPurple,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Vrai',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                backgroundColor:
                                    currentTheme.getBackroungColorIcon(),
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 50),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              currentTheme.getBackroungColorIcon())),
                      onPressed: () => _answred == true
                          ? null
                          : _check(false, questions[_counter].answer, context),
                      child: Column(
                        children: [
                          Icon(Icons.thumb_down, color: Colors.deepPurple),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Faux',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _nextQuestion(context, questions.length),
        tooltip: 'Next',
        child: const Icon(Icons.arrow_forward),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
