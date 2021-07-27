import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/db.dart';
import 'quiz_screen.dart';
import 'colors.dart';
import 'package:desktop_window/desktop_window.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int userId = -1;

  @override
  initState() {
    super.initState();
    DesktopWindow.setFullScreen(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF02A0E8),
      body: SafeArea(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
              constraints.maxWidth * 0.05,
              constraints.maxHeight * 0.05,
              constraints.maxWidth * 0.05,
              constraints.maxHeight * 0.05),
          child: Material(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset('images/5187554.jpg'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: constraints.maxHeight * 0.12,
                          bottom: constraints.maxHeight * 0.12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: constraints.maxHeight * 0.15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'images/Untitled.png',
                                  height: constraints.maxHeight * 0.15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Unitiate Organization',
                                        style: TextStyle(
                                            color: optionText,
                                            fontSize:
                                                constraints.maxHeight * 0.06,
                                            fontWeight: FontWeight.bold)),
                                    Text('Online Exam',
                                        style: TextStyle(
                                          color: optionText,
                                          fontSize:
                                              constraints.maxHeight * 0.04,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.06,
                          ),
                          Container(
                            height: constraints.maxHeight * 0.069,
                            width: constraints.maxWidth * 0.3,
                            child: TextField(
                              style: TextStyle(
                                color: optionText,
                                fontSize: constraints.maxHeight * 0.024,
                              ),
                              cursorColor: optionText,
                              decoration: InputDecoration(
                                labelText: 'Input your Student ID',
                              ),
                              onChanged: (value) {
                                if (int.tryParse(value) != null)
                                  userId = int.parse(value);
                                else
                                  userId = -1;
                              },
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.06,
                          ),
                          Container(
                            height: constraints.maxHeight * 0.069,
                            width: constraints.maxWidth * 0.3,
                            child: TextField(
                              style: TextStyle(
                                color: optionText,
                                fontSize: constraints.maxHeight * 0.024,
                              ),
                              cursorColor: optionText,
                              decoration: InputDecoration(
                                labelText: 'Input your Student password',
                              ),
                              onChanged: (value) {
                                //TODO password record
                              },
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.1,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            minWidth: constraints.maxWidth * 0.08,
                            height: constraints.maxHeight * 0.08,
                            splashColor: Colors.white,
                            elevation: 0,
                            color: button,
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontSize: constraints.maxHeight * 0.02,
                                color: text,
                              ),
                            ),
                            onPressed: () async {
                              if (await getDB(userId))
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuizScreen()));
                              else
                                print('user not found'); //TODO show dialog
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      })),
    );
  }
}
