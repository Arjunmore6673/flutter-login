import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/common/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class MyHomePageNew extends StatefulWidget {
  MyHomePageNew({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageNew> {
  File _image;
  String _uploadedFileURL;
  bool isLoading = false;

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    setState(() {
      isLoading = true;
    });
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('images/${_image.path}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      print(fileURL);
      setState(() {
        _uploadedFileURL = fileURL;
        isLoading = false;
      });
    });
  }

  Future<void> deleteImage() async {
    var fileUrl = Uri.decodeFull(Path.basename(
            "https://firebasestorage.googleapis.com/v0/b/flutterapp-42653.appspot.com/o/images%2Fstorage%2Femulated%2F0%2FDCIM%2FCamera%2FIMG_20200129_202511.jpg?alt=media&token=274c22d4-1102-418c-8a26-a0b1781e732c"))
        .replaceAll(new RegExp(r'(\?alt).*'), '');
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileUrl);
    await firebaseStorageRef.delete();
    print("DElted successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore File Upload'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text('Selected Image'),
                        _image != null
                            ? Image.file(
                                _image,
                                // height: 150,
                                height: 150,
                                width: 150,
                              )
                            : Container(
                                child: Center(
                                  child: Text(
                                    "No Image is Selected",
                                  ),
                                ),
                                height: 150,
                              ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('Uploaded Image'),
                        _uploadedFileURL != null
                            ? GestureDetector(
                                onTap: () {
                                  deleteImage();
                                },
                                child: Image.network(
                                  _uploadedFileURL,
                                  height: 150,
                                  width: 150,
                                ),
                              )
                            : GestureDetector(
                                onTap: deleteImage,
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      "No Image is Selected",
                                    ),
                                  ),
                                  height: 150,
                                ),
                              ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            _image != null
                ? isLoading
                    ? CircularProgressCommon()
                    : RaisedButton(
                        child: Text('Upload Image'),
                        onPressed: uploadFile,
                        color: Colors.red,
                      )
                : Container()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: chooseFile,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
