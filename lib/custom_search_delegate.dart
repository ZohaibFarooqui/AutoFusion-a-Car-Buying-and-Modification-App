import 'package:flutter/material.dart';
import 'car_details.dart';  // Assuming you have a 'CarDetails' screen

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, String>> cars;

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
    }).toList();

    return SearchResultsWidget(searchResults: searchResults);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions based on the query
    List<String> suggestions = cars
        .where((car) => car['name']!.toLowerCase().startsWith(query.toLowerCase()))
        .map((car) => car['name']!)
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
    // Set theme based on the current dark mode state
    final ThemeData currentTheme = Theme.of(context);

    return Theme(
      data: currentTheme,
      child: Column(
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
      ),
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
