import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_manager/photo_manager.dart';

import '../handlers/files.dart';
import '../widgets/container.dart';

class Photos extends StatelessWidget {
  final AssetPathEntity folder;

  const Photos({super.key, required this.folder});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyPhotosPage(title: 'PhotoKeep', folder: folder));
  }
}

class MyPhotosPage extends StatefulWidget {
  final String title;
  final AssetPathEntity folder;

  const MyPhotosPage({super.key, required this.title, required this.folder});

  @override
  State<MyPhotosPage> createState() => _MyPhotosPageState();
}

class _MyPhotosPageState extends State<MyPhotosPage> {
  late final Future<List<AssetEntity>> images;
  late final ScrollController _scrollController;
  final _padding = 20.0;
  final _spacing = 10.0;
  double? _tileHeight;
  double? _viewportHeight;
  int? _scrollIndex = 0;
  int? _tilesPerColumn;
  int _tilePerRow = 3;

  @override
  void initState() {
    super.initState();
    images = getImages(widget.folder);
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(child: LayoutBuilder(builder: (context, constraints) {
        _viewportHeight ??= constraints.maxHeight;
        return FutureBuilder<List<AssetEntity>>(
            future: images,
            builder: (BuildContext context,
                AsyncSnapshot<List<AssetEntity>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                // create grid view with text for each folder
                return LayoutBuilder(builder: (context, constraints) {
                  _viewportHeight ??= constraints.maxHeight;
                  return CustomScrollView(
                      controller: _scrollController,
                      slivers: <Widget>[
                        SliverPadding(
                            padding: EdgeInsets.all(_padding),
                            sliver: SliverGrid.count(
                              crossAxisSpacing: _spacing,
                              mainAxisSpacing: _spacing,
                              crossAxisCount: _tilePerRow,
                              children: _getContainers(snapshot.data!),
                            )),
                      ]);
                });
              }
            });
      })),
    );
  }

  _getContainers(List<AssetEntity> images) {
    var widgets = <Widget>[];
    for (final (currentIndex, AssetEntity image) in images.indexed) {
      var cont = LayoutBuilder(builder: (context, constraints) {
        _tileHeight ??= constraints.maxHeight;
        _tilesPerColumn ??= ((_viewportHeight! - _padding) / (_tileHeight! + _spacing)).ceil();
        print('Tile height: $_tileHeight');
        return ImageTile(
            image: image, tilesPerColumn: _tilesPerColumn, tilesPerRow: _tilePerRow, index: _scrollIndex, currentIndex: currentIndex);
      });
      widgets.add(cont);
    }
    return widgets;
  }

  _scrollListener() {
    _scrollIndex = (_scrollController.position.pixels / _tileHeight!).ceil();
  }
}
