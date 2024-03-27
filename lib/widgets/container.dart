import 'dart:io';

import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        color: _isPressed ? Colors.grey[400] : Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Image.asset('assets/frame.jpg'),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
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

class ImageTile extends StatefulWidget {
  final AssetEntity image;
  final int? tilesPerColumn;
  final int tilesPerRow;
  final int? index;
  final int currentIndex;

  const ImageTile(
      {super.key,
      required this.image,
      required this.tilesPerColumn,
      required this.tilesPerRow,
      required this.index,
      required this.currentIndex});

  @override
  ImageTileState createState() => ImageTileState();
}

class ImageTileState extends State<ImageTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTapDown: (_) => _onPressed(),
      // onTapUp: (_) => _onReleased(),
      // onTapCancel: () => _onReleased(),
      // splashColor: Colors.grey[400],
      // splashFactory: InkRipple.splashFactory,
      child: Ink(
        padding: const EdgeInsets.all(8),
        color: _isPressed ? Colors.grey[400] : Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _getImage(),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 5, bottom: 5),
            //   child: Text(
            //     widget.image.title!,
            //     overflow: TextOverflow.ellipsis,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  _getImage() {
    print(widget.tilesPerRow);
    print(widget.tilesPerColumn);
    print(widget.index);
    print(widget.currentIndex);
    if (widget.index != null && widget.tilesPerColumn != null) {
      final val = (widget.currentIndex) - (widget.index! * widget.tilesPerRow);
      if ( val >= 0 && val < (widget.tilesPerRow * widget.tilesPerColumn!)) {
        print("show image");
        return AssetEntityImage(widget.image, width: 100, height: 100, thumbnailSize: const ThumbnailSize(100, 100));
      }
    }
    return Image.asset('assets/frame.jpg');
  }

// _onPressed() {
//   setState(() {
//     _isPressed = true;
//   });
//   if (widget.folder != null) {
//     Navigator.of(context).push(
//       MaterialPageRoute(builder:
//           (context) => Photos(folder: widget.folder!),
//       ),
//
//     );
//   }
// }
//
// _onReleased() {
//   setState(() {
//     _isPressed = false;
//   });
// }
}
