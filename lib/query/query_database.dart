import 'package:flutter/material.dart';
import 'package:food_ordering_app/dbhelper/mangodb_connection.dart';
import 'package:food_ordering_app/insertdata/mongodb_model/mongodb_model.dart';
class QueryDatabase extends StatefulWidget {
  const QueryDatabase({Key? key}) : super(key: key);

  @override
  State<QueryDatabase> createState() => _QueryDatabaseState();
}

class _QueryDatabaseState extends State<QueryDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: MangoDatabase.getQueryData(),
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else
              {
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder:(context, index){
return displayData(MongoDbModel.fromJson(snapshot.data[index]));
                      });
                }else
                  {
                    return Center(
                      child: Text("not found"),
                    );
                  }
              }
          },
        ),
      ),
    );
  }
  Widget displayData(MongoDbModel data){
return Padding(
  padding: const EdgeInsets.all(5.0),
  child:   Card(

    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text("${data.firstName}"),
          SizedBox(
            height: 8,
          ),
          Text("${data.lastName}"),
          SizedBox(
            height: 8,
          ),
          Text("${data.address}"),
        ],

      ),
    ),

  ),
);
  }
}
