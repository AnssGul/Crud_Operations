import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/dbhelper/mangodb_connection.dart';
import 'package:food_ordering_app/insertdata/mongodb_model/mongodb_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class MongoInsert extends StatefulWidget {
  const MongoInsert({Key? key}) : super(key: key);

  @override
  State<MongoInsert> createState() => _MongoInsertState();
}

class _MongoInsertState extends State<MongoInsert> {
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var addressController = TextEditingController();

  var _checkInsertUpdate= "insert";
  @override
  Widget build(BuildContext context) {

    MongoDbModel? data = ModalRoute.of(context)!.settings.arguments as MongoDbModel?;


    if(data!=null){
      fnameController.text=data.firstName;
      lnameController.text= data.lastName;
      addressController.text= data.address;
      _checkInsertUpdate= "update";
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Text(_checkInsertUpdate,style: TextStyle(
                  fontSize: 22
                ),),
                 SizedBox(
                   height: 50,
                 ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "First Name"
                  ),
                  controller: fnameController,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "last Name"

                  ),
                  controller: lnameController,
                ),

                TextField(
                  minLines: 3,
                  maxLines: 5,
                  decoration: InputDecoration(
                      labelText: "Address"
                  ),
                  controller: addressController,
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(onPressed: (){
                      _fakedata();
                    },
                        child: Text("Generate data")),
                    ElevatedButton(onPressed: (){
                      if(_checkInsertUpdate=="update"){
                _updateData(data!.id,fnameController.text, lnameController.text, addressController.text);
                      } else
                        {
                          _insertData(fnameController.text,
                              lnameController.text,
                              addressController.text  );
                        }

                    },child: Text(_checkInsertUpdate))
                  ],
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
  Future<void> _updateData(var id,String fname, String lname, String address)async {
final updatedata=MongoDbModel(
    id: id, firstName: fname, lastName: lname, address:address);
var result= await MangoDatabase.update(updatedata).whenComplete(() => Navigator.pop(context));
  }
  Future<void>
  _insertData(String fname, String lname, String address)
  async {
    var _id =  M.ObjectId(); //this use for id
    final data = MongoDbModel(
        id: _id,
        firstName: fname,

        lastName: lname,
        address: address);
    var result=  await MangoDatabase.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Inserted" + _id.$oid)));
    _clearAll();

  }
  void _clearAll(){
    fnameController.text= "";
    lnameController.text= "";
    addressController.text= "";
  }
  void _fakedata(){
     fnameController.text= faker.person.firstName();
     lnameController.text= faker.person.lastName();
     addressController.text=faker.address.streetName() + "/n" + faker.address.streetAddress();

  }


}
