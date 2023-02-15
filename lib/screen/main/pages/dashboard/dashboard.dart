import 'package:flutter/material.dart';
import 'package:usluge_client/model/list_item.dart';
import 'package:usluge_client/screen/main/pages/dashboard/widget/list_item_widget.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../utils/loadingbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ListItem>>(
      future: readJson(),
      builder: (BuildContext context, AsyncSnapshot<List<ListItem>> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingDialog();
          //Postavi loading bar ovde
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Scaffold(
                appBar: AppBar(title: const Text("Dashboard")),
                body: AnimatedList(
                  initialItemCount: snapshot.data!.length,
                  itemBuilder: (context, index, animation) => ListItemWidget(
                    item: snapshot.data![index],
                    animation: animation,
                    onClicked: () {},
                  ),
                ));
        }
      },
    );
  }
}

Future<List<ListItem>> readJson() async {
  String url = 'http://trebam.me:8082/api/v1/getAllOffers';
  var response = await http.get(Uri.parse(url));
  final list = response.body;
  List<ListItem> listItems = (json.decode(response.body) as List)
      .map((data) => ListItem.fromJson(data))
      .toList();
  return Future.value(listItems);
}
