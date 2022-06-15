import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/account.dart';
import '../authentication.dart';

class UserFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users = _firestoreInstance.collection('users');

  static Future<dynamic> setUser(Account newAccount) async {
    try {
      await users.doc(newAccount.id).set({
        'id': newAccount.id,
        'user_id': newAccount.userId,
        'email': newAccount.email,
        'password': newAccount.password,
        'display_name': newAccount.displayName,
        'default_break_time': newAccount.defaultBreakTime,
        'created_time': Timestamp.now(),
        'updated_time': Timestamp.now(),
      });
      print('log ::: UserFirestore.setUser / success');
      return true;
    } on FirebaseException catch (error) {
      print('log ::: UserFirestore.setUser / failed');
      return false;
    }
  }

  static Future<dynamic> getUser(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      Account currentAccount = Account(
        id: uid,
        userId: data['user_id'],
        email: data['email'],
        password: data['password'],
        displayName: data['display_name'],
        defaultBreakTime: data['default_break_time'],
        createdTime: data['created_time'],
        updatedTime: data['updated_time'],
      );
      Authentication.myAccount = currentAccount;
      print('log ::: UserFirestore.getUser / success');
      return true;
    } on FirebaseException catch (error) {
      print('log ::: UserFirestore.getUser / failed');
      return false;
    }
  }

// static Future<dynamic> updateUser(Account updateAccount) async {
//   try {
//     await users.doc(updateAccount.id).update({
//       'name': updateAccount.name,
//       'image_path': updateAccount.imagePath,
//       'user_id': updateAccount.userId,
//       'self_introduction': updateAccount.selfIntroduction,
//       'updated_time': Timestamp.now(),
//     });
//     print('log ::: UserFirestore.updateUser / success');
//     return true;
//   } on FirebaseException catch(error) {
//     print('log ::: UserFirestore.updateUser / failed');
//     return false;
//   }
// }

// static Future<Map<String, Account>?> getPostUserMap(List<String> accountIds) async {
//   Map<String, Account> map = {};
//   try {
//     await Future.forEach(accountIds, (String accountId) async {
//       var doc = await users.doc(accountId).get();
//       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//       Account postAccount = Account(
//         id: accountId,
//         name: data['name'],
//         userId: data['user_id'],
//         imagePath: data['image_path'],
//         selfIntroduction: data['self_introduction'],
//         createdTime: data['created_time'],
//         updatedTime: data['updated_time'],
//       );
//       map[accountId] = postAccount;
//     });
//     print('log ::: UserFirestore.getPostUserMap / success');
//     return map;
//   } on FirebaseException catch(error) {
//     print('log ::: UserFirestore.getPostUserMap / failed');
//     return null;
//   }
// }

// static Future<dynamic> deleteUser(String accountId) async {
//   await users.doc(accountId).delete();
//   PostFirestore.deletePosts(accountId);
// }
}
