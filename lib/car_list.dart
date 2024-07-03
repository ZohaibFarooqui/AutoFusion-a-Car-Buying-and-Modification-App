import 'package:flutter/material.dart';
import 'advanced_search_screen.dart';
import 'car_details.dart';
import 'favourites_screen.dart';
import 'virtual_customization_screen.dart';

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  final List<Map<String, dynamic>> cars = [
    {
      'name': 'civic',
      'type': 'Sedan',
      'price': '40,000',
      'image': 'lib/assets/civic/civicwhite.png',
      'colorOptions': [ 'White','Red', 'Blue' , 'Black' , 'Silver'],
    },
    {
      'name': 'cruiser',
      'type': 'Vintage',
      'price': '50,000',
      'image': 'lib/assets/cruiser/cruiserwhite.png',
      'colorOptions': ['White','Black' , 'Silver', 'Red'],
    },
    {
      'name': 'corolla',
      'type': 'Sedan',
      'price': '80,000',
      'image': 'lib/assets/corolla/corollawhite.png',
      'colorOptions': ['White','Red', 'Black', 'Silver' ],
    },
    {
      'name': 'fortuner',
      'type': 'SUV',
      'price': '65,000',
      'image': 'lib/assets/fortuner/fortunerwhite.png',
      'colorOptions': ['White' ,'Black'],
    },
    // Add more cars here
  ];

  List<String> favorites = [];
  String searchQuery = '';
  bool sortAscending = true;
  bool isDarkMode = false; // Track dark mode state

  @override
  Widget build(BuildContext context) {
    // Set theme based on the current dark mode state
    final ThemeData currentTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();

    // Filter and sort cars based on search and sorting criteria
    List<Map<String, dynamic>> filteredCars = cars.where((car) {
      return car['name']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    filteredCars.sort((a, b) {
      if (sortAscending) {
        return a['name']!.compareTo(b['name']!);
      } else {
        return b['name']!.compareTo(a['name']!);
      }
    });

    return Theme(
      data: currentTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Car List'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final String? result = await showSearch<String>(
                  context: context,
                  delegate: CustomSearchDelegate(cars: cars),
                );
                if (result != null) {
                  setState(() {
                    searchQuery = result;
                  });
                }
              },
            ),
            IconButton(
              icon: Icon(sortAscending ? Icons.arrow_downward : Icons.arrow_upward),
              onPressed: () {
                setState(() {
                  sortAscending = !sortAscending;
                });
              },
            ),
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () async {
                // Open the advanced search screen
                final Map<String, dynamic>? filters = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdvancedSearchScreen(),
                  ),
                );
                if (filters != null) {
                  // Handle advanced search filters
                  // You can customize this part based on your requirements
                  // For example, update the state with the applied filters
                  // and re-fetch the data accordingly
                  print('Applied filters: $filters');
                }
              },
            ),
            // Add the IconButton for FavoritesScreen here
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen(favorites: [])),
                );
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: filteredCars.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetails(car: filteredCars[index] as Map<String, dynamic>),
                  ),
                );



              },
              onLongPress: () {
                // Navigate to the VirtualCustomizationScreen with the selected car data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VirtualCustomizationScreen(
                      cars: filteredCars,
                      selectedCarIndex: index,
                    ),
                  ),
                );
              },

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                        child: Image.asset(
                          filteredCars[index]['image']!,
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              filteredCars[index]['name']!,
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            Text('Type: ${filteredCars[index]['type']!}'),
                            SizedBox(height: 8.0),
                            Text('Price: \$${filteredCars[index]['price']!}'),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: Icon(
                              favorites.contains(filteredCars[index]['name'])
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                if (favorites.contains(filteredCars[index]['name'])) {
                                  favorites.remove(filteredCars[index]['name']);
                                } else {
                                  favorites.add(filteredCars[index]['name']!);
                                }
                              });
                            },
                          ),
                          // Add more action buttons here
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> cars;

  CustomSearchDelegate({required this.cars});

  String selectedType = ''; // Track the selected car type for filtering

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results display
    List<Map<String, String>> searchResults = cars.where((car) {
      return car['name']!.toLowerCase().contains(query.toLowerCase()) &&
          (selectedType.isEmpty || car['type']!.toLowerCase() == selectedType.toLowerCase());
    }).map((car) => car.cast<String, String>()).toList();



    return SearchResultsWidget(searchResults: searchResults);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions based on the query
    List<String> suggestions = cars
        .where((car) => car['name']!.toLowerCase().startsWith(query.toLowerCase()))
        .map((car) => car['name'] as String)
        .toList();


    return SearchSuggestionsWidget(
      suggestions: suggestions,
      onTap: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Add a DropdownButton for car types
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            value: selectedType,
            onChanged: (newValue) {
              // Use the query to track the selected type
              query = newValue!;
              showResults(context);
            },
            items: ['Vintage', 'Sports', 'SUV']
                .map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ),
            )
                .toList(),
            hint: Text('Select Car Type'),
          ),
        ),
      ],
    );
  }
}

class SearchResultsWidget extends StatelessWidget {
  final List<Map<String, String>> searchResults;

  SearchResultsWidget({required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CarDetails(car: searchResults[index]),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                    child: Image.asset(
                      searchResults[index]['image']!,
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          searchResults[index]['name']!,
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text('Type: ${searchResults[index]['type']!}'),
                        SizedBox(height: 8.0),
                        Text('Price: \$${searchResults[index]['price']!}'),
                      ],
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
}

class SearchSuggestionsWidget extends StatelessWidget {
  final List<String> suggestions;
  final Function(String) onTap;

  SearchSuggestionsWidget({required this.suggestions, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            onTap(suggestions[index]);
          },
        );
      },
    );
  }
}
