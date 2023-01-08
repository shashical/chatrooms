
class User{
  final String username;
  final String im_path;
   User({
    required this.username,
     this.im_path='https://nwsid.net/wp-content/uploads/2015/05/dummy-profile-pic.png',
   });
   static User Fromjson(Map<String,dynamic> json){
     return User(
       username: json['username'],
     im_path: json['im_path'],
     );
   }
  Map<String,dynamic> Tojson() {
    return {
       'username':username,
       'im_path':im_path,
     };
  }
}