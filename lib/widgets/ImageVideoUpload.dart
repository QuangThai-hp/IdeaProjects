import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/utils/RFString.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class ImageVideoUpload extends StatefulWidget {
  const ImageVideoUpload({Key? key}) : super(key: key);

  @override
  State<ImageVideoUpload> createState() => _ImageVideoUploadState();
}

class _ImageVideoUploadState extends State<ImageVideoUpload> {
  XFile? image;

  List _images = [];

  final ImagePicker picker = ImagePicker();

  bool _dangUploadHinhAnh = false;

  bool get dangUploadHinhAnh =>
      _dangUploadHinhAnh; //we can upload image from camera or from gallery based on parameter

  Future sendImage(ImageSource media) async {
    setState(() {
      _dangUploadHinhAnh = true;
    });
    if(media == ImageSource.gallery){
      final List<XFile>? images = await picker.pickMultiImage();
      var request = http.MultipartRequest('POST', Uri.parse(RFImagesUpload));
      //
      if(images != null)
        if(images.length > 0){
          for(var i = 0; i < images.length; i++){
            var pic = await http.MultipartFile.fromPath("image[]", images[i].path);
            request.files.add(pic);
          }
          await request.send().then((result) {
            http.Response.fromStream(result).then((response) {
              var message = jsonDecode(response.body);
              // show snackbar if input data successfully
              final snackBar = SnackBar(content: Text(message['content']));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              //get new list images
              // getImageServer();
              setState(() {
                _images = message['fileName'];
                _dangUploadHinhAnh = false;
              });
            });
          }).catchError((e) {
            print(e);
            setState(() {
              _dangUploadHinhAnh = false;
            });
          });
        }
    }else{
      var img = await picker.pickImage(source: ImageSource.camera);
      var request = http.MultipartRequest('POST', Uri.parse(RFImagesUpload));
      if(img != null) {

      }
    }
  }

  Future getImageServer() async {
  //   try{
  //
  //     final response = await http.get(Uri.parse('http://192.168.1.4/latihan/flutter_upload_image/list.php'));
  //
  //     if(response.statusCode == 200){
  //       final data = jsonDecode(response.body);
  //
  //       setState(() {
  //         _images = data;
  //       });
  //     }
  //
  //   }catch(e){
  //
  //     print(e);
  //
  //   }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    // getImageServer();
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Chọn ảnh từ thư viện hoặc camera'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      sendImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('Chọn ảnh từ thư viện'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      sendImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('Chụp ảnh'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = context.width() / 2;
    double cardHeight = context.height() / 4;

    return
        Column(
      children: [
        _images.length > 0 ?
        (_dangUploadHinhAnh == true ? Center(child: CircularProgressIndicator(),)  :
        GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _images.length,
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: cardWidth / cardHeight
          ),
          itemBuilder: (context, index) => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: new BorderRadius.circular(12.0),
                  child:Image(
                    image: NetworkImage(_images[index]),
                    fit: BoxFit.cover,
                    height: context.height() / 6,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                // SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Text(model.name, style: primaryTextStyle(color: appStore.textPrimaryColor)),
                    ],
                  ),
                )
              ],
            ),
          ),
        )) :
        (_dangUploadHinhAnh == true ? Center(child: CircularProgressIndicator(),) : Center(child: Text("Chưa chọn hình ảnh"))),
        TextButton(onPressed: () => myAlert(), child: Icon(Icons.upload))
      ],
    );
  }
}