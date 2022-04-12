import 'package:beauty_store/models/blog_models.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BlogView extends StatefulWidget {
  final Blog blog;
  const BlogView({Key? key, required this.blog}) : super(key: key);

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white70),
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.blog.title ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            elevation: 0,
            color: Colors.white.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 15),
                  Text(
                    widget.blog.description ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
