import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wall_art/data/data.dart';
import 'package:wall_art/model/photos_model.dart';
import 'package:http/http.dart' as http;
import 'package:wall_art/widgets/widget.dart';


class Categorie extends StatefulWidget {
  final String searchQuery;

  const Categorie({Key? key, this.searchQuery=""}) : super(key: key);


  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<PhotosModel> photos = [];
  @override
  void initState() {
    getCategoryWallpaper(widget.searchQuery);
    super.initState();
  }

  getCategoryWallpaper(String query) async {
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
            
            wallpapersList(wallpapers: photos, context: context)
          ],
        )),
      ),
   
      
    );
  }
}
