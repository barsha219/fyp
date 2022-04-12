import 'dart:developer';

import 'package:beauty_store/models/blog_models.dart';
import 'package:beauty_store/services/blog.service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewBlog extends StatefulWidget {
  const ViewBlog({Key? key}) : super(key: key);

  @override
  State<ViewBlog> createState() => _ViewBlogState();
}

class _ViewBlogState extends State<ViewBlog> {
  @override
  void initState() {
    super.initState();
    init();
  }

  bool isloading = false;
  List<Blog>? blogs;

  init() async {
    setState(() {
      isloading = true;
    });
    blogs = await BlogService().fetchAllBlogs();
    setState(() => isloading = false);
  }

  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Blogs"),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: Colors.amber,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) =>
                        StatefulBuilder(builder: (context, msetState) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Add Category',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 20),
                                  TextField(
                                    style: const TextStyle(fontSize: 15),
                                    onChanged: (value) {},
                                    controller: title,
                                    decoration: const InputDecoration(
                                        labelText: 'Enter Title'),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    minLines:
                                        6, // any number (It works as the rows for the textarea)
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,

                                    style: const TextStyle(fontSize: 15),
                                    onChanged: (value) {},
                                    controller: description,
                                    decoration: const InputDecoration(
                                        hintText: 'Enter Description'),
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        if (title.text.trim().isEmpty &&
                                            title.text.trim().isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Title and Category Required");
                                        } else {
                                          try {
                                            msetState(() {
                                              isloading = true;
                                            });
                                            await BlogService().addBlogs(
                                                title.text, description.text);
                                            await init();
                                            title.clear();
                                            description.clear();
                                            Navigator.pop(context);
                                            msetState(() {
                                              isloading = false;
                                            });
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Blog Created Successfully");
                                          } catch (e) {
                                            log(e.toString());
                                          }
                                        }
                                      },
                                      child: isloading
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text('Submit'))
                                ],
                              ),
                            ),
                          );
                        }));
              },
              icon: const Icon(
                Icons.upload,
                size: 30,
              )),
        ],
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ))
          : ListView.builder(
              itemCount: blogs?.length ?? 0,
              itemBuilder: (context, index) => ListTile(
                title: Text(blogs?[index].title ?? ""),
                trailing: IconButton(
                    onPressed: () async {
                      setState(() {
                        isloading = true;
                      });
                      try {
                        await BlogService().deleteBlogs(blogs?[index].id ?? "");
                        blogs!.remove(blogs?[index]);
                        setState(() {});
                        setState(() {
                          isloading = false;
                        });
                        Fluttertoast.showToast(
                            msg: "Blog Deleted Successfully");
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                    icon: isloading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.delete)),
              ),
            ),
    );
  }
}
