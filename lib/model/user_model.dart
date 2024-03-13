class UserModel{
  String? name;
  String? phone;
  String? childEmail;
  String? gaurdianEmail;
  String? id;
  UserModel({this.name,this.phone,this.id,this.childEmail,this.gaurdianEmail});
  

  Map<String, dynamic> toJson()=>{
   'name':name,
   'phone':phone,
   'id':id,
   'childEmail':childEmail,
   'gaurdianEmail':gaurdianEmail,
  };
}