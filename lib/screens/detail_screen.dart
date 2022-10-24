import 'package:sd1_flutter_assessment/imports.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.contactList}) : super(key: key);
  final ContactData contactList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contactList.userName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(contactList.checkInTime),
      ),
    );
  }
}