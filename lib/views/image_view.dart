import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;

  const ImageView({Key? key, required this.imgUrl}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  void _saveNetworkImage(context) async {
    String path = widget.imgUrl;
    String albumName = "wall_art";
    await GallerySaver.saveImage(path, albumName: albumName);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("wallpaper is saved in gallery")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Hero(
          tag: widget.imgUrl,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomCenter,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            GestureDetector(
              onTap: () {
                _saveNetworkImage(context);
                // Navigator.pop(context);
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    // color: const Color(0xff1C1B1B).withOpacity(0.8),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54),
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                              colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)])),
                      child: Column(children: const [
                        Text("Save Wallpaper",
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                        Text("Image will be saved in gallary",
                            style:
                                TextStyle(fontSize: 10, color: Colors.white)),
                      ])),
                ],
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel",
                    style: TextStyle(color: Colors.white))),
            const SizedBox(height: 64)
          ]),
        )
      ]),
    );
  }
}
