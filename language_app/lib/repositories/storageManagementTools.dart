import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:language_app/view_models/errorViewModel.dart';


class StorageManagementTools {

  static final StorageManagementTools instance =
  StorageManagementTools();


  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage(File image) async {
    String url;
    if (image == null) {
      url = null;
    } else {
      try {
        final StorageReference folderRef =
        firebaseStorage.ref().child('Attachments');
        DateTime timeKey = new DateTime.now();
        final StorageReference imageRef =
        folderRef.child(timeKey.toString() + '.jpg');
        final StorageUploadTask uploadTask = imageRef.putFile(image);
        final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
        url = await downloadUrl.ref.getDownloadURL();
      } catch (e) {
        print(e);
        throw e;
      }
    }
    return url;
  }

  Future<void> deleteFileFromFirebaseStorage(String url) async {
    if (url == null) {
      throw ErrorViewModel.newFromMessage("Delete failed: url == null!");
    } else {
      try {
        final StorageReference fileRef =
        await firebaseStorage.getReferenceFromUrl(url);
        await fileRef.delete();
      } catch (e) {
        print(e);
        throw e;
      }
    }
  }

  Future<String> uploadPDF(File pdf) async {
    String url;
    if (pdf == null) {
      url = null;
    } else {
      try {
        final StorageReference folderRef =
        firebaseStorage.ref().child('ReportsPDFFiles');
        DateTime timeKey = new DateTime.now();
        final StorageReference pdfRef =
        folderRef.child(timeKey.toString() + '.pdf');
        final StorageUploadTask uploadTask = pdfRef.putFile(pdf);
        final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
        url = await downloadUrl.ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
    }
    return url;
  }
}
