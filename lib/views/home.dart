import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wall_art/data/data.dart';
import 'package:wall_art/model/categories_model.dart';
import 'package:wall_art/model/photos_model.dart';
import 'package:wall_art/views/category.dart';
import 'package:wall_art/views/search.dart';

import 'package:wall_art/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = [];
  List<PhotosModel> photos = [];

  TextEditingController searchController = TextEditingController();

  getTrendingWallpaper() async {
    final url =
        Uri.parse("https://api.pexels.com/v1/curated?per_page=15&page=1");
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
  void initState() {
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: brandName(),
          elevation: 0.0,
        ),
        // ignore: avoid_unnecessary_containers
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(
                                    searchQuery: searchController.text)));
                      },
                      child: const SizedBox(child: Icon(Icons.search)))
                ]),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 80,
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      CategorieModel item = categories[index];
                      return CategoriesTile(
                        title: item.categorieName,
                        imgUrl: item.imgUrl,
                      );
                    }),
              ),
              const SizedBox(height: 16),
              wallpapersList(wallpapers: photos, context: context)
            ],
          )),
        ));
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl, title;

  const CategoriesTile({Key? key, required this.imgUrl, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Categorie(searchQuery: title.toLowerCase())));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgUrl,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
