import 'dart:developer';

import 'package:food_ordering_app/dbhelper/constant.dart';
import 'package:food_ordering_app/insertdata/mongodb_model/mongodb_model.dart';
import 'package:mongo_dart/mongo_dart.dart';
class MangoDatabase {
static var db,  userCollection;
static connect() async {
  db = await Db.create(MONGO_CONN_URL);
  await db.open();
  inspect(db);
  userCollection= db.collection(USER_COLLECTION);
}
static Future<List<Map<String,dynamic>>> getData() async {
  final arrData = await userCollection.find().toList();
  return arrData;
}
 //user from query
static Future<List<Map<String,dynamic>>> getQueryData() async{
  final arrData= await userCollection.
  find(where.gt('age', '43').lt('age', '50')).toList();
  //find(where.eq('age', '43')).toList();
  return arrData;
}
static Future<void> update(MongoDbModel data) async{
  var result= await userCollection.findOne({"_id":data.id});
  result['firstName']=data.firstName;
  result['lastName']=data.lastName;
  result['address']=data.address;
  var response =await userCollection.save(result);
  inspect(response);
}
static Future<void> delete(MongoDbModel user) async {
  await userCollection.remove(where.eq('_id', user.id));
}







static Future insert(MongoDbModel data) async {
  try{
var result = await userCollection.insertOne(data.toJson());
 if(result.isSuccess){
   return "DATA INSERTED";
 } else {
   return "Something wrong while inserting data.";
 }
  }
  catch(e){
print(e.toString());
return e.toString();
  }
}
}