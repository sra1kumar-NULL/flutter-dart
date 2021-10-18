class PostList{
  final List<Post> posts;
  PostList({required this.posts});
  factory PostList.fromJson(List<dynamic> parsedJson){
    List<Post> posts; //=new List<Post>();
    posts=parsedJson.map((i) => Post.fromJson(i)).toList();
    return new PostList(posts: posts);
  }
}


class Post {
  int id;
  int userId;
  String body;
  String title;

  Post({required this.id, required this.userId, required this.body,required this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        userId: json['userId'],
        body: json['body'],
        title: json['title']

    );
  }
}
