import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp12/data/config.dart';

import 'package:tp12/data/models/theme.dart' as t;
import 'package:tp12/presentation/pages/firstpage.dart';
import 'package:tp12/presentation/pages/quizzpage.dart';
import 'package:tp12/presentation/pages/resultpage.dart';
import 'package:tp12/presentation/widgets/MyTheme.dart';
import 'package:tp12/presentation/widgets/quizzwidget.dart';

import '/data/models/question.dart';

class PickThemeQuizz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PickThemeQuizz();
}

class _PickThemeQuizz extends State<PickThemeQuizz> {
  bool _isdark = currentTheme.getisDark();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text("Choisir un thème"),
        actions: [
          Switch(
            value: _isdark,
            onChanged: (value) {
              setState(() {
                currentTheme.switchTheme();
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: themes.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Card(
                  child: ListTile(
                    title: Text(doc['name'].toString().toUpperCase()),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizzPage(),
                          settings: RouteSettings(
                            arguments: t.Theme(
                                name: doc['name'], imgthm: doc['imgthm']),
                          ),
                        ),
                      )
                    },
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
