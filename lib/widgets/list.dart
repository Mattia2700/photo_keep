import 'package:flutter/cupertino.dart';
import 'package:photo_keep/widgets/container.dart';
import 'package:photo_manager/photo_manager.dart';

class PartialGrid extends StatelessWidget {
  final List<AssetEntity> imagePaths;

  const PartialGrid({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverPadding(
          padding: const EdgeInsets.all(10.0),
          sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0),
              itemBuilder: (context, index) {
                return ImageTile(image: imagePaths[index]);
              },
              itemCount: imagePaths.length)),
    ]);
  }
}
