import 'package:sd1_flutter_assessment/imports.dart';

Widget sortButton(BuildContext context) {
  return TextButton(
    child: Row(
      children: [
        Icon(Icons.sort, color: Colors.grey[500]),
        Text(
          " Sort by: ${choice == 'user' ? "Name" : "Check-in TIme"}",
          style: TextStyle(color: Colors.grey[500]),
        ),
      ],
    ),
    onPressed: () => showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                title: Center(child: Text('Sort By ')),
              ),
              const Divider(
                color: Colors.black12,
                thickness: 3,
              ),
              ListTile(
                title: const Text('Name'),
                onTap: () {
                  choice = 'user';
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
              const Divider(color: Colors.black12),
              ListTile(
                dense: false,
                title: const Text('Check-in time'),
                onTap: () {
                  choice = 'check-in';
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
