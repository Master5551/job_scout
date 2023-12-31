import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_scout/User_Module/View/Before_master_page/verified_page.dart';

class LoginController extends GetxController {
   final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  
  GlobalKey<FormState> getLoginFormKey() {
    return loginFormKey;
  }
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  final isPasswordValid = false.obs;
  final isLoading = false.obs;
  

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void setEmail(String value) {
    emailController.text = value;
  }

  void setPassword(String value) {
    passwordController.text = value;
  }

  void setIsLoading(bool value) {
    isLoading.value = value;
  }

  void submitForm() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  if (_isValidEmail() && _isValidPassword()) {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar(
        "Welcome to Job Scout",
        "Wishing You Best of Luck for your Career",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.off(() => VerifiedPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackbar("No User Found With That Email", "If You are new please register first", Colors.red);
      } else if (e.code == 'wrong-password') {
        showSnackbar("Your Password doesn't match with our credentials", "If You are new please register first", Colors.red);
      } else {
        // Handle other FirebaseAuthExceptions as needed
        showSnackbar("Error", "An error occurred during sign-in", Colors.red);
      }
    }
  } else {
    showSnackbar("Error", "Invalid email or password", Colors.red);
  }
}



 
  bool _isValidEmail() {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        "OOps..! It Seems Like You have made a mistake",
        "please Fill out the email field",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (!RegExp('[a-z0-9]+@[a-z]+\\.[a-z]{2,3}').hasMatch(email)) {
      Get.snackbar(
        "OOps..! It Seems Like You have made a mistake",
        "your Email is Badly Formated",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  bool _isValidPassword() {
    String password = passwordController.text.trim();

    if (password.isEmpty) {
      Get.snackbar(
        "OOps..! It Seems Like You have made a mistake",
        "your Password is empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    

    return true;
  }

  

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    if (FirebaseAuth.instance.currentUser != null) {
      Get.offAll(() => VerifiedPage());
    }

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithGitHub() async {
    GithubAuthProvider githubProvider = GithubAuthProvider();

    return await FirebaseAuth.instance.signInWithProvider(githubProvider);
  }
}


void showSnackbar(String title, String message, Color backgroundColor) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor,
    colorText: Colors.white,
  );
}