import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  final FirebaseUser user;

  HomePage(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Instagram',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: _buildBody(),);
  }

  Widget _buildBody() {
    return Padding(padding: EdgeInsets.all(8.0),
        child: SafeArea( // SafeArea : 아이폰 상단 노치로인해 사용
          child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                  Text('Instagram에 오신 것을 환영합니다.',
                      style: TextStyle(fontSize: 24.0)),
                  Padding(padding: EdgeInsets.all(8.0)),
                  Text('사진과 동영상을 보려면 팔로우하세요',),
                    Padding(padding: EdgeInsets.all(16.0)),
                    SizedBox(//감싸고 있는 자식 위젯의 크기를 정해주는 위젯
                      width: 260.0,
                      child: Card(
                        elevation: 4.0,
                        child: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(8.0)),
                            SizedBox(
                              width: 80.0,
                              height: 80.0,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(user.photoUrl),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(8.0)),
                            Text(user.email,style: TextStyle(fontWeight: FontWeight.bold),), //StatelessWidget에서는 클래스가 하나여서 전역 변수 user에 어디서나 접근 가능
                            Text(user.displayName),
                            Padding(padding: EdgeInsets.all(8.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 70.0,
                                  height: 70.0,
                                  child: Image.network(
                                      'https://img4.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net'
                                          '/news/202101/17/STNSPORTS/20210117174826717ccmz.png', fit: BoxFit.cover,),
                                ),
                                Padding(padding: EdgeInsets.all(1.0)),
                                SizedBox(
                                  width: 70.0,
                                  height: 70.0,
                                  child: Image.network('https://img4.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net'
                                      '/news/202101/17/STNSPORTS/20210117174826717ccmz.png', fit: BoxFit.cover),
                                ),
                                Padding(padding: EdgeInsets.all(1.0)),
                                SizedBox(
                                  width: 70.0,
                                  height: 70.0,
                                  child: Image.network('https://img4.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net'
                                      '/news/202101/17/STNSPORTS/20210117174826717ccmz.png', fit: BoxFit.cover),
                                )
                              ],
                            ),
                            Padding(padding: EdgeInsets.all(4.0)),
                            Text('Facebook 친구'),
                            Padding(padding: EdgeInsets.all(4.0)),
                            RaisedButton(
                              child: Text('팔로우'),
                                color: Colors.blueAccent,
                                textColor: Colors.white,
                                onPressed: (){}),
                            Padding(padding: EdgeInsets.all(8.0)),
                          ],
                        ),
                      ),
                    )
                  ],),
              )
          ),
        )
    );
  }
}
