import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog_app/services/crud.dart';
import 'package:flutter_firebase_blog_app/views/create_blog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();

  Stream blogsStream;

  Widget blogsList() {
    return Container(
      child: Column(
        children: [
          blogsStream != null
              ? Column(
            children: [
              StreamBuilder(
                stream: blogsStream,
                builder: (context, snapshot) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      return BlogsTile(
                        authorName: snapshot.data.docs[index].data()['name'],
                        title: snapshot.data.docs[index].data()['title'],
                        description: snapshot.data.docs[index].data()['desc'],
                        imgUrl: snapshot.data.docs[index].data()['image'],
                      );
                    },
                    itemCount: snapshot.data.docs.length,
                    shrinkWrap: true,
                  );
                },
              )
            ],
          )
              : Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
        ],
      ),
    );
  }

  @override
  void initState() {

    crudMethods.getData().then((result) {
      print(result);
      blogsStream = result;
    });

    super.initState();


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
      ),
      body: blogsList(),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateBlog()));
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

class BlogsTile extends StatelessWidget {
  String imgUrl, title, description, authorName;

  BlogsTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.description,
      @required this.authorName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 150,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              )),
          Container(
            height: 170,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4,),
                Text(description, style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w400
                ),),
                SizedBox(height: 4,),
                Text(authorName)
              ],
            ),
          )
        ],
      ),
    );
  }
}
