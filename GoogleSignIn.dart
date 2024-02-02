import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app_with_opps/MixinforUI.dart';
import 'package:firebase_chat_app_with_opps/Provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

abstract class Google_Sigin {
  Future<void> Signin(dynamic context);
  Future<void> logout();
}

class GoogleHelper extends Google_Sigin with ForUI {
  GoogleSignIn googleSignIn = GoogleSignIn();
  UserDataModal Googleuser =
      UserDataModal(Email: '', uid: '', Name: '', PhotoUrl: '');

  @override
  Future<void> Signin(dynamic context) async {
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        Map<String, dynamic> userData = {
          'uid': user.uid,
          'Email': user.email,
          'Name': user.displayName,
          'PhotoURL': user.photoURL,
        };
        bool emailExists = await checkIfEmailExists(user.email!);
        if (!emailExists) {
          Googleuser = UserDataModal(
              Email: user.email!,
              uid: user.uid!,
              Name: user.displayName!,
              PhotoUrl: user.photoURL!);
          Provider.of<NameProvider>(context, listen: false)
              .updateUserInfo(user.displayName!, user.email!);

          await FirebaseFirestore.instance
              .collection("USERS")
              .doc(user.uid)
              .set(userData);
        }
      }
    }
    print("Goolge sign in");
  }

  @override
  Future<void> logout() async {
    await googleSignIn.signOut();
  }

  Future<bool> checkIfEmailExists(String email) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection(collectionName)
        .where('Email', isEqualTo: email)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }
}

class UserDataModal {
  String? Name;
  String? Email;
  String? PhotoUrl;
  String? uid;

  UserDataModal(
      {required this.Name,
      required this.Email,
      required this.PhotoUrl,
      required this.uid});
}
