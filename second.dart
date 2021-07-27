import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:desktop_window/desktop_window.dart';
import 'db.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int correct = 0, wrong = 0, left = quiz.length, choice = -1, currentQues = 0;
  bool goNext = false;

  void check() {
    if (choice == quiz[currentQues]['a']) {
      setState(() {
        correct++;
      });
    } else {
      setState(() {
        wrong++;
      });
    }
    goNext = true;
  }

  @override
  void initState() {
    super.initState();

    DesktopWindow.setFullScreen(true);
  }

  void changeOption(int n) {
    setState(() {
      if (choice == n)
        choice = -1;
      else
        choice = n;
    });
  }

  Widget optionsButton(int n, double size, double height, double width) {
    return MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        height: height,
        minWidth: width,
        splashColor: selectedOption,
        elevation: 4,
        color: (!goNext)
            ? ((choice == n) ? selectedOption : nonSelectedOption)
            : (n == quiz[currentQues]['a'])
                ? correctOption
                : nonSelectedOption,
        child: Text(
          quiz[currentQues]['o$n'],
          style: TextStyle(
            fontSize: size,
            color: optionText,
          ),
        ),
        onPressed: () {
          if (!goNext) changeOption(n);
        });
  }

  void reachedEnd() {
    //TODO display end of quiz instead of currentQues = 0;
    currentQues = 0;
    correct = 0;
    wrong = 0;
    left = quiz.length;
    choice = -1;
    currentQues = 0;
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
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0)),
                      color: Color(0xFFFEFEFE),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            padding: EdgeInsets.only(
                                left: constraints.maxWidth * 0.015,
                                top: constraints.maxHeight * 0.02),
                            icon: Icon(
                              Icons.arrow_back,
                              size: constraints.maxHeight * 0.04,
                              color: Color(0xff0F1108),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              //TODO are you sure you want to exit
                            },
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                constraints.maxWidth * 0.035,
                                constraints.maxHeight * 0.04,
                                constraints.maxWidth * 0.035,
                                constraints.maxHeight * 0.04),
                            child: Image.network(
                              quiz[currentQues]['img'],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                constraints.maxWidth * 0.035,
                                constraints.maxHeight * 0.04,
                                constraints.maxWidth * 0.035,
                                constraints.maxHeight * 0.04),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: constraints.maxHeight * 0.12,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            correct.toString(),
                                            style: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.035,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff0F1108)),
                                          ),
                                          Text(
                                            'Correct',
                                            style: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.02,
                                                color: Color(0xff0F1108)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: constraints.maxWidth * 0.0032,
                                      height: constraints.maxHeight * 0.12,
                                      color: Color(0xFFF6F6F6),
                                    ),
                                    Container(
                                      height: constraints.maxHeight * 0.12,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            wrong.toString(),
                                            style: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.035,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff0F1108)),
                                          ),
                                          Text(
                                            'Wrong',
                                            style: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.02,
                                                color: Color(0xff0F1108)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: constraints.maxHeight * 0.0055,
                                  width: double.infinity,
                                  color: Color(0xFFF6F6F6),
                                ),
                                Container(
                                  height: constraints.maxHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        left.toString(),
                                        style: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * 0.035,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff0F1108)),
                                      ),
                                      Text(
                                        'Remaining',
                                        style: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * 0.02,
                                            color: Color(0xff0F1108)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: constraints.maxWidth * 0.05,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Color(0xFFFEFEFE),
                            ),
                          ),
                          Container(
                            width: constraints.maxWidth * 0.006,
                            color: Color(0xFF017EB4),
                          ),
                          Expanded(
                            child: Container(
                              color: Color(0xFFF6F6F6),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: constraints.maxWidth * 0.006,
                              color: Color(0xFF017EB4),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Color(0xFF017EB4),
                            child: Center(
                              child: Text((currentQues + 1).toString(),
                                  style: TextStyle(
                                      fontSize: constraints.maxHeight * 0.025,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff0F1108))),
                            ),
                            radius: constraints.maxWidth * 0.025,
                          ),
                          Expanded(
                            child: Container(
                              width: constraints.maxWidth * 0.006,
                              color: Color(0xFFE4E4E4),
                            ),
                          ),
                          if ((currentQues + 1) <= quiz.length - 1)
                            CircleAvatar(
                              backgroundColor: Color(0xFFE4E4E4),
                              child: Text((currentQues + 2).toString(),
                                  style: TextStyle(
                                      fontSize: constraints.maxHeight * 0.025,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff0F1108))),
                              radius: constraints.maxWidth * 0.025,
                            ),
                          if ((currentQues + 1) <= quiz.length - 1)
                            Expanded(
                              child: Container(
                                width: constraints.maxWidth * 0.006,
                                color: Color(0xFFE4E4E4),
                              ),
                            ),
                          if ((currentQues + 1) <= quiz.length - 2)
                            CircleAvatar(
                              backgroundColor: Color(0xFFE4E4E4),
                              child: Text((currentQues + 3).toString(),
                                  style: TextStyle(
                                      fontSize: constraints.maxHeight * 0.025,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff0F1108))),
                              radius: constraints.maxWidth * 0.025,
                            ),
                          if ((currentQues + 1) <= quiz.length - 2)
                            Expanded(
                              child: Container(
                                width: constraints.maxWidth * 0.006,
                                color: Color(0xFFE4E4E4),
                              ),
                            ),
                          if ((currentQues + 1) <= quiz.length - 3)
                            CircleAvatar(
                              backgroundColor: Color(0xFFE4E4E4),
                              child: Text((currentQues + 4).toString(),
                                  style: TextStyle(
                                      fontSize: constraints.maxHeight * 0.025,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff0F1108))),
                              radius: constraints.maxWidth * 0.025,
                            ),
                          if ((currentQues + 1) <= quiz.length - 3)
                            Expanded(
                              child: Container(
                                width: constraints.maxWidth * 0.006,
                                color: Color(0xFFE4E4E4),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(
                          constraints.maxWidth * 0.035,
                          constraints.maxHeight * 0.04,
                          constraints.maxWidth * 0.015,
                          constraints.maxHeight * 0.04),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                            topLeft: Radius.circular(0.0),
                            bottomLeft: Radius.circular(0.0)),
                        color: Color(0xFFF6F6F6),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * 0.08,
                                        width: constraints.maxWidth * 0.45,
                                        child: Text(
                                          quiz[currentQues]['q'],
                                          style: TextStyle(
                                            color: questionTextColor,
                                            fontSize:
                                                constraints.maxHeight * 0.04,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.volume_up,
                                        ),
                                        iconSize: constraints.maxWidth * 0.04,
                                        onPressed: () {
//                                          speak('Remove this line if you wish to publish to hi');
//                                        TODO audio
                                        },
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: constraints.maxHeight * 0.1,
                                        top: constraints.maxHeight * 0.05),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        optionsButton(
                                            1,
                                            constraints.maxHeight * 0.02,
                                            constraints.maxHeight * 0.2,
                                            constraints.maxHeight * 0.2),
                                        optionsButton(
                                            2,
                                            constraints.maxHeight * 0.02,
                                            constraints.maxHeight * 0.2,
                                            constraints.maxHeight * 0.2),
                                        optionsButton(
                                            3,
                                            constraints.maxHeight * 0.02,
                                            constraints.maxHeight * 0.2,
                                            constraints.maxHeight * 0.2),
                                        optionsButton(
                                            4,
                                            constraints.maxHeight * 0.02,
                                            constraints.maxHeight * 0.2,
                                            constraints.maxHeight * 0.2),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  (choice != -1 && !goNext)
                                      ? MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          minWidth: constraints.maxWidth * 0.12,
                                          height: constraints.maxHeight * 0.08,
                                          splashColor: selectedOption,
                                          elevation: 0,
                                          color: button,
                                          child: Text(
                                            "Check Answer",
                                            style: TextStyle(
                                              fontSize:
                                                  constraints.maxHeight * 0.02,
                                              color: text,
                                            ),
                                          ),
                                          onPressed: () {
                                            check();
                                            //TODO show animation of ay you got it right or you got it wrong
                                          })
                                      : SizedBox(),
                                  (goNext)
                                      ? MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          minWidth: constraints.maxWidth * 0.12,
                                          height: constraints.maxHeight * 0.08,
                                          splashColor: selectedOption,
                                          elevation: 0,
                                          color: button,
                                          child: Text(
                                            "Next Question",
                                            style: TextStyle(
                                              fontSize:
                                                  constraints.maxHeight * 0.02,
                                              color: text,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (left > 0) left--;
                                              choice = -1;
                                              if (currentQues ==
                                                  quiz.length - 1)
                                                reachedEnd();
                                              else
                                                currentQues++;
                                            });
                                            goNext = false;
                                          })
                                      : SizedBox(),
                                ],
                              )),
                        ],
                      )),
                ),
              ],
            ),
          ),
        );
      })),
    );
  }
}
