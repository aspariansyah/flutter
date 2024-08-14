import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Result extends StatefulWidget {
  final String place;

  const Result({super.key, required this.place});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Future<Map<String, dynamic>> getDataFromAPI() async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=${widget.place} &appid=06fa2e15d034935b90ab88feb726b0bf&units=metric"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data;
    } else {
      throw Exception("error!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: const Text(
                "hasil tracking",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.blueAccent,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              )),
          body: Container(
            padding: const EdgeInsets.only(left: 70, right: 70),
            child: FutureBuilder(
              future: getDataFromAPI(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  final data = snapshot.data!; //non nulables
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            image: NetworkImage(
                                'https://flagsapi.com/${data["sys"]["country"]}/shiny/64.png')),
                        DataTable(
                          columns: const [
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('')),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                const DataCell(Text('Nama Kota')),
                                DataCell(Text(widget.place)),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text('Cuaca saat ini')),
                                DataCell(Text('${data["weather"][0]["main"]}')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text('Suhu')),
                                DataCell(
                                    Text('${data["main"]["feels_like"]} C')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text('Kecepatan angin')),
                                DataCell(Text('${data["wind"]["speed"]} M/S')),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text("tempat tidak diketahui");
                }
              },
            ),
          )),
    );
  }
}