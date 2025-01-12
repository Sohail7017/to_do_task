


import '../loacal_data/db_helper.dart';

class MediaModel{
  int? mediaId;
  String? imgPath;
  String? videoPath;

  MediaModel({this.mediaId,  this.imgPath,this.videoPath});

  /// convert From map To model

  factory MediaModel.fromMap(Map<String,dynamic> map) {
    return MediaModel(
      mediaId: map[DBHelper.MEDIA_COLUMN_ID],

      imgPath: map[DBHelper.MEDIA_COLUMN_IMG],

      videoPath: map[DBHelper.MEDIA_COLUMN_VID],

    );
  }
  /// model to toMap
Map<String,dynamic> toMap(){
    return{
      DBHelper.MEDIA_COLUMN_IMG:imgPath,
      DBHelper.MEDIA_COLUMN_VID: videoPath,
    };
}

}