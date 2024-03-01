import 'package:flutter/material.dart';
import 'package:flutter_archive/models/blog_post.dart';

class BlogModify extends StatelessWidget {
  final BlogPost? blogPost;

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _authorController = TextEditingController();

  bool get isEditing => blogPost != null;

  BlogModify({this.blogPost, super.key}) {
    if (isEditing) {
      _titleController.text = blogPost!.title;
      _contentController.text = blogPost!.author;
      _authorController.text = blogPost!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Blog' : 'Create Blog')),
      body: Center(
        child: Column(children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: _authorController,
            decoration: const InputDecoration(hintText: 'Author'),
          ),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(hintText: 'Content'),
          ),
        ]),
      ),
    );
  }
}
