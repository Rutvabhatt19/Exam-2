// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// abstract mixin class FirebaseGoogleSignIn {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   Future<User?> signInWithGoogle() async {
//     try {
//       GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
//
//       if (googleSignInAccount == null) {
//         return null;
//       }
//
//       GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;
//
//       AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//
//       UserCredential authResult = await _auth.signInWithCredential(credential);
//
//       return authResult.user;
//     } catch (e) {
//       print("Error signing in with Google: $e");
//       return null;
//     }
//   }
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//     await _googleSignIn.signOut();
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

mixin class FirebaseGoogleSignIn {
  static final FirebaseGoogleSignIn _instance = FirebaseGoogleSignIn._internal();

  factory FirebaseGoogleSignIn() => _instance;

  FirebaseGoogleSignIn._internal();

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  UserDataModal? userDataModal;
  Future<User?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      this.userDataModal=new UserDataModal(
        Name: this._googleSignIn.currentUser!.displayName,
        email: this._googleSignIn.currentUser!.email,
        photoUrl: this._googleSignIn.currentUser!.photoUrl,
      );
      if (googleSignInAccount == null) {
        return null;
      }

      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential authResult =
      await _auth.signInWithCredential(credential);

      return authResult.user;
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}


class UserDataModal{
  String? Name;
  String? email;
  String? photoUrl;


  UserDataModal({this.Name,this.email,this.photoUrl});



  UserDataModal.fromjason(Map<String,dynamic> json){
    Name=json['Name'];
    email=json['email'];
    photoUrl=json['photoUrl'];
  }
  Map<String,dynamic> toJason(){
    final Map<String,dynamic> mapdata=new Map<String,dynamic>();
    mapdata['Name']=this.Name;
    mapdata['email']=this.email;
    mapdata['photoUrl']=this.photoUrl;

    return mapdata;
  }
}