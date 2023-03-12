import 'package:firebaseapp/screens/book_event.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../provider/event_provider.dart';
import 'event_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int index = 1;
PageController _pageController = PageController(initialPage: 1);

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final event = Provider.of<EventProvider>(context);
    final eventList = event.eventsList;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pageController.animateToPage(1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate);
          setState(() {
            index = 1;
          });
          if (eventName.text.isNotEmpty && eventDescription.text.isNotEmpty) {
            showBill(eventName.text, eventDescription.text, context);
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: MediaQuery.of(context).size.width > 700
          ? Row(
              children: [
                Container(
                  color: Colors.red,
                  height: MediaQuery.of(context).size.height,
                  width: 300,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 30,
                        ),
                        child: Text(
                          'EVENT BOOKER',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextButton(
                        onPressed: () {
                          _pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.decelerate,
                          );
                          setState(() {
                            index = 0;
                          });
                        },
                        child: Container(
                          height: 70,
                          width: 330,
                          child: Container(
                            color: index == 0 ? Colors.white : Colors.red,
                            child: Center(
                              child: Text(
                                'My Account',
                                style: TextStyle(
                                  color: index == 0 ? Colors.red : Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      TextButton(
                        onPressed: () {
                          _pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.decelerate,
                          );
                          setState(() {
                            index = 1;
                          });
                        },
                        child: Container(
                          color: index == 1 ? Colors.white : Colors.red,
                          height: 70,
                          width: 330,
                          child: Center(
                            child: Text(
                              'Book An Event',
                              style: TextStyle(
                                color: index == 1 ? Colors.red : Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      TextButton(
                        onPressed: () {
                          _pageController.animateToPage(2,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.decelerate);
                          setState(() {
                            index = 2;
                          });
                        },
                        child: Container(
                          height: 70,
                          width: 330,
                          color: index == 2 ? Colors.white : Colors.red,
                          child: Center(
                            child: Text(
                              'Event History',
                              style: TextStyle(
                                color: index == 2 ? Colors.red : Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: PageView(
                      controller: _pageController,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'This is User Profile Page',
                              ),
                            ],
                          ),
                        ),
                        BookEvent(),
                        EventHistory(),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}

showBill(String eventName, String eventDescription, BuildContext context) {
  final _provider = Provider.of<EventProvider>(context, listen: false);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Total Bill',
        ),
        content: Container(
          height: 500,
          width: 500,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Event Name : $eventName (₹ 10,000)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Particulars',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                _provider.decor['opted']
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Decor and Styling : ₹ ${_provider.decor['price']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                _provider.food['opted']
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Food and Catering : ₹ ${_provider.food['price']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                _provider.venueService['opted']
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Venue Sourcing : ₹ ${_provider.venueService['price']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                _provider.entertainment['opted']
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Entertainment : ₹ ${_provider.entertainment['price']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'GST(18% ) : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      '₹ ${_provider.getTax()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Total Cost : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      '₹ ${_provider.getTax() + _provider.getTotalCost()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    _provider.addEvent(eventName, eventDescription);
                    _provider.setDate(DateTime.now());
                    _provider.setVenueServices(false);
                    _provider.setdecor(false);
                    _provider.setentertainment(false);
                    _provider.setfood(false);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 60,
                    width: 450,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        'Book Event',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
