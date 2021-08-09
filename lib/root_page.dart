import 'package:flutter/material.dart';
import 'package:flutter_instagram/login_page.dart';
import 'package:flutter_instagram/tab_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,//인증이 되거나 끊어졌을때 변경된 상태에 따라서 stream이 들어오도록
        builder: (BuildContext context,AsyncSnapshot snapshot){ // snapshot : firebase의 유저 정보가 들어옴
            if(snapshot.hasData){
              return TabPage(snapshot.data);
            }else{
              return LoginPage();
            }
        }); //StreamBuilder:리엑티브 프로그래밍이 가능한 언어. 데이터의 흐름에 반응하도록 할 수 있다.
  }
}
