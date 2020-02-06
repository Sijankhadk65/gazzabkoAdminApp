import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class FirebaseStorageProvider {
  FirebaseStorage _firebaseStorageInstance = FirebaseStorage.instance;
  StorageReference _storageReference;
  File _image;
  // StorageUploadTask _uploadTask;

  setStorageRefrence(File image) {
    _image = image;
    _storageReference = _firebaseStorageInstance
        .ref()
        .child("users/${Path.basename(image.path)}");
  }

  Future<String> uploadFileToStorage() {
    _storageReference.putFile(_image).onComplete.then((snapshot) {
      return snapshot.ref.getDownloadURL();
    });
    return Future.value("null");
  }

  // Future<String> uploadFile(File image) {
  //   StorageReference storageReference = _firebaseStorageInstance
  //       .ref()
  //       .child('chats/${Path.basename(image.path)}}');
  //   StorageUploadTask uploadTask = storageReference.putFile(image);
  //   uploadTask.onComplete.then((value) {
  //     print('File Uploaded');
  //     storageReference.getDownloadURL().then((fileURL) {
  //       return fileURL;
  //     });
  //   });

  //   return null;
  // }
}
