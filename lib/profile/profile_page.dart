
import 'dart:convert';
import 'dart:io';

import 'package:chatrooms/default_page.dart';
import 'package:chatrooms/profile/edit.dart';
import 'package:chatrooms/main.dart';
import 'package:chatrooms/users.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
   const ProfileScreen({
    Key? key}) : super(key: key);


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user=User.Fromjson(jsonDecode(json!));

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(' User Profile',
        style: TextStyle(
          fontSize: 32
        ),),
        backgroundColor: Colors.purpleAccent,

      ),
      body: Center(
        child: Container(
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children:[
                    ClipOval(
                      child: Material(
                        child: Image(
                          image:user!.im_path.contains('https://')? NetworkImage(user!.im_path):FileImage(File(user!.im_path)) as ImageProvider,
                          fit:BoxFit.cover ,
                          width: 200,
                          height: 200,
                          ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: ClipOval(
                        child: Container(
                          padding: EdgeInsets.all(7),
                          color: Colors.white,
                          child: ClipOval(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              color: Colors.lightBlue,
                              child: IconButton(
                                onPressed: ()async{
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>EditProfileScreen()));
                          },
                                icon: const Icon(
                                  Icons.edit
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )

                  ]
                ),
              ),
               const SizedBox(height: 100,),


              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                     const Text( 'Username :',
                         style: TextStyle(
                         fontSize: 28,
                         fontWeight: FontWeight.w500),),
                      SizedBox(height: 25,),
                      Text(user!.username,
                        style: const TextStyle(
                            fontSize: 46,
                            fontWeight: FontWeight.w500),),


                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>Chatroompage()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text('Continue',
                      style: TextStyle(
                        fontSize: 28
                      ),),
                    )),
              )
            ],
          ),
        ),
      ),

    );
  }
}