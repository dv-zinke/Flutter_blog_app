import 'package:flutter/material.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName, title, desc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Flutter", style: TextStyle(fontSize: 22)),
              Text(
                "Blog",
                style: TextStyle(fontSize: 22, color: Colors.blue),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Container(
              child: Icon(Icons.file_upload),
              padding: EdgeInsets.symmetric(horizontal: 10),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                child: Icon(
                  Icons.add_a_photo,
                  color: Colors.black45,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: "이름"),
                      onChanged: (val) {
                        authorName = val;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "제목"),
                      onChanged: (val) {
                        title = val;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "상세 내용"),
                      onChanged: (val) {
                        desc = val;
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
