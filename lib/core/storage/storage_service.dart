import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class AppStorageService {
  static String _secureKey = '';

  const AppStorageService();

  Box<dynamic> get appStorage => Hive.box(
        encryptionKey: _secureKey,
      );

  Box<dynamic> customStorage(String key) => Hive.box(
        name: key,
        encryptionKey: _secureKey,
      );

  static Future<void> initalize() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    Hive.defaultDirectory = appDirectory.path;

    const secureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
        resetOnError: true,
      ),
      iOptions: IOSOptions(),
    );

    const secureKey = 'secure_key';

    if (!await secureStorage.containsKey(key: secureKey)) {
      await secureStorage.write(key: secureKey, value: const Uuid().v4());
    }

    _secureKey = await secureStorage.read(
      key: secureKey,
    ) as String;
  }
}
