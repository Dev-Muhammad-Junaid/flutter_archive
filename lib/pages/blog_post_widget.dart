import 'package:flutter_archive/models/blog_post.dart';
import 'package:flutter_archive/pages/blog_post_edit.dart';
import 'package:flutter_archive/viewmodels/blog_post_vm.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

class BlogPostWidget extends StatelessWidget {
  BlogPostViewModel get _viewmodel => GetIt.I<BlogPostViewModel>();

  BlogPostWidget({super.key});

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
            const Text("Todays Special"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 500,
                width: double.infinity,
                child: StreamBuilder<List<BlogPost>>(
                    stream: _viewmodel.getBlogPost,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                            alignment: Alignment.center,
                            color: Colors.amber,
                            width: 50,
                            height: 50,
                            child: const CircularProgressIndicator(
                              color: Colors.red,
                            ));
                      }
                      final blogPosts = snapshot.data;
                      return ListView.builder(
                          itemCount: blogPosts!.length,
                          itemBuilder: (BuildContext context, index) {
                            final singleBlog = blogPosts[index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        BlogModify(blogPost: singleBlog)));
                              },
                              child: Card(
                                child: Text(
                                  singleBlog.title,
                                  style: const TextStyle(
                                      fontSize: 30, color: Colors.amber),
                                ),
                              ),
                            );
                          });
                    }),
              ),
            )
          ],
        ));
  }
}
