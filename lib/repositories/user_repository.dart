import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final rootURL = "gs://mycounselor-c5110.appspot.com";

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firebaseFirestore;
  final FacebookAuth _facebookAuth;

  final storage = FirebaseStorage.instance;

  UserRepository(
      {FirebaseAuth firebaseAuth,
      GoogleSignIn googleSignIn,
      FirebaseFirestore firebaseFirestore,
      FacebookAuth facebookAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _facebookAuth = facebookAuth ?? FacebookAuth.instance;

  //sign up with email and password
  //return value is a error string
  //if sign up success, the OnUserStateChange auto trigger
  Future<String> createAccount(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    return "";
  }

  //sign in with email and password
  //return value is a error string
  //if login success, the OnUserStateChange auto trigger
  Future<String> signInWithEmailAndPass(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }

    return "";
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
      _facebookAuth.logOut()
    ]);
  }

  Future<bool> isSignedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  ///Signin with Google account
  ///
  ///If [credential] is null means sign in normal with google account
  ///
  ///If [credential] is not null, connect to Facebook credential after sign in success
  ///
  ///Because Google and Facebook use difference AuthProvider so we need to link credential
  ///
  ///If not link credential, user only sign in with either Facebook or Google
  Future<dynamic> signInWithGoogle({AuthCredential credential}) async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      //get list login method has been register
      List<String> listLoginMethod = await _firebaseAuth
          .fetchSignInMethodsForEmail(googleSignInAccount.email);

      //if user already sign in with facebook and not sign in with google
      //require user sign in with facebook to link credential
      if (listLoginMethod.contains("facebook.com") &&
          !listLoginMethod.contains("google.com")) {
        return authCredential;
      } else {
        if (credential == null) {
          await _firebaseAuth.signInWithCredential(authCredential);
        } else {
          await _firebaseAuth
              .signInWithCredential(authCredential)
              .then((value) => value.user.linkWithCredential(credential));
        }
      }
      return "";
    } catch (e) {
      return e.toString();
    }
  }

  ///Signin with Facebook account
  ///
  ///If [credential] is null means sign in normal with Facebook account
  ///
  ///If [credential] is not null, connect to Google credential after sign in success
  ///
  ///Because Google and Facebook use difference AuthProvider so we need to link credential
  ///
  ///If not link credential, user only sign in with either Facebook or Google
  Future<dynamic> signInWithFacebook({AuthCredential credential}) async {
    // by default the login method has the next permissions ['email','public_profile']
    LoginResult loginResult = await _facebookAuth.login();
    if (loginResult.status == LoginStatus.success) {
      // sign in with facebook credential
      FacebookAuthCredential fbCredential =
          FacebookAuthProvider.credential(loginResult.accessToken.token);

      //credential null mean login by facebook credential
      //else login by facebook first, after that link to credential
      if (credential == null) {
        await _firebaseAuth.signInWithCredential(fbCredential);
      } else {
        await _firebaseAuth
            .signInWithCredential(fbCredential)
            .then((value) => value.user.linkWithCredential(credential));
      }

      return "";
    } else if (loginResult.status == LoginStatus.failed) {
      return loginResult.message;
    } else if (loginResult.status == LoginStatus.cancelled) {
      return "Your request has cancelled";
    }
  }

  Future<String> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    try {
      // final credential = await SignInWithApple.getAppleIDCredential(
      //   scopes: [
      //     AppleIDAuthorizationScopes.email,
      //     AppleIDAuthorizationScopes.fullName,
      //   ],
      //   nonce: nonce,
      // );
      // print(credential);
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
          // clientId: 'mcysd.flutter.plugin.firebaselogin',
          clientId: 'mcysd.plugin.firebaselogin',
          redirectUri: Uri.parse(
            'https://fiutter-tutorials.firebaseapp.com/__/auth/handler',
          ),
        ),
        //nonce: nonce,
      );

      print(credential);
      // final oauthCredential = OAuthProvider("apple.com")
      //     .credential(idToken: credential.identityToken, rawNonce: rawNonce);
      // await _firebaseAuth.signInWithCredential(oauthCredential);
      return "";
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<User> getUserInfo() async {
    return _firebaseAuth.currentUser;
  }

  Stream<User> get user => _firebaseAuth.authStateChanges();

  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    return "";
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Future<String> verifyPasswordResetCode(String verifyCode) {
  //   return _firebaseAuth.verifyPasswordResetCode(verifyCode);
  // }

  // Future<void> updateNewPassword(String newPassword, String code) {
  //   return _firebaseAuth.confirmPasswordReset(
  //       newPassword: newPassword, code: code);
  // }

  // Future<MYCUserInfo> getFirebaseUserInfo() async {
  //   String uid = await UserStorage.instance.getUid();
  //   MYCUserInfo result;
  //   await _firebaseFirestore
  //       .collection("user")
  //       .doc(uid)
  //       .get()
  //       .then((value) => result = MYCUserInfo.fromMap(value.data()));
  //   return result;
  // }

  // Future<void> sendFCMToken() async {
  //   var fcmToken = await FirebaseMessaging.instance.getToken();
  //   print("fcmToken=$fcmToken");
  //   var uid = await UserStorage.instance.getUid();
  //   await _firebaseFirestore
  //       .collection("user")
  //       .doc(uid)
  //       .update({"FCMToken": fcmToken});
  // }

  // Future<void> updateUserInfor(Map<String, dynamic> data, VoidCallback onCompleted) async {
  //   String uid = await UserStorage.instance.getUid();
  //   return await _firebaseFirestore
  //       .collection("user")
  //       .doc(uid)
  //       .update(data)
  //       .then((value) => onCompleted());
  // }

  // bool _isDone = false;
  // Future updateUserAvatar(File file, ValueChanged<double> callback,
  //     ValueChanged<String> onCompleted) async {
  //   final time = Duration(seconds: 10);
  //   storage.setMaxOperationRetryTime(time);
  //   storage.setMaxUploadRetryTime(time);
  //   storage.setMaxDownloadRetryTime(time);

  //   String uid = await UserStorage.instance.getUid();
  //   final url = "$rootURL/user/photo/$uid/$uid";
  //   final metadata = SettableMetadata(contentType: "image/jpg");

  //   final uploadRef = storage.refFromURL(url);
  //   final task =
  //       uploadRef.putFile(file, metadata).snapshotEvents;
  //   task.listen((snapshot) {
  //     final progress = (snapshot.bytesTransferred / snapshot.totalBytes);
  //     callback(progress);
  //     print("upload progress: $progress");
  //     if (progress == 1.0) {
  //       _updateAvatarUrl(uid, uploadRef, onCompleted);
  //     }
  //   }, onError: (err) {
  //     if (err.code == 'permission-denied') {
  //       print('User does not have permission to upload to this reference.');
  //     } else {
  //       print("err:${err.toString()}");
  //     }
  //     onCompleted(null);
  //   }, onDone: () {
  //     print("onDone.");
  //   });
  // }

  // Future _updateAvatarUrl(String uid, Reference uploadRef,
  //     ValueChanged<String> onCompleted) async {
  //   var downloadUrl = await uploadRef.getDownloadURL();
  //   if (_isDone) {
  //     return null;
  //   }

  //   if (downloadUrl != null) {
  //     _isDone = true;
  //   } else {
  //     return null;
  //   }

  //   print("downloadUrl=$downloadUrl");
  //   UserStorage.instance.setAvatar(downloadUrl);
  //   final data = Map<String, dynamic>();
  //   data["photoUrl"] = downloadUrl;
  //   print("data=${data.toString()}");

  //   var result = await _firebaseFirestore
  //       .doc("user/$uid")
  //       .update(data)
  //       .whenComplete(() => onCompleted(downloadUrl))
  //       .catchError((e) => print("error: ${e.toString()}"));
  //   return result;
  // }
}
