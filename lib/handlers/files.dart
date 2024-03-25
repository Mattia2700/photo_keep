import 'package:photo_manager/photo_manager.dart';

Future<List<AssetPathEntity>> getPhotosFolders() async {
  final PermissionState ps = await PhotoManager.requestPermissionExtend();
  List<AssetPathEntity> albums = [];

  if (ps.isAuth) {
    print('Permission granted');
    // get all albums on device
     albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      hasAll: false,
    );
  }

  return albums;
}

// Future<List<String>> getDisplayedFolderNames(Future<List<Directory>> folders) async {
//   List<String> folderNames = [];
//
//   for (var folder in await folders) {
//     folderNames.add(folder.path.split('/').last);
//   }
//
//   print(folderNames);
//
//   return folderNames;
// }