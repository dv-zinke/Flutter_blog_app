import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog_app/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName, title, desc;

  CrudMethods crudMethods = new CrudMethods();
  bool _isLoading = false;

  File selectedImage;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(pickedFile.path);
    });
  }

  uploadBlog() async {
    if (selectedImage != null) {

      setState((){
        _isLoading = true;
      });
      StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}");

      final StorageUploadTask task = firebaseStorageRef.putFile(selectedImage);

      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
      print("this is url$downloadUrl");

      Map<String, String> blogMap = {
        "image" : downloadUrl,
        "name" : authorName,
        "title" : title,
        "desc" : desc
      };

      crudMethods.addData(blogMap).then( (result){
        Navigator.pop(context);
      });

    } else {}
  }

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
            GestureDetector(
              onTap: () {
                uploadBlog();
              },
              child: Container(
                child: Icon(Icons.file_upload),
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
            )
          ],
        ),
        body: _isLoading
            ? Container(
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              )
            : Container(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: selectedImage != null
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    selectedImage,
                                    fit: BoxFit.cover,
                                  )),
                              width: MediaQuery.of(context).size.width,
                            )
                          : Container(
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
