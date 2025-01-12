import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../data/model/media_model.dart';
import '../../../providers/media_provider.dart';

class MediaScreen extends StatefulWidget {
  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  MediaQueryData? mqData;

  File? pickedFile;
  List<MediaModel> allMedia = [];
  bool _isLight = false;
  @override
  void initState() {
     super.initState();
     context.read<MediaProvider>().getMedia();
  }

  @override
  Widget build(BuildContext context) {
        _isLight =  Theme.of(context).brightness==Brightness.light;
    mqData = MediaQuery.of(context);
    allMedia = context.watch<MediaProvider>().fetchMedia();
    return Scaffold(
     body: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 8.0),
       child: Column(

         children: [
           Center(child: Text('Media',style: TextStyle(fontSize: 25),)),
           SizedBox(
             height: 10,
           ),
           Expanded(
             child: Consumer<MediaProvider>(builder: (context,provider,_)
             {
               return  allMedia.isNotEmpty ? ListView.builder(
                        itemCount: allMedia.length,
                        itemBuilder: (context, index) {
                          final media = allMedia[index];

                          return Column(
                            children: [
                              Container(
                                height: mqData!.size.height * 0.30,

                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                    image: FileImage(File(media.imgPath!)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: mqData!.size.height * 0.05,
                              ),
                              ElevatedButton(onPressed: (){
                                context
                                    .read<MediaProvider>()
                                    .deleteMedia(id: media.mediaId!);
                                },
                                child: Text('Remove'),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.deepPurple),
                                        borderRadius:
                                            BorderRadius.circular(25))),
                              )
                            ],
                          );
                        })
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.perm_media,
                            size: 55,
                            color: Colors.deepPurple.shade100,
                          ),
                          Text(
                            'No Media Yet!!',
                            style:
                                TextStyle(fontSize: 18, color: _isLight ? Colors.black26 : Colors.white ),
                          ),
                        ],
                      );
              }
           ),
           )
         ],
       ),
     ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        shape: CircleBorder(),
        tooltip: 'Add Media',
        onPressed: (){
          showModalBottomSheet(context: context, builder: (_){
            return Container(
              height: MediaQuery.of(context).size.height*0.12,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: mqData!.size.height*0.09,
                    child: InkWell(
                      onTap: (){
                        imageSaver();

                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image,size: 30,color: Colors.deepPurple,),
                          Text('Add Media',style: TextStyle(fontSize: 16,),)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      cameraImage();
                      Navigator.pop(context);
                    },

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_enhance,size: 30,color: Colors.deepPurple,),
                        Text('Camera',style: TextStyle(fontSize: 16,),)
                      ],
                    ),
                  ),


                ],
              ),
            );
          });
        },
      child: Icon(Icons.camera_enhance_rounded,color: Colors.white,),
      ),
    );


  }
        /// Image Save from Gallery to Database
    Future<void> imageSaver() async {

    ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image!=null) {
      CroppedFile? cropImage = await ImageCropper().cropImage(sourcePath: image.path);
      if(cropImage!=null){
       pickedFile = File(cropImage.path);
       await context.read<MediaProvider>().addMedia(mMedia: MediaModel(imgPath: pickedFile!.path ));
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image Add Successfully!!')));
      }
        }
    }

/// Image Save from Camera to Database

Future<void> cameraImage() async {
  ImagePicker picker = ImagePicker();

  XFile? image = await picker.pickImage(source: ImageSource.camera);
  if (image != null) {
    CroppedFile? cropImage = await ImageCropper().cropImage(sourcePath: image.path);
    if(cropImage!=null){
      pickedFile = File(cropImage.path);
      await context.read<MediaProvider>().addMedia(mMedia: MediaModel(imgPath: pickedFile!.path ));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image Add Successfully!!')));
    }
  }
}








  /// Delete Image
  Future<void> deleteImage({required int id}) async {
    await context.read<MediaProvider>().deleteMedia(id: id);
  }

}
