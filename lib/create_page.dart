import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreatePage extends StatefulWidget {
  final FirebaseUser user;

  CreatePage(this.user);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final textEditingController = TextEditingController();//화면이 없어질때 해제 시켜줘야한느 객체

  File _image;
  @override
  void dispose() {
    textEditingController.dispose(); // 메모리 해제
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(onPressed: _getImage,child: Icon(Icons.add_a_photo),),
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      actions: <Widget>[
        IconButton(onPressed: (){
          final firebaseStorageRef = FirebaseStorage.instance
              .ref()
              .child('post')
              .child('${DateTime.now().millisecondsSinceEpoch}.png');
          final task = firebaseStorageRef.putFile(
            _image, StorageMetadata(contentType: 'image/png'));

          task.onComplete.then((value) {
              var downLoadUrl = value.ref.getDownloadURL();

              downLoadUrl.then((uri) {
                var doc = Firestore.instance.collection('post').document();//firestore에 post라는 컬렉션을 만들고 새로운 문서를 만들어 그 문서를 지칭
                doc.setData({
                  'id': doc.documentID,
                  'photoUrl' : uri.toString(),
                  'contents' : textEditingController.text,
                  'email' : widget.user.email,
                  'displayName': widget.user.displayName,
                  'userPhotoUrl' : widget.user.photoUrl
                }).then((value) {
                  Navigator.pop(context);//이전화면으로 돌아감
                });
              });
          });
        }, icon: Icon(Icons.send))
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _image == null? Text('No Image'):Image.file(_image),//이미지 넣기
          TextField(
            decoration: InputDecoration(hintText: '내용을 입력하세요.'),
            controller: textEditingController,
          )
        ],
      ),
    );
  }

  Future _getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}
