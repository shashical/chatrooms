import 'dart:convert';
import 'dart:io';
import 'package:chatrooms/main.dart';
import 'package:chatrooms/profile/profile_page.dart';
import 'package:chatrooms/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User _user = json != null ? User.Fromjson(jsonDecode(json!)) : User(
      username: '');

  @override
  Widget build(BuildContext context) {
    TextEditingController _UsernameController = TextEditingController(
        text: _user.username);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit User Profile',
          style: TextStyle(
            fontSize: 32,
          ),
        ),



      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 25,),
            Center(
              child: Stack(
                  children: [

                    ClipOval(
                      child: Material(
                        color: Colors.red,
                        child: Image(
                          image: _user.im_path.contains('https://')
                              ? NetworkImage(_user.im_path)
                              : FileImage(File(
                              _user.im_path)) as ImageProvider,
                          fit: BoxFit.cover,
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
                          padding: const EdgeInsets.all(7),
                          color: Colors.white,
                          child: ClipOval(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              color: Colors.lightBlue,
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 300,
                                    child: Column(
                                      children: [
                                        Container(

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 35, horizontal: 25),
                                            child: Row(
                                              children: [
                                                const Flexible(
                                                  child: SizedBox(
                                                    width: 450,
                                                    child: Text('Profile photo',
                                                      style: TextStyle(
                                                          fontSize: 36,
                                                          fontWeight: FontWeight
                                                              .w600
                                                      ),),
                                                  ),
                                                ),
                                                !(_user.im_path.contains(
                                                    'https://')) ? IconButton(
                                                    onPressed: () {
                                                      _user = User(
                                                          username: _user
                                                              .username,
                                                          im_path: 'https://th.bing.com/th/id/OIP.mzIOKRfWXfNzyzjURPQckAHaHa?w=161&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7');
                                                      setState(() {

                                                      });
                                                    },
                                                    icon: const Icon(Icons.delete,
                                                      size: 32,))
                                                    : Container()

                                              ],
                                            ),
                                          ),

                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(20),
                                                height: 170,
                                                child: Column(
                                                  children: [
                                                    const Spacer(),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(8.0),

                                                      child: ClipOval(
                                                        child: Container(
                                                          color: Colors.grey,
                                                          padding: const EdgeInsets
                                                              .all(2),
                                                          child: ClipOval(
                                                            child: Container(
                                                              padding: const EdgeInsets
                                                                  .all(14),
                                                              color: Colors
                                                                  .white,
                                                              child: IconButton(
                                                                  onPressed: () async {
                                                                    final imagecam = await ImagePicker()
                                                                        .pickImage(
                                                                        source: ImageSource
                                                                            .camera,
                                                                        preferredCameraDevice: CameraDevice
                                                                            .front);
                                                                    if (imagecam ==
                                                                        null) {
                                                                      return;
                                                                    }
                                                                    final directory = await getApplicationDocumentsDirectory();
                                                                    final name = basename(
                                                                        imagecam
                                                                            .path);
                                                                    final imagefile = File(
                                                                        '${directory
                                                                            .path}/$name');
                                                                    final NewImage = await File(
                                                                        imagecam
                                                                            .path)
                                                                        .copy(
                                                                        imagefile
                                                                            .path);
                                                                    setState(() {
                                                                      _user =
                                                                          User(
                                                                              username: _user
                                                                                  .username,
                                                                              im_path: NewImage
                                                                                  .path);
                                                                    });
                                                                  },
                                                                  icon: const Icon(
                                                                    Icons
                                                                        .camera_alt,
                                                                    size: 36,)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const Text('Camera',
                                                      style: TextStyle(
                                                          fontSize: 28
                                                      ),)
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(20),
                                                height: 170,
                                                child: Column(
                                                  children: [
                                                    const Spacer(),
                                                    ClipOval(
                                                      child: Container(
                                                        padding: const EdgeInsets
                                                            .all(2.0),

                                                        color: Colors.grey,

                                                        child: ClipOval(
                                                          child: Container(
                                                            padding: const EdgeInsets
                                                                .all(14),
                                                            color: Colors.white,
                                                            child: IconButton(
                                                                onPressed: () async {
                                                                  final imagegal = await ImagePicker()
                                                                      .pickImage(
                                                                      source: ImageSource
                                                                          .gallery);
                                                                  if (imagegal ==
                                                                      null) {
                                                                    return;
                                                                  }
                                                                  final directory = await getApplicationDocumentsDirectory();
                                                                  final name = basename(
                                                                      imagegal
                                                                          .path);
                                                                  final imagefile = File(
                                                                      '${directory
                                                                          .path}/$name');
                                                                  final NewImage = await File(
                                                                      imagegal
                                                                          .path)
                                                                      .copy(
                                                                      imagefile
                                                                          .path);
                                                                  setState(() {
                                                                    _user =
                                                                        User(
                                                                            username: _user
                                                                                .username,
                                                                            im_path: NewImage
                                                                                .path);
                                                                  });
                                                                },
                                                                icon: const Icon(
                                                                  Icons.photo,
                                                                  size: 36,)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const Text('Gallery',
                                                      style: TextStyle(
                                                          fontSize: 28
                                                      ),)
                                                  ],
                                                ),
                                              )

                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  );
                                });
                                },
                                icon: Icon(Icons.add_a_photo,
                                size: 30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]
              ),
            ),
            const SizedBox(height: 60,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text('Create a username',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,

                ),),
            ),
            const SizedBox(height: 30,),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: _UsernameController,
                  style: const TextStyle(
                      fontSize: 28
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                )
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                      onPressed: () async {
                        String? username = _UsernameController.text;
                        if (username == '') {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Required username !',
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.red,
                                    ),),
                                  content: const Text(
                                    'Please Enter a username to continue ',
                                    style: TextStyle(
                                      fontSize: 24,

                                    ),),
                                  actions: [
                                    Builder(
                                        builder: (context) {
                                          return ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(
                                                    context, rootNavigator: true)
                                                    .pop();
                                              },
                                              child: const Text('Ok'));
                                        }
                                    )
                                  ],
                                );
                              });
                        }
                        else {
                           try{
                              await updateUserName(_user, _UsernameController);
                             _user = User(username: username,

                             );
                             SharedPreferences prefs = await SharedPreferences
                                 .getInstance();
                             prefs.setString(
                                 MyApp.keyuser, jsonEncode(_user.Tojson()));
                             json = prefs.getString(MyApp.keyuser);

                             Navigator.pushReplacement(context,
                                 MaterialPageRoute(
                                     builder: (context) => const ProfileScreen()));
                           }catch(e){
                             ScaffoldMessenger.of(context)
                               ..removeCurrentSnackBar()
                               ..showSnackBar(SnackBar(content: Text('$e')));
                        }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                          ),
                          backgroundColor: Colors.blue
                      ),
                      child: const Text('Save',
                        style: TextStyle(
                            fontSize: 30
                        ),));
                }
              ),
            )
          ],
        ),
      ),


    );
  }

  Future<void> updateUserName( User user,TextEditingController controller) async{
    for( String i in [
      'Music',
      'Travel',
      'Photography',
      'Study',
      'Movie',
      'Programming']) {
      final  docs=await FirebaseFirestore.instance.collection(i).get();

     for (var element in docs.docs) {
       if(element.get('sendby')==user.username){

          await FirebaseFirestore.instance.collection(i).doc(element.id).update(
              {'sendby':controller.text}).catchError((e){
             debugPrint(e);
          });
          debugPrint('true');
          debugPrint(element.id);
       }
       else {
         debugPrint('false');
       }
     }}
  }
}