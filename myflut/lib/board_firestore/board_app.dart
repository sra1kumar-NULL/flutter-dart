import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myflut/board_firestore/ui/customCard.dart';

class BoardApp extends StatefulWidget {
  const BoardApp({Key? key}) : super(key: key);

  @override
  _BoardAppState createState() => _BoardAppState();
}

class _BoardAppState extends State<BoardApp> {
  var firestoreDb = FirebaseFirestore.instance.collection("board").snapshots();
  late TextEditingController nameInputController;
  late TextEditingController titleInputController;
  late TextEditingController descriptionInputController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameInputController = new TextEditingController();
    titleInputController = new TextEditingController();
    descriptionInputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "COMMUNITY BOARD",
          style:
              TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          __showDialog(context);
        },
        child: Icon(FontAwesomeIcons.pen),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestoreDb,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, int index) {
                  return CustomCard(snapshot,index);
                });
          }),
    );
  }

  __showDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.all(10),
              content: Column(
                children: [
                  Text("Please Enter the name"),
                  Expanded(
                    child: TextField(
                      autocorrect: true,
                      autofocus: true,
                      decoration: InputDecoration(labelText: "Your Name *"),
                      controller: nameInputController,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      autocorrect: true,
                      autofocus: true,
                      decoration: InputDecoration(labelText: "Your Title *"),
                      controller: titleInputController,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      autocorrect: true,
                      autofocus: true,
                      decoration:
                          InputDecoration(labelText: "Your Description *"),
                      controller: descriptionInputController,
                    ),
                  )
                ],
              ),
              actions: [
                FlatButton(
                    onPressed: () => {
                          nameInputController.clear(),
                          titleInputController.clear(),
                          descriptionInputController.clear(),
                          Navigator.pop(context),
                        },
                    child: Text("Cancel")),
                FlatButton(
                  onPressed: () => {
                    if (nameInputController.text.isNotEmpty &&
                        titleInputController.text.isNotEmpty &&
                        descriptionInputController.text.isNotEmpty)
                      {
                        FirebaseFirestore.instance.collection("board")
                            .add({
                          "name":nameInputController.text,
                          "title":titleInputController.text,
                          "description":descriptionInputController.text,
                          "timestamp":new DateTime.now()
                        }).then((response) => {print(response.id),
                        Navigator.pop(context),
                        nameInputController.clear(),
                        titleInputController.clear(),
                        descriptionInputController.clear()})
                      }
                  },
                  child: Text("Save"),
                )
              ],
            ));
  }
}
