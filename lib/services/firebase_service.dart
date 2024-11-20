import 'package:cloud_firestore/cloud_firestore.dart';

// Inicializa la instancia de FirebaseFirestore
FirebaseFirestore db = FirebaseFirestore.instance;

// Función para obtener la lista de usuarios desde Firestore
Future<List<Map<String, dynamic>>> getUsuarios() async {
  List<Map<String, dynamic>> usuarios = [];

  // Referencia a la colección "usuarios"
  CollectionReference collectionReferenceUsuarios = db.collection('usuarios');
  QuerySnapshot queryUsuarios = await collectionReferenceUsuarios.get();

  // Recorre los documentos y agrega cada uno a la lista con su 'uid'
  for (var documento in queryUsuarios.docs) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final usuario = {
      'uid': documento.id,
      'nombre': data['nombre'],
      'email': data['email'],
      'nocuenta': data['nocuenta'],
      'aPaterno': data['aPaterno'], // Incluye cualquier otro campo necesario
    };
    usuarios.add(usuario);
  }

  return usuarios;
}

// Función para agregar un nuevo usuario a Firestore
Future<void> agregarUsuario(
    String nombre, String email, String nocuenta) async {
  await db.collection('usuarios').add({
    'nombre': nombre,
    'email': email,
    'nocuenta': nocuenta,
  });
}

// Función para editar un usuario existente en Firestore
Future<void> editUsuario(
    String uid, String eNombre, String eMail, String eCuenta) async {
  await db.collection('usuarios').doc(uid).set({
    'nombre': eNombre,
    'email': eMail,
    'nocuenta': eCuenta,
  });
}
