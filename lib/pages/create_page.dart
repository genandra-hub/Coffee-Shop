import 'dart:async';

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:goals/utils/colors.dart";
import "package:goals/utils/database_helper.dart";
import "package:goals/utils/functions.dart";
import "package:goals/utils/goal.dart";

class CreateGoal extends StatefulWidget {
  final GoalClass goal;

  CreateGoal(this.goal);

  @override
  State<StatefulWidget> createState() {
    return CreateGoalState(this.goal);
  }
}

class CreateGoalState extends State<CreateGoal> {
  DatabaseHelper helper = DatabaseHelper();

  GoalClass goal;

   TextEditingController inputGoalTitleController = TextEditingController();
   TextEditingController inputGoalBodyController = TextEditingController();

  CreateGoalState(this.goal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.brown,
        title: Text("Menu Coffee Shop",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                letterSpacing: 1.5)),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                Hero(
                  tag: "",
                  child: Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icon.png")))),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Text("Tambah Menu Baru",
                      style: TextStyle(
                          color: invertColors(context),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          letterSpacing: 1.5)),
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(
                    color: invertColors(context),
                  ),
                  controller: inputGoalTitleController,
                  onChanged: (title) {
                    updateTitle();
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: invertColors(context)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder(),
                      labelText: "Nama Menu",
                      hintText: "Ketikkan Menu",
                      labelStyle: TextStyle(
                        color: invertColors(context),
                      ),
                      hintStyle: TextStyle(
                        color: invertColors(context),
                      ),
                      contentPadding: const EdgeInsets.all(15.0)),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(
                    color: invertColors(context),
                  ),
                  controller: inputGoalBodyController,
                  onChanged: (body) {
                    updateBody();
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: invertColors(context)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder(),
                      labelText: "Harga",
                      hintText: "Ketikkan Harga",
                      labelStyle: TextStyle(
                        color: invertColors(context),
                      ),
                      hintStyle: TextStyle(
                        color: invertColors(context),
                      ),
                      contentPadding: const EdgeInsets.all(15.0)),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveGoal();
        },
        child: Icon(Icons.check),
        foregroundColor: MyColors.light,
        backgroundColor: Colors.redAccent,
        elevation: 3.0,
        heroTag: "fab",
      ),
    );
  }

  void updateTitle() {
    goal.title = inputGoalTitleController.text;
  }

  void updateBody() {
    goal.body = inputGoalBodyController.text;
  }

  void saveGoal() async {
    Navigator.pop(context);
    if (goal.title.length > 0) {
      if (goal.id == null) {
        await helper.createGoal(goal);
      } else {
        await helper.updateGoal(goal);
      }
    }
  }
}