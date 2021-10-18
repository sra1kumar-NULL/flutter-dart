import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:myflut/model/Post.dart';

class ParsingJsonMap extends StatefulWidget {
  const ParsingJsonMap({Key? key}) : super(key: key);

  @override
  _ParsingJsonMapState createState() => _ParsingJsonMapState();
}

class _ParsingJsonMapState extends State<ParsingJsonMap> {
  late Future<PostList> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Network network = Network("https://jsonplaceholder.typicode.com/posts");
    data = network.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PODO"),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: data,
              builder: (context, AsyncSnapshot<PostList> snapshot) {
                List<Post> allPosts;
                if (snapshot.hasData) {
                  allPosts = snapshot.data!.posts;
                  return createListView(allPosts, context);
                  //return Text("${allPosts[0].title}");
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }
  Widget createListView(List<Post> data, BuildContext context) {
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
                  title: Text("${data[index].title}"),
                  subtitle: Text("${data[index].body}"),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.amberAccent,
                    child: Text(
                      "${data[index].id}",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}

class Network {
  final String url;

  Network(this.url);

  Future<PostList> loadData() async {
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      //print(response.body);
      return PostList.fromJson(json.decode(response.body));
    } else {
      throw Exception("cannot load any posts");
    }
  }
}
