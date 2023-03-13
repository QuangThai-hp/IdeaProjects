import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/providers/SanPham.dart';
import 'package:room_finder_flutter/utils/RFString.dart';
import 'package:room_finder_flutter/widgets/FullScreenImageViewer.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ImageVideoUpload extends StatefulWidget {
  List<String> images = [];

  ImageVideoUpload({required this.images}); // const ImageVideoUpload({Key? key}) : super(key: key);

  @override
  State<ImageVideoUpload> createState() => _ImageVideoUploadState();
}

class _ImageVideoUploadState extends State<ImageVideoUpload> {

  XFile? image;

  List<String> _deletedImages = [];

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
                for(var i = 0; i<message['fileName'].length; i++)
                  widget.images.add(message['fileName'][i]);
                _setPathImages();

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
        var pic = await http.MultipartFile.fromPath("image[]", img.path);
        request.files.add(pic);

        await request.send().then((result) {
          http.Response.fromStream(result).then((response) {
            var message = jsonDecode(response.body);
            print(message);
            // show snackbar if input data successfully
            final snackBar = SnackBar(content: Text(message['content']));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            setState(() {
              widget.images!.add(message['fileName'][0]);
              _dangUploadHinhAnh = false;
            });
            _setPathImages();
          });
        }).catchError((e) {
          print(e);
          setState(() {
            _dangUploadHinhAnh = false;
          });
        });
      }
    }
  }

  void deleteImageFromServer(String fileName) {
    setState(() {
      _deletedImages.add(fileName);
      widget.images!.removeWhere((element) => element == fileName);
    });
    _setPathImages();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    // getImageServer();
  }

  Future<void> _setPathImages() async{
    SanPham sanPham = Provider.of<SanPham>(context, listen: false);
    sanPham.field_anh_san_pham = widget.images;
    sanPham.field_deleted_anh_san_pham = _deletedImages;
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
    double cardHeight = context.height() / 3.5;

    return
        Column(
          children: [
            widget.images!.length > 0 ?
            (_dangUploadHinhAnh == true ? Center(child: CircularProgressIndicator(),)  :
            GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.images!.length,
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
                      child:GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                                return FullScreenImageViewer(
                                  imageUrl: widget.images![index],
                                  tag: "generate_a_unique_tag",
                                );
                              }));
                        },
                        child: Hero(
                          child: Image(
                            image: NetworkImage(widget.images![index]),
                            fit: BoxFit.cover,
                            height: context.height() / 6,
                            width: MediaQuery.of(context).size.width,
                          ),
                          tag: widget.images![index],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        onPressed: () {
                          // print(_images[index]);
                          deleteImageFromServer(widget.images![index]);
                        },
                        icon: Icon(Icons.delete, size: 16.0,),
                        label: Text('Xóa'),
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