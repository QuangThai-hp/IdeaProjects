import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  late File uploadimage; //variable for choosed file

  Future<void> chooseImage() async {
    // var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    // setState(() {
    //   uploadimage = choosedimage;
    // });
  }

  Future<void> uploadImage() async {
    //show your own loading or progressing code here

    String uploadurl = "http://192.168.0.112/test/image_upload.php";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    try{
      List<int> imageBytes = uploadimage.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      //convert file image to Base64 encoding
      // var response = await http.post(
      //     uploadurl,
      //     body: {
      //       'image': baseimage,
      //     }
      // );
      // if(response.statusCode == 200){
      //   var jsondata = json.decode(response.body); //decode json data
      //   if(jsondata["error"]){ //check error sent from server
      //     print(jsondata["msg"]);
      //     if error return from server, show message from server
        // }else{
        //   print("Upload successful");
        // }
      // }else{
      //   print("Error during connection to server");
        //there is error during connecting to server,
        //status code might be 404 = url not found
      // }
    }catch(e){
      print("Error during converting to Base64");
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image to Server"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body:Container(
        height:300,
        alignment: Alignment.center,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center, //content alignment to center
          children: <Widget>[
            Container(  //show image here after choosing image
                child:uploadimage == null?
                Container(): //if uploadimage is null then show empty container
                Container(   //elese show image here
                    child: SizedBox(
                        height:150,
                        child:Image.file(uploadimage) //load image from file
                    )
                )
            ),

            Container(
              //show upload button after choosing image
                child:uploadimage == null?
                Container(): //if uploadimage is null then show empty container
                Container(   //elese show uplaod button
                    // child: RaisedButton.icon(
                    //   onPressed: (){
                    //     uploadImage();
                    //     //start uploading image
                    //   },
                    //   icon: Icon(Icons.file_upload),
                    //   label: Text("UPLOAD IMAGE"),
                    //   color: Colors.deepOrangeAccent,
                    //   colorBrightness: Brightness.dark,
                    //   //set brghtness to dark, because deepOrangeAccent is darker coler
                    //   //so that its text color is light
                    // )
                )
            ),

            Container(
              // child: RaisedButton.icon(
              //   onPressed: (){
              //     chooseImage(); // call choose image function
              //   },
              //   icon:Icon(Icons.folder_open),
              //   label: Text("CHOOSE IMAGE"),
              //   color: Colors.deepOrangeAccent,
              //   colorBrightness: Brightness.dark,
              // ),
            )
          ],),
      ),
    );
  }
///////
}


// 111
