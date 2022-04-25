import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/inputs/sign_up.dart';
import '../../domain/repositories/sign_up_repository.dart';
import '../../domain/responses/sign_up_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final FirebaseAuth _auth;
  SignUpRepositoryImpl(this._auth,);
  CollectionReference users = FirebaseFirestore.instance.collection('usuarios');

  @override
  Future<SignUpResponse> register(SignUpData data) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );
      await userCredential.user!.updateDisplayName(
        "${data.name} ${data.lastname}",
      );
      await users.doc('${userCredential.user!.uid}').set({
        'nombre': data.name,
        'apellido': data.lastname,
        'correo': data.email,
        'ci': data.ci,
        });    
      return SignUpResponse(null, userCredential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: avoid_print
        print('La contraseña proporcionada es demasiado débil.');
      } else if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print('La cuenta ya existe para ese correo electrónico.');
      }
      return SignUpResponse(parseStringToSignUpError(e.code), null);
    }
  }
}
