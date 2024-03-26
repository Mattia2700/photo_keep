import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../handlers/files.dart';
import '../widgets/container.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'PhotoKeep'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Future<List<AssetPathEntity>> folders;

  @override
  void initState() {
    super.initState();
    folders = getFolders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<AssetPathEntity>>(
          future: folders,
          builder: (BuildContext context,
              AsyncSnapshot<List<AssetPathEntity>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              // create grid view with text for each folder
              return CustomScrollView(slivers: <Widget>[
                SliverPadding(
                    padding: const EdgeInsets.all(20.0),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      crossAxisCount: 2,
                      children: _getContainers(snapshot.data!),
                    )),
              ]);
            }
          },
        ),
      ),
    );
  }

  _getContainers(List<AssetPathEntity> folders) {
    var widgets = <Widget>[];
    for (final AssetPathEntity folder in folders) {
      var cont = AlbumTile(folder: folder);
      widgets.add(cont);
    }
    return widgets;
  }
}
