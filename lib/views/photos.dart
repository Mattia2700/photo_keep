import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_keep/widgets/list.dart';
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
  double? _viewportHeight;

  @override
  void initState() {
    super.initState();
    images = getImages(widget.folder);
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
                return PartialGrid(imagePaths: snapshot.data!);
              }
            });
      })),
    );
  }
}
