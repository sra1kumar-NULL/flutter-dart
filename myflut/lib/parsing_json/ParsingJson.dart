import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class JsonParsingSimple extends StatefulWidget {
  const JsonParsingSimple({Key? key}) : super(key: key);

  @override
  _JsonParsingSimpleState createState() => _JsonParsingSimpleState();
}

class _JsonParsingSimpleState extends State<JsonParsingSimple> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Parsing"),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return createListView(snapshot.data, context);
                  //return Text(snapshot.data[0]['title']);
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }

  Widget createListView(List data, BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(
                  height: 5.0,
                ),
                ListTile(
                  title: Text("${data[index]['title']}"),
                  subtitle: Text("${data[index]['body']}"),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.black,
                    child: Text(
                      "${data[index]['id']}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  Future getData() async {
    Future data;
    Network network = Network("https://jsonplaceholder.typicode.com/posts");
    data = network.fetchData();
    // data.then((value) {
    //   print(value[0]['title']);
    // });
    //print(data);
    return data;
  }
}

class Network {
  final String url;

  Network(this.url);

  Future fetchData() async {
    print("$url");
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      //print(response.body);
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
