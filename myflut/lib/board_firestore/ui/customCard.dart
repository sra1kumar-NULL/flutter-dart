import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
class CustomCard extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int index;
  const CustomCard(this.snapshot, this.index);
  @override
  Widget build(BuildContext context) {
    var snapshotData = snapshot.data!.docs[index];
    var timeToDate=new DateTime.fromMicrosecondsSinceEpoch(snapshotData['timestamp'].seconds*1000);
    var dateFormatted=new DateFormat("EEEE, MM d,y").format(timeToDate);
    return Column(
      children: [
        Container(
          height: 150,
          child: Card(
            elevation: 11,
            child:Column(
              children: [
                ListTile(
                  title: Text(snapshotData['title']),
                  leading: CircleAvatar(
                    radius: 34,
                    child: Text(snapshotData['title'][0].toString()),
                  ),
                  subtitle: Text(snapshotData['description']),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("By: ${snapshotData['name']}"),
                    SizedBox(width:9,),
                    Text(dateFormatted),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(onPressed: () { }
                      , icon: Icon(FontAwesomeIcons.edit),iconSize: 15,),
                    SizedBox(height: 17,),
                    IconButton(onPressed: () { }
                      , icon: Icon(FontAwesomeIcons.trashAlt),iconSize: 15,)
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

}
