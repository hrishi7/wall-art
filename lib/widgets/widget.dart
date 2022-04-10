import 'package:flutter/material.dart';
import 'package:wall_art/model/photos_model.dart';
import 'package:wall_art/views/image_view.dart';

// ignore: non_constant_identifier_names
Widget brandName() {
  return RichText(
    text: const TextSpan(
      style: TextStyle(fontSize: 20),
      children: <TextSpan>[
        TextSpan(
            text: 'Wall',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 25)),
        TextSpan(
            text: 'Art', style: TextStyle(color: Colors.blue, fontSize: 23)),
      ],
    ),
  );
}

Widget wallpapersList({required List<PhotosModel> wallpapers, context}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: wallpapers.isNotEmpty
        ? GridView.count(
            shrinkWrap: true,
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const ClampingScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
            children: wallpapers.map((wallpaper) {
              return GridTile(
                  child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageView(
                                imgUrl: wallpaper.src.portrait,
                              )));
                },
                child: Hero(
                  tag: wallpaper.src.portrait,
                  child: SizedBox(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          wallpaper.src.portrait,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ));
            }).toList(),
          )
        : SizedBox(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height / 2,
            // child: const Center(child: CircularProgressIndicator())
            ),
  );
}
