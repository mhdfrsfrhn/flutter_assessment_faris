import 'package:sd1_flutter_assessment/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  final TextEditingController _controllerSearch = TextEditingController();
  List<String> dropDown = <String>["Name", "Check-in Time"];
  List<ContactData> contactList = [];

  @override
  void initState() {
    retrieveContactData();
    super.initState();
  }

  @override
  void dispose() {
    _controllerSearch.dispose();
    super.dispose();
  }

  void retrieveContactData() async {
    dbRef.orderByChild(choice).onChildAdded.listen((data) {
      ContactData contactData =
          ContactData.fromJson(data.snapshot.value as Map);
      contactList.add(contactData);
      contactKey = contactList.length + 1;
      setState(() {});
    });
  }

  reverseContactList() {
    List<ContactData> reversedList = contactList.reversed.toList();
    contactList = reversedList;
    return contactList;
  }

  runSearch(String query) {
    if (query.isEmpty) {
      contactList.clear();
      retrieveContactData();
    }
    final results = contactList.where((data) {
      final name = data.userName.toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input);
    }).toList();
    setState(() {
      contactList = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (choice != 'user') reverseContactList();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FormAddScreen()),
                  );
                },
                backgroundColor: Colors.blue[300],
                child: const Icon(Icons.person_add),
              ),
            ),
            GestureDetector(
              onDoubleTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("<3"),
                ),
              ),
              // onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text("lol"),
              //   ),
              // ),
              child: const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(
                    'assets/images/animation.gif',
                  )),
            ),
          ],
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Check-in List',
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const OnBoard()));
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
                        controller: _controllerSearch,
                        autofocus: false,
                        decoration: InputDecoration(
                          // fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          hintText: 'Search by name',
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          ),
                        ),
                        onChanged: (value) {
                          runSearch(value);
                        }),
                    Row(
                      children: [
                        Visibility(
                            visible:
                                _controllerSearch.text.isEmpty ? true : false,
                            child: sortButton(context)),
                        const Spacer(),
                        Icon(Icons.person, color: Colors.grey[500]),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "${contactList.length}",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 0),
                  ],
                ),
              ),

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
                              child:
                                  Text("Error loading list or list is empty"));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
