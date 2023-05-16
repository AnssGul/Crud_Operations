import 'package:flutter/material.dart';
import 'package:food_ordering_app/dbhelper/mangodb_connection.dart';
import 'package:food_ordering_app/insertdata/insert.dart';
import 'package:food_ordering_app/insertdata/mongodb_model/mongodb_model.dart';

class MongoDbUpdate extends StatefulWidget {
  const MongoDbUpdate({Key? key}) : super(key: key);

  @override
  State<MongoDbUpdate> createState() => _MongoDbUpdateState();
}

class _MongoDbUpdateState extends State<MongoDbUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<dynamic>>(
          future: MangoDatabase.getData(),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return CardData(MongoDbModel.fromJson(snapshot.data![index]));
                  },
                );
              } else {
                return Center(child: Text("No Data Found"));
              }
            }
          },
        ),
      ),
    );
  }
}

class CardData extends StatelessWidget {
  final MongoDbModel data;

  const CardData(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${data.id}"),
              SizedBox(height: 5),
              Text("${data.firstName}"),
              SizedBox(height: 5),
              Text("${data.lastName}"),
              SizedBox(height: 5),
              Text("${data.address}"),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MongoInsert();
                  },
                  settings: RouteSettings(arguments: data))).then((value) {

              });
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
