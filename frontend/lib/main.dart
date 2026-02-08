import 'dart:convert';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

const baseUrl = "donfax.com";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SKE Projesi',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blue)),
      home: const MyHomePage(title: 'SANAYİDE KADIN ELİ PROJESİ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum ViewMode { viewMode, editMode }

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<RecordModel>> records;
  late PocketBase pb;
  ViewMode mode = ViewMode.viewMode;

  @override
  void initState() {
    super.initState();
    pb = PocketBase("http://$baseUrl:6002");
    records = pb.collection('provinces').getFullList();
  }

  void saveData(List<RecordModel> data) {
    for (final model in data) {
      pb.collection("provinces").update(model.id, body: model.data);
    }
  }

  Future<Uint8List> createMap(List<Map<String, dynamic>> data) async {
    var url = Uri.http('$baseUrl:6003', '/');
    var response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    return response.bodyBytes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: records,
      builder: (BuildContext context, AsyncSnapshot<List<RecordModel>> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              // TRY THIS: Try changing the color here to a specific color (to
              // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
              // change color while the other colors stay the same.
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: SelectableText(widget.title),
            ),
            body: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Container(
                padding: EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                  top: 10.0,
                  bottom: 30.0,
                ),
                child: table(snapshot.data!),
              ),
            ),
            floatingActionButton: Row(
              mainAxisAlignment: .end,
              spacing: 15.0,
              children: switch (mode) {
                ViewMode.viewMode => [
                  FloatingActionButton(
                    onPressed: () => setState(() {
                      mode = ViewMode.editMode;
                    }),
                    tooltip: 'Edit',
                    child: const Icon(Icons.edit),
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      List<Map<String, dynamic>> postData = [];
                      for (final element in snapshot.data!) {
                        postData.add({
                          "sıra": element.data["row"].toString(),
                          "il": element.data["name"],
                          "id": element.data["trid"],
                          "SANAYİDE KADIN ELİ PROJESİ":
                              element.data["ske_status"],
                          "BAŞLAMA YILI": element.data["start_year"].toString(),
                          "CİNSİYET EŞİTLİĞİ": element.data["gender_equality"]
                              .toString(),
                          "BÖLGE": element.data["region"],
                          "MESLEK LİSELERİ": element.data["high_schools"],
                          "ÜNİVERSİTELER": element.data["universities"],
                        });
                      }
                      Uint8List bytes = await createMap(postData);
                      await FileSaver.instance.saveFile(
                        name: "map.png",
                        bytes: bytes,
                        fileExtension: "png",
                        mimeType: MimeType.png,
                      );
                    },
                    tooltip: 'Create Map',
                    child: const Icon(Icons.map),
                  ),
                ],
                ViewMode.editMode => [
                  FloatingActionButton(
                    onPressed: () {
                      saveData(snapshot.data!);
                      setState(() {
                        mode = ViewMode.viewMode;
                      });
                    },
                    tooltip: 'Save',
                    child: const Icon(Icons.save),
                  ),
                ],
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget table(List<RecordModel> data) {
    return SingleChildScrollView(
      child: DataTable(
        border: TableBorder(
          top: BorderSide(width: 1.0),
          horizontalInside: BorderSide(width: 0.5),
          verticalInside: BorderSide(width: 0.5),
          left: BorderSide(width: 1.0),
          right: BorderSide(width: 1.0),
          bottom: BorderSide(width: 1.0),
        ),
        columns:
            [
                  //"sıra",
                  "İL",
                  //"id",
                  "SANAYİDE KADIN ELİ PROJESİ",
                  "BAŞLAMA YILI",
                  "CİNSİYET EŞİTLİĞİ",
                  "BÖLGE",
                  "MESLEK LİSELERİ",
                  "ÜNİVERSİTELER",
                ]
                .map(
                  (text) => DataColumn(
                    label: SelectableText(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
                .toList(),
        rows: data
            .map(
              (model) => DataRow(
                cells: [
                  // Text(model.data["row"].toString()),
                  DataCell(
                    SelectableText(
                      model.data["name"],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // SelectableText(model.data["trid"]),
                  switch (mode) {
                    ViewMode.viewMode => DataCell(
                      SelectableText(
                        model.data["ske_status"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ViewMode.editMode => DataCell(
                      dropdownMenu(model, "ske_status"),
                    ),
                  },
                  switch (mode) {
                    ViewMode.viewMode => DataCell(
                      SelectableText(
                        model.data["start_year"] > 0
                            ? model.data["start_year"].toString()
                            : "",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ViewMode.editMode => DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 3.0,
                        ),
                        child: TextField(
                          controller: TextEditingController(
                            text: model.data["start_year"].toString(),
                          ),
                          keyboardType: .number,
                          onChanged: (value) {
                            model.data["start_year"] = int.tryParse(value) ?? 0;
                          },
                        ),
                      ),
                    ),
                  },
                  switch (mode) {
                    ViewMode.viewMode => DataCell(
                      SelectableText(
                        "${model.data["gender_equality"]}%",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ViewMode.editMode => DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 3.0,
                        ),
                        child: TextField(
                          controller: TextEditingController(
                            text: model.data["gender_equality"].toString(),
                          ),
                          keyboardType: .number,
                          onChanged: (value) {
                            model.data["gender_equality"] =
                                int.tryParse(value) ?? 0;
                          },
                        ),
                      ),
                    ),
                  },
                  DataCell(
                    SelectableText(
                      model.data["region"],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  switch (mode) {
                    ViewMode.viewMode => DataCell(
                      SelectableText(
                        model.data["high_schools"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ViewMode.editMode => DataCell(
                      dropdownMenu(model, "high_schools"),
                    ),
                  },
                  switch (mode) {
                    ViewMode.viewMode => DataCell(
                      SelectableText(
                        model.data["universities"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ViewMode.editMode => DataCell(
                      dropdownMenu(model, "universities"),
                    ),
                  },
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget dropdownMenu(RecordModel model, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: DropdownMenu(
        textStyle: TextStyle(fontSize: 12.0),
        dropdownMenuEntries: [
          DropdownMenuEntry(value: "Aktif", label: "Aktif"),
          DropdownMenuEntry(value: "Planlıyor", label: "Planlıyor"),
          DropdownMenuEntry(value: "Yok", label: "Yok"),
        ],
        initialSelection: model.data[key],
        onSelected: (value) {
          if (value != null) {
            model.data[key] = value.toString();
          }
        },
      ),
    );
  }
}
