import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/create_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/detail_post_page.dart';

class SearchPage extends StatefulWidget {
  final FirebaseUser user;

  SearchPage(this.user);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Instagram',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreatePage(widget.user)));
        },
        child: Icon(Icons.create),
        backgroundColor: Colors.blue,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder(
      stream: Firestore.instance.collection('post').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());//로딩화면
        }

        var items = snapshot.data?.documents ?? [];

        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _buildeListItem(context, items[index]);
            });
        },
    );
  }

  Widget _buildeListItem(context,document) {
    return Hero(
      tag: document['photoUrl'],
      child: Material(
        child: InkWell( //클릭시 물방울이 퍼지는 효과
          onTap:(){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return DetailPostPage(document);
            }));
          },
          child: Image.network(
              document['photoUrl'], //'photoUrl'이라는 키값을 갖는 문서를 갖고옴
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
