import 'package:aqueduct_crud/aqueduct_crud.dart';
import 'package:aqueduct_crud/model/user.dart';

class UserController extends ResourceController {
  final ManagedContext context;

  UserController(this.context);

  @Operation.get()
  Future<Response> getAllUsers() async {
    final listUsers = await Query<User>(context).fetch();
    return Response.ok({'data': listUsers});
  }

  @Operation.post()
  Future<Response> createUser(@Bind.body() User inputUser) async {
    final query = Query<User>(context)..values = inputUser;
    final insertedUser = await query.insert();
    return Response.ok(insertedUser);
  }

  @Operation.get('id')
  Future<Response> getUserById(@Bind.path('id') int id) async {
    final query = Query<User>(context)..where((element) => element.id).equalTo(id);
    final user = await query.fetchOne();
    if (user == null) {
      return Response.notFound();
    }
    return Response.ok(user);
  }

  @Operation.delete('id')
  Future<Response> deleteUserById(@Bind.path('id') int id) async {
    final query  = Query<User>(context)..where((element) => element.id).equalTo(id);
    final deletedUser = await query.delete();
    if (deletedUser > 0) {
      return Response.ok({'message': 'Deleted successfully'});
    }
    return Response.notFound();
  }
}
