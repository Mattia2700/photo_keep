import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_keep/handlers/files.dart';
import 'package:photo_keep/views/photos.dart';
import 'package:photo_manager/photo_manager.dart';

import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class AlbumTile extends StatefulWidget {
  final AssetPathEntity folder;

  const AlbumTile({super.key, required this.folder});

  @override
  AlbumTileState createState() => AlbumTileState();
}

class AlbumTileState extends State<AlbumTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (_) => _onPressed(),
      onTapUp: (_) => _onReleased(),
      onTapCancel: () => _onReleased(),
      // splashColor: Colors.grey[400],
      // splashFactory: InkRipple.splashFactory,
      child: Ink(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        color: _isPressed ? Colors.grey[400] : Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FutureBuilder<AssetEntity>(
                future: getFirstImage(widget.folder),
                builder: (BuildContext context,
                    AsyncSnapshot<AssetEntity> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return AspectRatio(
                      aspectRatio: 1.15,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetEntityImageProvider(snapshot.data!,
                                isOriginal: false,
                                thumbnailSize: const ThumbnailSize(200, 200)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(widget.folder.name,
                    style: const TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }

  _onPressed() {
    setState(() {
      _isPressed = true;
    });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Photos(folder: widget.folder),
      ),
    );
  }

  _onReleased() {
    setState(() {
      _isPressed = false;
    });
  }
}

class ImageTile extends StatelessWidget {
  final bool _isPressed = false;
  final AssetEntity image;

  // final int? tilesPerColumn;
  // final int tilesPerRow;
  // final int? index;
  // final int currentIndex;

  const ImageTile({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTapDown: (_) => _onPressed(),
      // onTapUp: (_) => _onReleased(),
      // onTapCancel: () => _onReleased(),
      // splashColor: Colors.grey[400],
      // splashFactory: InkRipple.splashFactory,
      child: Ink(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        color: _isPressed ? Colors.grey[400] : Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetEntityImageProvider(image,
                          isOriginal: false,
                          thumbnailSize: const ThumbnailSize(200, 200)),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            // Text(
            //   image.title!,
            //   overflow: TextOverflow.ellipsis,
            // ),
          ],
        ),
      ),
    );
  }
}
