import 'dart:async';

import 'package:flutter_archive/models/blog_post.dart';

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
List<BlogPost> _blogPosts = blogPosts;

class BlogPostViewModel {
  StreamController<List<BlogPost>> _streamController =
      StreamController.broadcast();
  Stream<List<BlogPost>> get getBlogPost => _streamController.stream;
  Sink<List<BlogPost>> get setBlogPost => _streamController.sink;

  BlogPostViewModel() {
    Future.delayed(Duration(seconds: 3))
        .then((_) => setBlogPost.add(blogPosts));
  }
  void addBlogPost(BlogPost blogPost) {
    setBlogPost.add(blogPosts);
  }
}
