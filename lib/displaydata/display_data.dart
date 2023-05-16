import 'package:flutter/material.dart';
import 'package:food_ordering_app/dbhelper/mangodb_connection.dart';
import 'package:food_ordering_app/insertdata/mongodb_model/mongodb_model.dart';
class MongoDbDisplay extends StatefulWidget {
  const MongoDbDisplay({Key? key}) : super(key: key);

  @override
  State<MongoDbDisplay> createState() => _MongoDisplayState();
}

class _MongoDisplayState extends State<MongoDbDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: MangoDatabase.getData(),
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            } else
              {
                if(snapshot.hasData){
                  var totalData = snapshot.data.length;
                  print("Total data" + totalData.toString());
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                      itemBuilder:(context, index){
return displayCard(
    MongoDbModel.fromJson(snapshot.data[index]));
                      }
                  );

                }else
                  {
                    return Center(
                      child: Text("No data Available"),
                    );
                  }
              }

        },)
      ),
    );
  }
  Widget displayCard(MongoDbModel data){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("${data.id}"),
            SizedBox(
              height: 5,
            ),
            Text("${data.firstName}"),
            SizedBox(
              height: 5,
            ),
            Text("${data.lastName}"),
            SizedBox(
              height: 5,
            ),
            Text("${data.address}"),
          ],
        ),
      ),
    );

  }
}
