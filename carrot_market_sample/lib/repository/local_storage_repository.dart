import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageRepository {
  final storage = new FlutterSecureStorage();
  Future<String?> getStoredValue(String key) async {
    try{
      return await storage.read(key: key);
    }catch(error){
      return null;
    }
  }

  Future<void> writeStoredValue(String key, String value) async {
      try{
        return await storage.write(key: key, value: value.toString());
      }catch(error){
        return null;
      }
  }

  Future<void> deleteStoredValue(String key) async {
    try {
      await storage.delete(key: key);
    } catch (exception) {
      print(exception);
    }
  }


}
