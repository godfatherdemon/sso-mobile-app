import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../utils/loadingbar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: downloadData(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingDialog();
          //Postavi loading bar ovde
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Center(
                child: new Text(
                    'Ime : ${snapshot.data!["name"]} \nPrezime : ${snapshot.data!["lastName"]}\nEmail : ${snapshot.data!["email"]}\nNadimak : ${snapshot.data!["nickname"]}\nLokacija : ${snapshot.data!["location"]}'));
        }
      },
    );
  }

  Future<Map> downloadData() async {
    String url =
        'http://trebam.me:8082/api/v1/getUser/6383a00e526723048664ff5d';
    var response = await http.get(Uri.parse(url));
    Map dataGet = jsonDecode(response.body);
    return Future.value(dataGet);
  }
}
