import 'package:flutter/material.dart';
import 'package:flutter_instagram/tab_page.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;//계정에 대한 하나의 객체만 갖고있음

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Instagram',
              style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold,)
              ,),
            Padding(
              padding: EdgeInsets.all(50.0),
            ),
            SignInButton(
                Buttons.Google,
                onPressed: (){
                  _handleSignIn().then((user){//비동기 처리시 처리 결과가 then함수의 user객체에 에 들어옴
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)=>TabPage(user)));
                  });
                })
          ],
        )
      )
    );
  }
  Future<FirebaseUser> _handleSignIn() async{ //로그인 요청을하고 응답이 올 떄 까지 기다리는 비동기 방식으로 구현
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;//firebase와 연결을 하기위해 객체로 선언
    FirebaseUser user = await _auth.signInWithCredential(
      GoogleAuthProvider.getCredential(idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken)
    );
    return user;
  }
}
