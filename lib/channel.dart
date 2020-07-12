import 'aqueduct_crud.dart';
import 'controller/user_controller.dart';

class AqueductCrudChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = Config(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username,
      config.database.password,
      config.database.host,
      config.database.port,
      config.database.databaseName,
    );
    context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint {
    final router = Router();
    router.route('/user/[:id]').link(() => UserController(context));
    return router;
  }
}

class Config extends Configuration {

  Config(String path) : super.fromFile(File(path));

  DatabaseConfiguration database;
}