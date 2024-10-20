import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _firebaseInstance = FirebaseAuth.instance;
  static final AuthService _authService = AuthService._internal();
  factory AuthService() {
    return _authService;
  }
  AuthService._internal();

  /// Sign in with email and password
  Future<({UserCredential? userCredential, String? error})> signInWithEmailAndPassword(String email, String password) async {
    UserCredential? userCredential;
    String? error;
    try {
      userCredential = await _firebaseInstance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      error = _getFirebaseExceptionMessage(e);
    } catch (e) {
      error = e.toString();
    }
    return (userCredential: userCredential, error: error);
  }

  /// Sign in with Google
  Future<({UserCredential? userCredential, String? error})> signInWithGoogle() async {
    UserCredential? userCredential;
    String? error;
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      error = _getFirebaseExceptionMessage(e);
    } catch (e) {
      error = e.toString();
    }
    return (userCredential: userCredential, error: error);
  }

  /// Register with email and password
  Future<({UserCredential? userCredential, String? error})> registerWithEmailAndPassword(String email, String password) async {
    UserCredential? userCredential;
    String? error;
    try {
      userCredential = await _firebaseInstance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      error = _getFirebaseExceptionMessage(e);
    } catch (e) {
      error = e.toString();
    }
    return (userCredential: userCredential, error: error);
  }

  // Sign out
  Future<void> signOut() async {
    return await _firebaseInstance.signOut();
  }

  /// Reset password
  Future resetPassword(String email) async {
    return await _firebaseInstance.sendPasswordResetEmail(email: email);
  }

  // Get user stream
  Stream<User?> get user {
    return _firebaseInstance.authStateChanges();
  }

  // Get current user
  User? get currentUser {
    return _firebaseInstance.currentUser;
  }

  // Get current user id
  String? get currentUserId {
    return _firebaseInstance.currentUser?.uid;
  }

  /// Get the error message from the Firebase exception
  _getFirebaseExceptionMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Email or password is incorrect.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'The email is invalid.';
      case 'user-disabled':
        return 'The user corresponding to the given email has been disabled.';
      case 'operation-not-allowed':
        return 'Email & Password accounts are not enabled.';
      case 'invalid-credential':
        return 'The credential is malformed or has expired.';
      case 'too-many-requests':
        return 'You have attempted to sign in too many times. Please try again later.';
      case 'account-exists-with-different-credential':
        return 'There already exists an account with the email address asserted by the credential. Please sign in using one of the returned providers and link the original credential to the user.';
      case 'invalid-verification-code':
        return 'The verification code of the credential is not valid.';
      case 'invalid-verification-id':
        return 'The verification ID of the credential is not valid.';
      default:
        return 'An error occurred. Please try again later.';
    }
  }
}
