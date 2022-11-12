import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/widgets/tags.dart';

class LogicScreen extends StatefulWidget {
  const LogicScreen({super.key});

  @override
  State<LogicScreen> createState() => _LogicScreen();
}

class _LogicScreen extends State<LogicScreen> {
  List<String> availableTags = [];

  List<List<String>> buckets = [[]];
  List data = [
    {"color": Color(0xffff6968)},
    {"color": Color(0xff7a54ff)},
    {"color": Color(0xffff8f61)},
    {"color": Color(0xff2ac3ff)},
    {"color": Color(0xff5a65ff)},
    {"color": Color(0xff96da45)},
    {"color": Color(0xffff6968)},
    {"color": Color(0xff7a54ff)},
    {"color": Color(0xffff8f61)},
    {"color": Color(0xff2ac3ff)},
    {"color": Color(0xff5a65ff)},
    {"color": Color(0xff96da45)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your logic'),
        backgroundColor: const Color(0xff7A53D9),
        elevation: 10,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              List<List<String>> newList = buckets;
              newList.add([]);
              setState(() {
                buckets = newList;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("tags").get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          for (var ind = 0; ind < snapshot.data!.docs.length; ind++) {
            availableTags.add(snapshot.data!.docs[ind].id);
          }
          return Container(
            color: const Color.fromRGBO(229, 224, 239, 1),
            padding: EdgeInsets.only(top: 10),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
              itemCount: buckets.length,
              itemBuilder: (context, i) {
                TextEditingController text = TextEditingController();
                return Card(
                  color: data[1]["color"],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text("Bucket ${i + 1}",
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),

                        Tag(tagName: buckets[i].join(",")),

                        // Text(buckets[i].join("\n"),
                        //     style: GoogleFonts.inter(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.w500,
                        //         color: Colors.white)),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(76, 49, 159, 1))),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      onTap: () {},
                                      behavior: HitTestBehavior
                                          .opaque, // this ensures nothing is done onTap on the modal
                                      child: Container(
                                        color: Color.fromRGBO(229, 224, 239, 1),
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          right: 5,
                                          left: 5,
                                        ),
                                        child: Card(
                                          color:
                                              Color.fromRGBO(229, 224, 239, 1),
                                          elevation: 10,
                                          child: SingleChildScrollView(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: MediaQuery.of(context)
                                                        .viewInsets
                                                        .bottom +
                                                    10,
                                                right: 10,
                                                left: 10,
                                              ),
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextField(
                                                    controller: text,
                                                    textAlign: TextAlign.center,
                                                    cursorColor:
                                                        Colors.grey[400],
                                                    autofocus: true,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Enter a tag...',
                                                      fillColor: Colors.white,
                                                      hintStyle:
                                                          GoogleFonts.poppins(
                                                        color: const Color
                                                                .fromRGBO(
                                                            140, 142, 151, 1),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          72)),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1)),
                                                      focusedBorder: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          72)),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1)),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  ElevatedButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(const Color
                                                                          .fromRGBO(
                                                                      76,
                                                                      49,
                                                                      159,
                                                                      1))),
                                                      onPressed: () {
                                                        String name = text.text;
                                                        if (name.isEmpty) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                  "Tag can't be empty"),
                                                            ),
                                                          );
                                                          return;
                                                        }
                                                        name =
                                                            name.toLowerCase();
                                                        if (!availableTags
                                                            .contains(name)) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                  "$name tag doesn't exist."),
                                                            ),
                                                          );
                                                          return;
                                                        }
                                                        if (buckets[i]
                                                            .contains(name)) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                  "$name already exists."),
                                                            ),
                                                          );
                                                          return;
                                                        }
                                                        setState(() {
                                                          buckets[i]
                                                              .add(text.text);
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Add ',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: const Text('Add Tag')),
                      ]),
                );
              },
            ),
          );
        },
      ),
      //hi
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          backgroundColor: const Color.fromRGBO(76, 49, 159, 1),
          onPressed: () {
            String logic = "(" + buckets[0].join("&") + ")";
            for (var i = 1; i < buckets.length; i++) {
              if (buckets[i].isEmpty) continue;
              logic = logic + "|";
              logic = logic + "(" + buckets[i].join("&") + ")";
            }
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop(logic);
            });
          },
          child: const Icon(Icons.check),
        );
      }),
    );
  }
}
