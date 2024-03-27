import 'package:photo_manager/photo_manager.dart';

Future<List<AssetPathEntity>> getFolders() async {
  final PermissionState ps = await PhotoManager.requestPermissionExtend();
  List<AssetPathEntity> albums = [];

  if (ps.isAuth) {
    // get all albums on device
    albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      hasAll: false,
    );
  } else {
    PhotoManager.openSetting();
  }

  albums.sort((a, b) => a.name.compareTo(b.name));

  return albums;
}

Future<List<AssetEntity>> getImages(AssetPathEntity album) async {
  final List<AssetEntity> images =
      await album.getAssetListRange(start: 0, end: await album.assetCountAsync);
  return images;
}

Future<AssetEntity> getFirstImage(AssetPathEntity album) async{
  return await album.getAssetListRange(start: 0, end: 1).then((value) => value.first);
}
