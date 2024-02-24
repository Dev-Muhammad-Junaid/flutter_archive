import 'dart:async';

import 'package:flutter_archive/models/blog_post.dart';


class BlogPostViewModel {
  StreamController<List<BlogPost>> _streamController = StreamController.broadcast();
  Stream<List<BlogPost>> get GetBlogPost => _streamController.stream;
  Sink<List<BlogPost>> get SetBlogPost => _streamController.sink;
}