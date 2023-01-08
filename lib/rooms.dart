import 'package:chatrooms/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../messages.dart';

Widget BuildPage(TextEditingController chatcontroller,String title,Stream<List<Message>> chatstream,User user,){
  String? emptydoc;

  return  Container(
    child:Column(
      children: [
        Container(
          color: Color.fromARGB(255, 151, 99, 76),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: Text(title,
          textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize:36,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Flexible(
          child: StreamBuilder<List<Message>>(
              stream: chatstream,
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Center(
                    child: Text('Something went wrong !${snapshot.error}'),
                  );
                }
                else if(snapshot.connectionState==ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(snapshot.data==null){
                  emptydoc= FirebaseFirestore.instance.collection(title).doc().id;
                  return Center(child: Container(padding: EdgeInsets.all(15),));
                }
                else {
                  final messages = snapshot.data!;

                  return ListView(
                    children: messages.map((message)=>
                        Container(
                          child: Row(
                            mainAxisAlignment: (user.username==message.sendby)? MainAxisAlignment.end:MainAxisAlignment.start,
                            crossAxisAlignment: (user.username==message.sendby)? CrossAxisAlignment.end:CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15,
                                  top: 10,left: 10),
                                child: Container(
                                    width: (message.message.length>25)?200:null,
                                    padding: const EdgeInsets.only(left: 4,top: 6,bottom: 6),
                                    decoration: BoxDecoration(
                                      color: (user.username==message.sendby)?Color.fromARGB(255, 157, 228, 77):Colors.white,
                                      borderRadius:(user.username==message.sendby)? BorderRadius.only(topLeft: Radius.circular(25),bottomLeft: Radius.circular(25),bottomRight: Radius.circular(10)):
                                      const BorderRadius.only(topRight: Radius.circular(25),bottomLeft: Radius.circular(25),bottomRight: Radius.circular(10)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Padding(padding: EdgeInsets.all(5),
                                            child: (message.sendby==user.username)?Text("You",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color:(user.username==message.sendby)? Colors.white:Colors.greenAccent,
                                              ),
                                            ):Text(message.sendby,
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color:(user.username==message.sendby)? Colors.white:Color.fromARGB(255, 206, 85, 9),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(2),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(message.message,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                          Text('${message.senttime.hour}:${message.senttime.minute.toInt()~/10}${message.senttime.minute.toInt()%10}',
                                            textAlign: TextAlign.end,
                                            ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                  );
                }
              }
              ),),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.white,
          ),
          child: Row(
            children: [
              const SizedBox(width: 20,),
              Container(
                width: 200,
                child: TextField(
                  controller: chatcontroller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                  hintText: 'Message',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  )
                  ),
                ),
              ),
              Flexible(child: Container()),
              Builder(
                  builder: (context) {
                    return IconButton(
                        onPressed: ()async{
                          FirebaseFirestore.instance.collection(title).doc(DateTime.now().toString()).set(Message(senttime: DateTime.now(), message: chatcontroller.text,  sendby: user.username).Tojson()).catchError((e){
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(SnackBar(content: Text('${e}'))) ;
                          });
                          chatcontroller.clear();
                          if(emptydoc!=null){
                            FirebaseFirestore.instance.collection(title).doc(emptydoc!).delete().catchError((e){
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(content: Text('${e}'))) ;
                            });
                          }
                          },
                        icon: const Icon(Icons.send));
                  }
                  )
            ],
          ),
        )
      ],
    ),
  );
}