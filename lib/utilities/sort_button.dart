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
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Center(child: Text('Sort By ')),
                // onTap: () {
                //   Navigator.pop(context);
                // },
              ),
              Divider(
                color: Colors.black12,
                thickness: 3,
              ),
              ListTile(
                // leading: Icon(Icons.photo),
                title: Text('Name'),
                onTap: () {
                  choice = 'user';
                  print(choice);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    // this mainpage is your page to refresh
                    (Route<dynamic> route) => false,
                  );
                },
              ),
              Divider(color: Colors.black12),
              ListTile(
                dense: false,
                title: Text('Check-in time'),
                onTap: () {
                  choice = 'check-in';
                  print(choice);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    // this mainpage is your page to refresh
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
