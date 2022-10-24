import 'package:sd1_flutter_assessment/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  List<String> dropDown = <String>["Name", "Check-in Time"];
  List<ContactData> contactList = [];

  @override
  void initState() {
    super.initState();

    retrieveContactData();
  }

  void retrieveContactData() async {
    dbRef.orderByChild(choice).onChildAdded.listen((data) {
      ContactData contactData =
          ContactData.fromJson(data.snapshot.value as Map);
      contactList.add(contactData);
      contactKey = contactList.length + 1;
      print(contactKey);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FormAddScreen()),
            );
          },
          backgroundColor: Colors.blue[300],
          child: const Icon(Icons.person_add),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Check-in Check-er',
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => OnBoard()));
                  },
                  child: const Icon(
                    Icons.help_outline,
                    size: 26.0,
                  ),
                )),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 25, left: 25),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          // fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          hintText: 'Search',
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(15),
                            child: const Icon(Icons.search),
                            width: 18,
                          )),
                    ),
                    Row(
                      children: [
                        sortButton(context),
                        const Spacer(),
                        Icon(Icons.person, color: Colors.grey[500]),
                        Text(
                          "${contactList.length}",
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    const Divider(height: 0),
                  ],
                ),
              ),

              // Display the data loaded from sample.json
              FutureBuilder(
                  future: dbRef.once(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return contactList.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: contactList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      contactList:
                                                          contactList[index])));
                                    },
                                    child: Card(
                                      key: ValueKey(index),
                                      margin: const EdgeInsets.all(10),
                                      color: Colors.amber.shade100,
                                      child: ListTile(
                                        leading: Text('${index + 1}'),
                                        title:
                                            Text(contactList[index].userName),
                                        subtitle: Text(
                                            contactList[index].checkInTime),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Center(
                              child: Text(
                                  "Error loading list or list is empty"));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
