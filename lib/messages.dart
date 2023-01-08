import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  DateTime senttime;
  String sendby;
  String message;
  Message({
    required this.senttime,
    required this.message,
    required this.sendby
});
  static Message Fromjson(Map<String,dynamic> json)=>
      Message(
          senttime: (json['senttime'] as Timestamp).toDate(),
          message: json['message'],
          sendby: json['sendby']
      );
  Map<String,dynamic> Tojson()=>{
    'senttime':senttime,
    'sendby':sendby,
    'message':message
  };
}