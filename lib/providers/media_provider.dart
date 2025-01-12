import 'package:flutter/foundation.dart';

import '../data/loacal_data/db_helper.dart';
import '../data/model/media_model.dart';

class MediaProvider extends ChangeNotifier{
  DBHelper? myDb;
  MediaProvider({required this.myDb});

  List<MediaModel> _mediaData = [];

  /// Events
/// 1. Add Media
  Future<void> addMedia({required MediaModel mMedia}) async{
    bool isAddMedia = await myDb!.addMedia(mMedia: mMedia);
    if(isAddMedia){
      _mediaData = await myDb!.fetchAllMedia();
      notifyListeners();
    }
  }

  /// 2. Get Media data After Add
  List<MediaModel> fetchMedia() => _mediaData;

  /// 3. Get all Media Data Before Add Data

Future<void> getMedia() async{
    _mediaData = await myDb!.fetchAllMedia();
    notifyListeners();
}
/// 4. Delete media
  Future<void> deleteMedia({required int id}) async {
    bool isDelete = await myDb!.deleteMedia(id: id);
    if (isDelete) {
      _mediaData = await myDb!.fetchAllMedia();
      notifyListeners();
    }
  }


}