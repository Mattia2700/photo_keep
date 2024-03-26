import 'package:flutter/material.dart';
import 'package:photo_keep/views/photos.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumTile extends StatefulWidget {
  final AssetPathEntity? folder;
  final AssetEntity? image;

  const AlbumTile({super.key, this.folder, this.image });

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
              child: _getText(),
            ),
          ],
        ),
      ),
    );
  }

  _getText() {
    if (widget.folder != null) {
      return Text(widget.folder!.name, style: const TextStyle(fontWeight: FontWeight.bold));
    } else if (widget.image != null && widget.image!.title != null) {
      return Text(widget.image!.title!);
    } else {
      return "Unknown";
    }
  }

  _onPressed() {
    setState(() {
      _isPressed = true;
    });
    if (widget.folder != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder:
            (context) => Photos(folder: widget.folder!),
        ),

      );
    }
  }

  _onReleased() {
    setState(() {
      _isPressed = false;
    });
  }

}
