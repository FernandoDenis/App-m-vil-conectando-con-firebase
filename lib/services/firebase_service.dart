import 'package:cloud_firestore/cloud_firestore.dart';

// Creamos la instancia de FirebaseFirestore
FirebaseFirestore db = FirebaseFirestore.instance;

// Función para obtener la lista de usuarios desde Firestore
Future<List<Map<String, dynamic>>> getUsuarios() async {
  // Lista para almacenar los registros
  List<Map<String, dynamic>> usuarios = [];

  // Referencia a la colección "usuarios"
  CollectionReference collectionReferenceUsuarios = db.collection('usuarios');

  // Obtenemos los documentos de la colección
  QuerySnapshot queryUsuarios = await collectionReferenceUsuarios.get();

  // Recorremos los documentos y los añadimos a la lista
  for (var documento in queryUsuarios.docs) {
    usuarios.add(documento.data() as Map<String, dynamic>);
  }

  return usuarios;
}

// Función para agregar un usuario a Firestore
Future<void> agregarUsuario(
    String nNombre, String nEmail, String nCuenta) async {
  await db.collection('usuarios').add({
    'nombre': nNombre,
    'email': nEmail,
    'nocuenta': nCuenta,
  });
}
