import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';


class UploadVideo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Upload MySQL',
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File _video;

  Future getVideoGallery() async{
    var imageFile = await ImagePicker.pickVideo(source: ImageSource.gallery);

    setState(() {
      _video = imageFile;
    });
  }

  Future getVideoCamera() async{
    var imageFile = await ImagePicker.pickVideo(source: ImageSource.camera);

    setState(() {
      _video = imageFile;
    });
  }

  Future uploadVideo(File videoFile) async{
    var uri = Uri.parse("https://androiddeveloper1990.000webhostapp.com/uploadVideo.php");
    var request = new MultipartRequest("POST", uri);

    var multipartFile = await MultipartFile.fromPath("video", videoFile.path);
    request.files.add(multipartFile);
    StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      Toast.show(value, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    });

    if(response.statusCode==200){
      Toast.show("Video Uploaded Successfully!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }else{
      Toast.show("Video upload failed!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Video"),),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _video==null
                ? new Text("No video selected!")
                : new Text("video is selected"),
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Icon(Icons.video_library),
                  onPressed: getVideoGallery,
                ),
                RaisedButton(
                  child: Icon(Icons.videocam),
                  onPressed: getVideoCamera,
                ),
                RaisedButton(
                  child: Text("UPLOAD video"),
                  onPressed:(){
                    uploadVideo(_video);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}