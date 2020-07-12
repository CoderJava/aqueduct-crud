import 'package:aqueduct_crud/aqueduct_crud.dart';

class User extends ManagedObject<_User> implements _User {}

class _User {
  @primaryKey
  int id;
  @Column(unique: true)
  String name;
}