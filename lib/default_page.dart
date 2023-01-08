import 'dart:convert';

import 'package:chatrooms/messages.dart';
import 'package:chatrooms/rooms.dart';
import 'package:chatrooms/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatrooms/main.dart';

class Chatroompage extends StatefulWidget {
  const Chatroompage({Key? key}) : super(key: key);

  @override
  State<Chatroompage> createState() => _ChatroompageState();
}

class _ChatroompageState extends State<Chatroompage> {


  bool IsCollapsed=true;
  int SelectedIndex=0;
  PageController _pageController=PageController();
  User _user=User.Fromjson(jsonDecode(json!));
  final TextEditingController _ChatControllerMusic=TextEditingController();
  final TextEditingController _ChatControllerDance=TextEditingController();
  final TextEditingController _ChatControllerPhotography=TextEditingController();
  final TextEditingController _ChatControllerRobots=TextEditingController();
  final TextEditingController _ChatControllerMovie=TextEditingController();
  final TextEditingController _ChatControllerProgramming=TextEditingController();
  final List<String> _images=[
    'https://www.pngitem.com/pimgs/m/8-81474_music-studio-logo-design-circle-music-logo-design.png',
    'https://yt3.ggpht.com/a/AATXAJxGnx7jrAl0mDDqUn92WPQUCrbcQ8_WgjzwpQ=s900-c-k-c0xffffffff-no-rj-mo',
    'https://d1fdloi71mui9q.cloudfront.net/DdfTMnClRFW2CVu70B4p_51A4rQ3uJ6pw3KJo',
    'https://media-exp1.licdn.com/dms/image/C510BAQGNHbDM5jQLMw/company-logo_200_200/0/1562909828033?e=2159024400&v=beta&t=xng0GSBtEsa1RS3X0nX13-bGKdZRk6_7x2xWKqBjSn8',
    'https://d1fdloi71mui9q.cloudfront.net/vF5zdHG7SrgUikzqYAs5_0OYX3ZR37KY5JcJu',
    'https://media-exp1.licdn.com/dms/image/C560BAQGODQy-Qkourw/company-logo_200_200/0/1587366501280?e=2159024400&v=beta&t=J8u4r3SUAZo-Tjd6qjwWsO1eUK7j22Cql_BWpJCqC7I',
  ];
  final List<String> _chatrooms=[
    'Octaves',
    'Cadence',
    'Montage',
    'Robotics',
    'Expressions',
    'Coding club',
  ];
  Stream<List<Message>> ReadMessage(String collection)=>FirebaseFirestore.instance
      .collection(collection).snapshots()
      .map((snapshot) => snapshot
      .docs.map((doc) => Message.Fromjson(doc.data())).toList());


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(

        body: SafeArea(
          child: Stack(
            children: [
              Row(
                children: [
                  Flexible(
                      child: Container()),
                  Container(
                    width: 319,
                    height: 800,
                    color: Color.fromARGB(255, 37, 36, 35),

                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (newvalue) {
                        setState(() {
                          SelectedIndex=newvalue;
                        });
                      },
                      children: [
                        BuildPage( _ChatControllerProgramming, _chatrooms[5], ReadMessage(_chatrooms[5]), _user),
                        BuildPage( _ChatControllerMovie, _chatrooms[4], ReadMessage(_chatrooms[4]), _user),
                        BuildPage( _ChatControllerRobots, _chatrooms[3], ReadMessage(_chatrooms[3]), _user),
                        BuildPage( _ChatControllerPhotography, _chatrooms[2], ReadMessage(_chatrooms[2]), _user),
                        BuildPage( _ChatControllerDance, _chatrooms[1], ReadMessage(_chatrooms[1]), _user),
                        BuildPage( _ChatControllerMusic, _chatrooms[0], ReadMessage(_chatrooms[0]), _user),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                color: Color.fromARGB(255, 168, 4, 4),
                width: IsCollapsed?75:250,
                child: Column(
                  children: [
                    Container(
                      //padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 5),
                      width: double.infinity,
                      color: Color.fromARGB(255, 78, 84, 62),
                      child: Image(image: const NetworkImage('https://miro.medium.com/max/720/1*ZGRXE9ReZsawGHtEn0kpmQ.jpeg'),
                      width:IsCollapsed? 75:180,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Flexible(
                      child: Container(
                        child: ListView.separated(
                            itemCount:_images.length,
                            itemBuilder: (context,index)=>Container(
                                            child: Row(
                                              children: [
                                                AnimatedContainer(
                                                    duration: const Duration(milliseconds: 500),
                                                  height: (SelectedIndex==index)? 40:0,
                                                  width: 5,
                                                  color: Colors.blueAccent,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child:IsCollapsed?ListTile(
                                                          leading: ClipOval(
                                                            child: Material(
                                                              child: Image(
                                                              image: NetworkImage(_images[5-index]),
                                                              width: 35,
                                                              height: 35,
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: (){
                                                            setState(() {
                                                              SelectedIndex=index;
                                                              _pageController.jumpToPage(index);
                                                            });
                                                          },
                                                                      ):
                                                      ListTile(
                                                        leading: ClipOval(
                                                          child: Image(
                                                            image: NetworkImage(_images[5-index]),
                                                            width: 40,
                                                            height: 40,
                                                          ),
                                                        ),
                                                        onTap: (){
                                                          setState(() {
                                                            SelectedIndex=index;
                                                            _pageController.jumpToPage(index);
                                                          });
                                                        },
                                                        title:Text(_chatrooms[5-index],
                                                                style: const TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontStyle: FontStyle.italic,
                                                                    fontSize: 20
                                                                              ),)  ,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                            separatorBuilder: (context,index)=>const SizedBox(height: 20,),
                           ),
                      ),
                    ),

                    Container(
                        alignment:IsCollapsed? Alignment.center:Alignment.centerRight,
                        margin:IsCollapsed?null: const EdgeInsets.only(right: 16),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: SizedBox(
                              width: 65,
                              height: 65,
                              child: Icon(IsCollapsed?Icons.arrow_forward_ios:Icons.arrow_back_ios,
                    color: Colors.orangeAccent,
                              size: 36,)

                              ),
                    onTap: (){
                              setState(() {
                                IsCollapsed=!IsCollapsed;
                              });
                    },
                            ),
                          ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}