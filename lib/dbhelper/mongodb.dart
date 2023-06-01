import 'dart:developer';

import 'package:auropay/dbhelper/constant.dart';

class MongoDatabase{
  static var db , userCollection;
  static connect() async{
    db = await db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection('USER_COLLECTION');
  }
}
