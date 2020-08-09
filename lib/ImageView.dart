import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
class ImageView extends StatelessWidget{
final image;
final isFile;
final tag;

saveImage(image,isFile,index) async {
  Directory directory=await getApplicationDocumentsDirectory();
  String path=directory.path;
  File file=File(path+"image");
if(!isFile){
var data=base64Decode(image);
file.writeAsBytes(data).then((value) => {
  file=value,
  file.copy(path+"image"+index)
});
}

}
  const ImageView({Key key, this.image,this.isFile, this.tag}) : super(key: key);
@override
Widget build(BuildContext context) {
  var size=MediaQuery.of(context).size;
  return Material(
      child: InkWell(
      onTap: (){
        Navigator.of(context).pop();
      },
        child: Hero(
          tag: tag,
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(size.height/15),
                            onTap: (){
                              //saveImage(image, isFile, tag);
                              print("object");
                            },
                                  child: Container(
                    width: size.width/10,
                    height: size.height/20,
                    
                    margin: EdgeInsets.only(top: size.height/40),
                    child:Icon(Icons.file_download,size: size.height/30,),
                  ),
                ),
                Center(
                  child: Container(
                    width: size.width,
                    height: size.height/1.1,
decoration: BoxDecoration(
          image: DecorationImage(image:isFile?FileImage(image):MemoryImage(base64.decode(image)))
),

          ),
                ),
              ],
            ),
        ),
      ),
    ),
  );
}

}