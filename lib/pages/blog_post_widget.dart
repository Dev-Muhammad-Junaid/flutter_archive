import 'package:flutter/material.dart';
import 'package:flutter_archive/models/blog_post.dart';

class BlogPostWidget extends StatelessWidget {
  BlogPostWidget({super.key});

  final blogPosts = [
    BlogPost(
        id: 1,
        title: "Blog Post 1",
        content: "This is my first Blog",
        author: "Junaid",
        publishDate: DateTime.now()),
    BlogPost(
        id: 2,
        title: "Blog Post 2",
        content: "This is my second Blog",
        author: "Ahsan",
        publishDate: DateTime.now()),
    BlogPost(
        id: 3,
        title: "Blog Post 3",
        content: "This is my third Blog",
        author: "Ali",
        publishDate: DateTime.now()),
    BlogPost(
        id: 4,
        title: "Blog Post 4",
        content: "This is my fourth Blog",
        author: "Josh",
        publishDate: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Blogs"),
          leading: Icon(Icons.arrow_back),
          actions: [
            GestureDetector(child: Icon(Icons.add)),
          ],
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text("Todays Special"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 500,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: blogPosts.length,
                    itemBuilder: (BuildContext context, index) {
                      return Card(
                        child: Text(
                          blogPosts.elementAt(index).title,
                          style: TextStyle(fontSize: 30, color: Colors.amber),
                        ),
                      );
                    }),
              ),
            )
          ],
        ));
  }
}
