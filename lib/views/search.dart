import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wall_art/data/data.dart';
import 'package:wall_art/model/photos_model.dart';
import 'package:wall_art/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;

  const Search({Key? key, this.searchQuery = ""}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<PhotosModel> photos = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    getSearchWallpaper(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  getSearchWallpaper(String query) async {
    final url = Uri.parse(
        "https://api.pexels.com/v1/search?query=$query&per_page=20&page=1");
    await http.get(url, headers: {"Authorization": apiKey}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        //  photosModel = PhotosModel();
        PhotosModel photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
            child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                        hintText: "Search wallpaper..",
                        border: InputBorder.none),
                  ),
                ),
                InkWell(
                    onTap: () {
                      getSearchWallpaper(searchController.text);
                    },
                    child: const SizedBox(child: Icon(Icons.search)))
              ]),
            ),
            const SizedBox(height: 16),
            wallpapersList(wallpapers: photos, context: context)
          ],
        )),
      ),
    );
  }
}
