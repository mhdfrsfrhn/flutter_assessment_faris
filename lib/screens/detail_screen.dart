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
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
                    width: 140.0,
                    height: 140.0,
                    child: CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        child: const Icon(
                          Icons.person,
                          size: 50.0,
                        ))),
              ),
              Tooltip(
                waitDuration: const Duration(seconds: 1),
                showDuration: const Duration(seconds: 2),
                message: "Name",
                child: InkWell(
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.teal,
                      ),
                      title: Text(
                        contactList.userName,
                        style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 20,
                            color: Colors.teal.shade900),
                      ),
                    ),
                  ),
                ),
              ),
              Tooltip(
                waitDuration: const Duration(seconds: 1),
                showDuration: const Duration(seconds: 2),
                message: "Phone Number",
                child: InkWell(
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.phone,
                        color: Colors.teal,
                      ),
                      title: Text(
                        contactList.phoneNumber,
                        style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 20,
                            color: Colors.teal.shade900),
                      ),
                    ),
                  ),
                ),
              ),
              Tooltip(
                waitDuration: const Duration(seconds: 1),
                showDuration: const Duration(seconds: 2),
                message: "Check-in time",
                child: InkWell(
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.access_time,
                        color: Colors.teal,
                      ),
                      title: Text(
                        contactList.checkInTime,
                        style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 20,
                            color: Colors.teal.shade900),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
