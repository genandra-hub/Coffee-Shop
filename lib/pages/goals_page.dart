import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goals/pages/create_page.dart';
import 'package:goals/pages/edit_page.dart';
import 'package:goals/utils/database_helper.dart';
import 'package:goals/utils/functions.dart';
import 'package:goals/utils/goal.dart';
import 'package:goals/utils/widgets.dart';
import 'package:sqflite/sqflite.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<GoalClass> goalsList;
  int len = 0;

  void _changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        isThemeCurrentlyDark(context) ? Brightness.light : Brightness.dark);
  } 

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initDatabase();
    dbFuture.then((database) {
      Future<List<GoalClass>> goalsListFuture = databaseHelper.getGoalsList();
      goalsListFuture.then((goalsList) {
        setState(() {
          this.goalsList = goalsList;
          this.len = goalsList.length;
          if (this.len == 0) {
            noGoals = true;
          } else {
            noGoals = false;
          }
        });
      });
    });
  }

  void navigateToCreateGoal(GoalClass goal) async {
    await Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return CreateGoal(goal);
    }));
    updateListView();
  }

  void navigateToEditGoal(GoalClass goal) async {
    await Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return EditGoal(goal);
    }));
    updateListView();
  }

  Widget buildGoalsList() {
    double _width = MediaQuery.of(context).size.width * 0.75;

    return Container(
      child: ListView.builder(
        itemCount: len,
        itemBuilder: (BuildContext context, int id) {
          return buildTile(
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Hero(
                        tag: "dartIcon${this.goalsList[id].index}",
                        child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/target.png")))),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 8.0),
                      Container(
                        width: _width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              this.goalsList[id].title,
                              style: TextStyle(
                                  color: invertColors(context),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Text(
                              this.goalsList[id].body,
                              style: TextStyle(
                                  color: invertColors(context), fontSize: 16.0),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                            SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
            onTap: () => navigateToEditGoal(this.goalsList[id]),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController _myPage = PageController(initialPage: 0);
    if (goalsList == null) {
      goalsList = List<GoalClass>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("COFFEE SHOP!",
            style: TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.brown)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: isThemeCurrentlyDark(context)
                ? Icon(EvaIcons.sun) //use sun icon
                : Icon(EvaIcons.moon), //use moon icon
            tooltip: isThemeCurrentlyDark(context)
                ? "BURN YOUR EYES"
                : "SAVE YOUR EYES",
            onPressed: _changeBrightness,
            color: Colors.brown
          ),
        ],
      ),
       body: PageView(
        controller: _myPage,
        children: <Widget>[
          noGoals == true ? buildEmptyPage(context) : buildGoalsList()
        ],
      ),
      
      bottomNavigationBar: BottomAppBar(child: 
        Container(height: 55.0,
          child: RaisedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Icon(Icons.create, size: 24.0, color: Colors.white), SizedBox(width: 10.0), 
            Text("Tambah Menu", style: TextStyle(letterSpacing: 1.0, color: Colors.white, fontSize: 17.0))],),
          color: Colors.brown,
          elevation: 1.0,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          onPressed: () {
          navigateToCreateGoal(GoalClass("", ""));
        },
        ))),
    );
  }
}
