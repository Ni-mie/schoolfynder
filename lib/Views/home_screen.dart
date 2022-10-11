import 'dart:async';

import 'package:flutter/material.dart';
import 'package:propzing_assignment/Controller/auth_controller.dart';

import 'package:propzing_assignment/service.dart';
import 'package:url_launcher/link.dart';

import '../Model/model.dart';
import '../Utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DataModel>? schools = [];
  var isLoaded = false;
  List<DataModel>? searchSchoolnames = [];
  List<DataModel>? searchSchoolcountries = [];
  final StreamController<bool> _streamController = StreamController.broadcast();
  @override
  void initState() {
    fetchschools();

    super.initState();
  }

  fetchschools() async {
    schools = await ApiService.fetchschools();
    if (schools != null) {
      setState(() {
        isLoaded = true;
      });
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'Universities,',
                      style: headline1ExtraLarge(),
                    ),
                    subtitle: Text(
                      'All Over The World',
                      style: headline1(color: textLightColor.withOpacity(0.6)),
                    ),
                    leading: Image.network(
                        'https://media.istockphoto.com/vectors/isolated-education-crest-clip-art-icon-vector-vector-id1269987763?s=612x612'),
                    trailing: TextButton(
                        onPressed: () {
                          logOut(context);
                        },
                        child: Text(
                          'Logout',
                          style: bodyText1(color: textLightColor),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //search
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    decoration: boxBorderDecoration(borderRadius: 25),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: textLightColor),
                        const SizedBox(
                          width: 20,
                        ),
                        StatefulBuilder(builder: (context, setNewState) {
                          return Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                  hintText: 'Search for Universities',
                                  hintStyle: TextStyle(color: textLightColor),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none)),
                              onChanged: (value) {
                                setState(() {
                                  schools = searchSchoolcountries!
                                      .where((element) => element.country
                                          .toString()
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .where((element) => element.name
                                          .toString()
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
                                });
                                // ignore: unused_element
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isLoaded,
                    child: SizedBox(
                        height: scHeight(context),
                        child: ListView.builder(
                            shrinkWrap: false,
                            itemCount: schools!.length,
                            itemBuilder: (BuildContext context, index) {
                              return Container(
                                width: scWidth(context),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 0),
                                margin: const EdgeInsets.only(
                                    right: 2, left: 2, top: 4, bottom: 5),
                                decoration: BoxDecoration(
                                    color: index == 0
                                        ? const Color(0xffECF3FD)
                                        : index == 1
                                            ? const Color(0xffD1E7CC)
                                            : index == 2
                                                ? const Color(0xffFFF9D7)
                                                : index == 3
                                                    ? const Color(0xffF5F1FF)
                                                    : index == 4
                                                        ? const Color(
                                                            0xffF1DBE8)
                                                        : const Color(
                                                            0xffCAE5E4),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 5,

                                          // spreadRadius: 5,
                                          color:
                                              textLightColor.withOpacity(0.4))
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      child: Text(
                                        schools![index].name,
                                        style: headline1(),
                                      ),
                                    ),
                                    Text(
                                      '${schools![index].country},(${schools![index].alphaTwoCode})',
                                      style: bodyText1(),
                                    ),
                                    Link(
                                      target: LinkTarget.blank,
                                      uri: Uri.parse(schools![index]
                                          .webPages[0]
                                          .toString()),
                                      builder: (context, followLink) =>
                                          TextButton(
                                              onPressed: followLink,
                                              child: Text(schools![index]
                                                  .webPages[0]
                                                  .toString())),
                                    )
                                  ],
                                ),
                              );
                            })),
                  )
                ],
              ),
            )));
  }
}
