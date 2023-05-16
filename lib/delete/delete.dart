import 'package:flutter/material.dart';
import 'package:food_ordering_app/dbhelper/mangodb_connection.dart';
import 'package:food_ordering_app/insertdata/mongodb_model/mongodb_model.dart';
class DeleteMangoDb extends StatefulWidget {
  const DeleteMangoDb({Key? key}) : super(key: key);

  @override
  State<DeleteMangoDb> createState() => _DeleteMangoDbState();
}

class _DeleteMangoDbState extends State<DeleteMangoDb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SafeArea(
  child: FutureBuilder(
    future: MangoDatabase.getData(),
    builder: (BuildContext context,AsyncSnapshot snapshot){
if(snapshot.connectionState==ConnectionState.waiting){
  return Center(
    child: CircularProgressIndicator(),
  );
}else{
  if(snapshot.hasData){
return Center(
  child: ListView.builder(
    itemCount: snapshot.data.length,
    itemBuilder: (context, index){
return _dataCard(MongoDbModel.fromJson(snapshot.data[index]));
    },

  )
);
  }else
    {
      return Center(
        child: Text("No data found"),
      );
    }
}
    },
  )
),
    );
  }
   Widget _dataCard(MongoDbModel data){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    _text(data.firstName),
                    SizedBox(
                      height: 10,
                    ),
                    _text(data.lastName),
                    SizedBox(
                      height: 10,
                    ),
                    _text(data.address),
                  ],

                ),
              ),
              IconButton(onPressed: () async {

                print(data.id);
               await MangoDatabase.delete(data);
               setState(() {

               });
              },
                  icon: Icon(Icons.delete )
              )
            ],
          ),
        ),
      ),
    );

   }
  Widget _text(String value){
    return Text(
      value,
      style: TextStyle(fontSize: 16),


    );
  }
}
