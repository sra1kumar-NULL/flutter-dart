import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:myflut/model/Question.dart';

class MoviesListView extends StatelessWidget {
  //const MoviesListView({Key? key}) : super(key: key);
  List movies = [
    "rambo",
    "pursuit of happiness",
    "titanic",
    "mr.robot",
    "peaky blinders",
    "kingdom",
    "gladiator",
    "pablo escobar",
    "God Father",
    "Lucifer",
    "Ong Bak",
    "Bruce Lee",
    "Avengers"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade700,
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey.shade200,
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              elevation: 4.7,
              child: ListTile(
                leading: CircleAvatar(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text(
                      "<M>",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                trailing: Text("loading..."),
                title: Text(movies[index]),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MoviesListViewDetails()));
                },
                
                //onTap: ()=>debugPrint("movie name : ${movies.elementAt(index)}"),
                subtitle: Text("subtitles are available"),
              ));
        },
      ),
    );
  }
}

class MoviesListViewDetails extends StatelessWidget {
  const MoviesListViewDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Details"),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text("Go back"),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.blueGrey.shade200,
          ),
        ),
      ),
    );
  }
}

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List questionBank = [
    Question.name("India got independence in 1947", true),
    Question.name("India got independence in 1948", false),
    Question.name("India got independence in 1949", false),
    Question.name("India got independence in 1950", false),
    Question.name("India got independence in 1951", false)
  ];
  int _currentQIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("True CitiZen"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Builder(builder: (BuildContext context) {
        return Container(
          color: Colors.blueGrey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child:
                      Image.asset('images/flag.png', width: 400, height: 300)),
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                        color: Colors.white38, style: BorderStyle.solid)),
                height: 100,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(questionBank[_currentQIndex].questionText,
                      style: TextStyle(fontSize: 18, color: Colors.white70)),
                )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      onPressed: () => _clickVal(true, context),
                      color: Colors.blueGrey,
                      textColor: Colors.white,
                      child: Text("TRUE")),
                  RaisedButton(
                      onPressed: () => _clickVal(false, context),
                      color: Colors.blueGrey,
                      textColor: Colors.white,
                      child: Text("FALSE")),
                  RaisedButton(
                      onPressed: () {
                        setState(() {
                          _currentQIndex =
                              (_currentQIndex + 1) % questionBank.length;
                        });
                      },
                      child: Icon(
                        Icons.forward,
                        color: Colors.white70,
                      ),
                      color: Colors.blueGrey),
                ],
              ),
              Spacer(),
            ],
          ),
        );
      }),
    );
  }

  _clickVal(bool val, BuildContext context) {
    if (val == questionBank[_currentQIndex].isCorrect) {
      debugPrint("Correct");
      final snackbar = SnackBar(
        content: Text("Correct"),
        duration: Duration(milliseconds: 500),
        backgroundColor: Colors.green,
      );
      Scaffold.of(context).showSnackBar(snackbar);
      _updateQ();
    } else {
      final snackbar = SnackBar(
        content: Text("InCorrect"),
        duration: Duration(milliseconds: 500),
        backgroundColor: Colors.redAccent,
      );
      Scaffold.of(context).showSnackBar(snackbar);
      _updateQ();
    }
  }

  _updateQ() {
    setState(() {
      _currentQIndex = (_currentQIndex + 1) % questionBank.length;
    });
  }
}

class BillSplit extends StatefulWidget {
  const BillSplit({Key? key}) : super(key: key);

  @override
  _BillSplitState createState() => _BillSplitState();
}

class _BillSplitState extends State<BillSplit> {
  double _billAmount = 0.0;
  int _persons = 1;
  int _tipPercent = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 120),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
                width: 200,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Per Person Count",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "\$ ${calculateTotalPerPerson(_billAmount, _persons, _tipPercent)}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )),
            Container(
              padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                  )),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    cursorColor: Colors.purple,
                    style: TextStyle(fontSize: 22),
                    decoration: InputDecoration(
                      prefix: Text("Bill Amount"),
                      prefixIcon: Icon(Icons.attach_money_rounded),
                    ),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Split",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.purple)),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_persons > 1) {
                                  _persons--;
                                } else {
                                  //nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.purple.shade100,
                              ),
                              child: Center(
                                child: Text("-",
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                          Divider(),
                          Text(
                            "$_persons",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Colors.purpleAccent.shade100),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _persons++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.purple.shade100,
                              ),
                              child: Center(
                                child: Text("+",
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tip",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "\$ ${calculateTotalTip(_billAmount, _tipPercent)}",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.purpleAccent),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$_tipPercent%",
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.purpleAccent.shade100),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.purpleAccent,
                          inactiveColor: Colors.blueGrey.shade200,
                          divisions: 7,
                          value: _tipPercent.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              _tipPercent = value.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double bill, int split, int percent) {
    var totalAmount = (bill + (calculateTotalTip(bill, percent))) / split;
    return totalAmount.toStringAsFixed(2);
  }

  calculateTotalTip(double bill, int percent) {
    double totalTip = 0;
    if (bill < 0 || bill == null || bill.toString().isEmpty) {
      //
    } else {
      totalTip = (bill * percent) / 100;
    }
    return totalTip;
  }
}

class Wisdom extends StatefulWidget {
  const Wisdom({Key? key}) : super(key: key);

  @override
  _WisdomState createState() => _WisdomState();
}

class _WisdomState extends State<Wisdom> {
  int _index = 0;
  List quotes = ['one', 'two', 'three', 'four', 'five', 'six', 'seven'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 3),
            Center(
              child: Expanded(
                child: Container(
                  color: Colors.brown.shade100,
                  width: 200,
                  height: 100,
                  child: Center(
                    child: Text(
                      quotes[_index % quotes.length],
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: "helvetica",
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: FlatButton.icon(
                  onPressed: _quoteChanger,
                  icon: Icon(Icons.wb_sunny_sharp),
                  color: Colors.greenAccent.shade400,
                  label: Text(
                    "Inspire Me!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: "helvetica",
                    ),
                  )),
            ),
            Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    );
  }

  _quoteChanger() {
    setState(() {
      _index += 1;
    });
  }
}

class BizCard extends StatelessWidget {
  const BizCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Biz Card",
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            _getCard(),
            _getImageRandom(),
          ],
        ),
      ),
    );
  }

  Container _getImageRandom() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(80.0)),
        color: Colors.white,
        border: Border.all(color: Colors.indigoAccent, width: 2.5),
        image: DecorationImage(
            image: NetworkImage("https://picsum.photos/200/300"),
            fit: BoxFit.cover),
      ),
    );
  }

  Container _getCard() {
    return Container(
      width: 324.4,
      height: 222.2,
      margin: EdgeInsets.all(50.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.pinkAccent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Pablo Escobar",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
                wordSpacing: 2),
          ),
          Text(
            "makedrugsonline.com",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_box_rounded,
                size: 33,
                color: Colors.white,
              ),
              Text(
                "Insta : @pabloescoBar",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ScaffoldEx extends StatelessWidget {
  _tappFun() {
    debugPrint("The Alarm Tapped");
  }

  const ScaffoldEx({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scaffold Title"),
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.email),
            onPressed: () => debugPrint("Ths Email button is Tapped"),
          ),
          IconButton(onPressed: _tappFun, icon: Icon(Icons.alarm_on_outlined))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.call_made_rounded),
        onPressed: () => debugPrint("Called me"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded), title: Text("First")),
          BottomNavigationBarItem(
              icon: Icon(Icons.alarm_on_outlined), title: Text("Second"))
        ],
        onTap: (int index) => debugPrint("Tapped on $index item"),
      ),
      body: Material(
        child: Center(child: CustomButton()
            // InkWell(
            //   child: Text(
            //     "This is to Tap",textAlign: TextAlign.center,
            //     style: TextStyle(
            //         fontSize: 23.4,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.redAccent.shade400
            //     ),
            //   ),
            //   onTap: () => debugPrint("On Tapped"),
            //
            // ),

            ),
        color: Colors.blueGrey,
        textStyle: TextStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          fontSize: 45,
          fontFamily: 'RobotoMono',
          color: Colors.white,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(
          content: Text("Bella Caio"),
          backgroundColor: Colors.purple.shade300,
        );
        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.purple.shade300,
            borderRadius: BorderRadius.circular(8.0)),
        child: Text("Click Me"),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.yellowAccent,
        child: Center(
            child: Text("Hello flutter",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey))));
  }
}
