import 'package:sd1_flutter_assessment/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _contact = [];

  // List<Sort> _sort = [];
  List<String> dropDown = <String>["Name", "Check-in Time"];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/contacts_dataset.json');
    final data = ContactFromJson(response);
    setState(() {
      _contact = data;
    });
    // print('printing ${_contact[0].userName}');
  }

  // Future<String> getJson() {
  //   return rootBundle.loadString('assets/contacts_dataset.json');
  // }

  // Future loadDataset() async {
  //   getJson().then((value) {
  //     final contact = ContactFromJson(value);
  //     print('${contact[1].checkInTime}');
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // Call the readJson method when the app starts
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.blue[300],
        child: const Icon(Icons.person_add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Vimigo',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 25, left: 25),
        child: Column(
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text("Search bar here"),
                    Spacer(),
                    TextButton(
                      child: Icon(Icons.sort, color: Colors.black),
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                // leading: new Icon(Icons.photo),
                                title: new Text('Sort By: '),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: new Icon(Icons.photo),
                                title: new Text('Name'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: new Icon(Icons.music_note),
                                title: new Text('Check-in time'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    // TextButton(
                    //   onPressed: () {
                    //     showModalBottomSheet(
                    //         context: context,
                    //         builder: (context) {
                    //           return Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: <Widget>[
                    //               ListTile(
                    //                 // leading: new Icon(Icons.photo),
                    //                 title: new Text('Sort By: '),
                    //                 onTap: () {
                    //                   Navigator.pop(context);
                    //                 },
                    //               ),
                    //               ListTile(
                    //                 leading: new Icon(Icons.photo),
                    //                 title: new Text('Name'),
                    //                 onTap: () {
                    //                   Navigator.pop(context);
                    //                 },
                    //               ),
                    //               ListTile(
                    //                 leading: new Icon(Icons.music_note),
                    //                 title: new Text('Check-in time'),
                    //                 onTap: () {
                    //                   Navigator.pop(context);
                    //                 },
                    //               ),
                    //             ],
                    //           );
                    //         });
                    //   },
                    //   child: Icon(Icons.sort, color: Colors.black),
                    // ),

                    // DropdownButton<String>(
                    //
                    //     underline: Container(),
                    //     icon: const Icon(Icons.sort, color: Colors.black),
                    //     items: dropDown
                    //         .map<DropdownMenuItem<String>>((String value) {
                    //       return DropdownMenuItem<String>(
                    //
                    //         value: value,
                    //         child: Text(value),
                    //       );
                    //     }).toList(),
                    //     onChanged: (String? value) {
                    //       setState(() {});
                    //     }),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.grey[500]),
                    Text(
                      "10",
                      style: TextStyle(color: Colors.grey[500]),
                    )
                  ],
                ),
              ],
            ),

            // Display the data loaded from sample.json
            _contact.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _contact.length,
                      itemBuilder: (context, index) {
                        return Card(
                          key: ValueKey(index),
                          margin: const EdgeInsets.all(10),
                          color: Colors.amber.shade100,
                          child: ListTile(
                              leading: Text('${index + 1}'),
                              title: Text(_contact[index].userName),
                              // subtitle: Text('Check-in time: ${_contact[index].checkInTime}'),
                              subtitle: Text(_contact[index].checkInTime)),
                        );
                      },
                    ),
                  )
                : Container(
                    child: const Center(
                        child: Text("Error loading list or list is empty")),
                  )
          ],
        ),
      ),
      // body: Center(
      //   child: SingleChildScrollView(
      //     child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: <Widget>[
      //           const DefaultTextStyle(
      //               style: TextStyle(fontSize: 36, color: Colors.blue),
      //               child: Text("Home")),
      //           TextButton(
      //             onPressed: () {
      //               print("button pressed");
      //               Navigator.pushReplacement(context,
      //                   MaterialPageRoute(builder: (context) => OnBoard()));
      //             },
      //             child: Text('Show Onboarding page again'),
      //           ),
      //         ]),
      //   ),
      // ),
    );
  }
}
