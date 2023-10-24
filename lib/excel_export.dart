import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

Future<void> createExcel() async {
  // Create a new Excel Document.
  final Workbook workbook = Workbook();
  // Accessing worksheet via index.
  final Worksheet sheet = workbook.worksheets[0];

  // Set the header values
  // User data
  sheet.getRangeByIndex(1, 1).setText('UID');
  sheet.getRangeByIndex(1, 2).setText('First name');
  sheet.getRangeByIndex(1, 3).setText('Last Name');
  sheet.getRangeByIndex(1, 4).setText('User Created On');

  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference testCollectionRef = db.collection('test');
  QuerySnapshot testQuerySnapshot = await testCollectionRef.get();

  int row = 2;
  for (QueryDocumentSnapshot testDocSnap in testQuerySnapshot.docs) {
    //LinkedHashMap<String, dynamic>
    //GameResult currentGameResults = GameResult.fromMap(json.decode(testDocSnap.data() as String));
    //print(currentGameResults.levelResultList[0]);
  }

  // Save and dispose the document.
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  // // Download the output file in web.
  // AnchorElement(
  //     href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
  //   ..setAttribute("download", "output.xlsx")
  //   ..click();
}
