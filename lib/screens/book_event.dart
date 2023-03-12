import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/event_provider.dart';

class BookEvent extends StatefulWidget {
  const BookEvent({super.key});

  @override
  State<BookEvent> createState() => _BookEventState();
}

TextEditingController eventName = TextEditingController();
TextEditingController eventType = TextEditingController();
TextEditingController eventDate = TextEditingController();
TextEditingController eventDescription = TextEditingController();

class _BookEventState extends State<BookEvent> {
  DateTime? date;
  int _value = 1;
  var imageUrl = 'images/party.jpeg';
  var _isStyling = false;
  var _isVenue = false;
  var _isFood = false;
  var _isEntertainment = false;
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<EventProvider>(context);
    _provider.setEventTypeUsingEventNumber(_value);
    // _provider.setDate(date ?? DateTime.now());
    // List<String> servicesList = [
    //   'Decor and Styling',
    //   'Venue Sourcing',
    //   'Food and Catering',
    //   'Sound',
    // ];
    // Map<String, bool> s = {
    //   'Decor and Styling': false,
    //   'Venue Sourcing': false,
    //   'Food and Catering': false,
    //   'Sound': false,
    // };
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.colorBurn,
          ),
          fit: BoxFit.cover,
          image: AssetImage(
            imageUrl,
          ),
        ),
      ),
      child: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Book An Event',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          ItemBox(controller: eventName, type: 'Event Name', ht: 50),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 10,
            ),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Radio<int>(
                    value: 1,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value!;
                        imageUrl = 'images/party.jpeg';
                      });
                    },
                  ),
                  const Text(
                    'Party',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Radio<int>(
                    value: 2,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value!;
                        imageUrl = 'images/wedding.jpeg';
                      });
                    },
                  ),
                  const Text(
                    'Wedding',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Radio<int>(
                    value: 3,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value!;
                        imageUrl = 'images/business.jpeg';
                      });
                    },
                  ),
                  const Text(
                    'Business',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Radio<int>(
                    hoverColor: Colors.red,
                    activeColor: Colors.red,
                    // overlayColor: Colors.red,
                    value: 4,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value!;
                        imageUrl = 'images/festive.jpeg';
                      });
                    },
                  ),
                  const Text(
                    'Festive',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 10,
            ),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Checkbox(
                    side: BorderSide(color: Colors.red),
                    checkColor: Colors.white,
                    activeColor: Colors.red,
                    value: _isStyling,
                    onChanged: (bool? newBool) {
                      _provider.setdecor(newBool!);
                      log(_isStyling.toString());
                      setState(() {
                        _isStyling = newBool;
                      });
                    },
                  ),
                  const Text(
                    'Decor and Styling(₹ 3,000)',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Checkbox(
                    side: BorderSide(color: Colors.red),
                    checkColor: Colors.white,
                    activeColor: Colors.red,
                    value: _isVenue,
                    onChanged: (bool? newBool) {
                      _provider.setVenueServices(newBool!);
                      setState(() {
                        _isVenue = newBool;
                      });
                    },
                  ),
                  const Text(
                    'Venue Sourcing(₹ 1,000)',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Checkbox(
                    side: BorderSide(color: Colors.red),
                    checkColor: Colors.white,
                    activeColor: Colors.red,
                    value: _isFood,
                    onChanged: (bool? newBool) {
                      _provider.setfood(newBool!);
                      setState(() {
                        _isFood = newBool;
                      });
                    },
                  ),
                  const Text(
                    'Food and Catering(₹ 4,000)',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Checkbox(
                    side: BorderSide(color: Colors.red),
                    checkColor: Colors.white,
                    activeColor: Colors.red,
                    value: _isEntertainment,
                    onChanged: (bool? newBool) {
                      _provider.setentertainment(newBool!);
                      setState(() {
                        _isEntertainment = newBool;
                      });
                    },
                  ),
                  const Text(
                    'Entertainment(₹ 7,500)',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    date == null
                        ? Text(
                            'No Date Chosen',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            DateFormat('dd MMMM, yyyy').format(date!),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    IconButton(
                      onPressed: () async {
                        try {
                          final formattedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2024));

                          if (formattedDate != null) {
                            _provider.setDate(formattedDate);
                            setState(() {
                              date = formattedDate;
                            });
                          }
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ItemBox(
            controller: eventDescription,
            type: 'Event Description',
            ht: 300,
          ),
        ],
      ),
    );
  }
}

class ItemBox extends StatelessWidget {
  final String type;
  final double ht;
  final TextEditingController controller;
  const ItemBox({
    required this.type,
    required this.controller,
    required this.ht,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 20,
      ),
      child: Container(
        height: ht,
        width: MediaQuery.of(context).size.width - 200,
        decoration: BoxDecoration(
          // color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.red),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: TextField(
            controller: controller,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              hintText: type,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
