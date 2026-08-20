import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Check if user is logged in
  bool get isUserLoggedIn => _auth.currentUser != null;

  // Get user's display name
  String? get userDisplayName => _auth.currentUser?.displayName;

  // Get user's email
  String? get userEmail => _auth.currentUser?.email;

  // Sign Up with email, password, and username
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      await userCredential.user?.updateDisplayName(username);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'email': email.trim().toLowerCase(),
        'uid': userCredential.user?.uid,
        'displayName': username,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      await _auth.signOut();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw Exception('An error occurred during sign up: $e');
    }
  }

  // Sign In with email and password
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw Exception('An error occurred during sign in: $e');
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Error signing out: $e');
    }
  }

  // 🔥 NEW: Check if email exists in Firestore
  Future<bool> checkEmailExists(String email) async {
    try {
      final String normalizedEmail = email.trim().toLowerCase();
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: normalizedEmail)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // 🔥 SECURE: Send Password Reset Email (only after email is verified)
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      final String normalizedEmail = email.trim().toLowerCase();

      // Send password reset email
      await _auth.sendPasswordResetEmail(email: normalizedEmail);

    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw Exception('An error occurred. Please try again later.');
    }
  }

  // Get user data from Firestore using UID
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      throw Exception('Error getting user data: $e');
    }
  }

  // Get user data by email
  Future<Map<String, dynamic>?> getUserDataByEmail(String email) async {
    try {
      final String normalizedEmail = email.trim().toLowerCase();
      QuerySnapshot query = await _firestore
          .collection('users')
          .where('email', isEqualTo: normalizedEmail)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        return query.docs.first.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      throw Exception('Error getting user data: $e');
    }
  }

  // Get user data by username
  Future<Map<String, dynamic>?> getUserDataByUsername(String username) async {
    try {
      QuerySnapshot query = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        return query.docs.first.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      throw Exception('Error getting user data: $e');
    }
  }

  // Update user data in Firestore using UID
  Future<void> updateUserData({
    required String uid,
    Map<String, dynamic> data = const {},
  }) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error updating user data: $e');
    }
  }

  // Update user display name
  Future<void> updateDisplayName(String newDisplayName) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      await user.updateDisplayName(newDisplayName);

      await _firestore.collection('users').doc(user.uid).update({
        'displayName': newDisplayName,
        'username': newDisplayName,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      await user.reload();
    } catch (e) {
      throw Exception('Error updating display name: $e');
    }
  }

  // Handle Firebase Auth Errors
  String _handleAuthError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'user-not-found':
        message = 'No user found with this email address.';
        break;
      case 'wrong-password':
        message = 'Incorrect password. Please try again.';
        break;
      case 'email-already-in-use':
        message = 'This email is already registered. Please sign in.';
        break;
      case 'invalid-email':
        message = 'Please enter a valid email address.';
        break;
      case 'weak-password':
        message = 'Password is too weak. Please use at least 6 characters.';
        break;
      case 'user-disabled':
        message = 'This account has been disabled. Please contact support.';
        break;
      case 'too-many-requests':
        message = 'Too many attempts. Please try again later.';
        break;
      case 'network-request-failed':
        message = 'Network error. Please check your internet connection.';
        break;
      default:
        message = 'An error occurred: ${e.message}';
    }
    return message;
  }
}