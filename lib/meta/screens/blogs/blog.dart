import 'package:beauty_store/meta/screens/blogs/blogView.dart';
import 'package:beauty_store/models/blog_models.dart';
import 'package:beauty_store/services/blog.service.dart';
import 'package:flutter/material.dart';

class BlogList extends StatefulWidget {
  const BlogList({Key? key}) : super(key: key);

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  bool isloading = false;
  List<Blog>? _blogs;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setState(() {
      isloading = true;
    });
    _blogs = await BlogService().fetchAllBlogs();
    setState(() => isloading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blogs"),
        centerTitle: true,
        // elevation: 0,
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : ListView.builder(
              itemCount: _blogs?.length ?? 0,
              itemBuilder: (context, index) => ListTile(
                title: Text(_blogs?[index].title ?? ""),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogView(
                      blog: _blogs![index],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
