import 'package:flutter/material.dart';

class VirtualCustomizationScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cars; // List of cars with color options
  final int selectedCarIndex; // Index of the selected car

  VirtualCustomizationScreen({required this.cars, required this.selectedCarIndex});

  @override
  _VirtualCustomizationScreenState createState() => _VirtualCustomizationScreenState();
}

class _VirtualCustomizationScreenState extends State<VirtualCustomizationScreen> {
  int selectedColorIndex = 0;
  late ScrollController _scrollController; // Add ScrollController

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0.0); // Initialize ScrollController
  }

  String get carModel_ =>
      widget.cars[widget.selectedCarIndex]['name'].toString().toLowerCase();

  List<String>? get colorOptions =>
      (widget.cars[widget.selectedCarIndex]['colorOptions'] as List<dynamic>?)
          ?.cast<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual Customization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          controller: _scrollController, // Set the controller
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Car Color:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              _buildColorPicker(),
              SizedBox(height: 16.0),
              _buildPreviewSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorPicker() {
    if (colorOptions == null || colorOptions!.isEmpty) {
      return Text('No color options available.');
    }

    return DropdownButton<int>(
      value: selectedColorIndex,
      onChanged: (newValue) {
        setState(() {
          selectedColorIndex = newValue!;
        });
      },
      items: List.generate(colorOptions!.length, (index) {
        return DropdownMenuItem<int>(
          value: index,
          child: Text(colorOptions![index]),
        );
      }),
    );
  }

  Widget _buildPreviewSection() {
    if (colorOptions == null || colorOptions!.isEmpty) {
      return Text('No color options available.');
    }

    String carModel = widget.cars[widget.selectedCarIndex]['name'].toString().toLowerCase();
    String selectedColor = colorOptions![selectedColorIndex].toLowerCase();
    String imagePath = 'lib/assets/$carModel/$carModel_$selectedColor.png';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preview:',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Container(
          width: 200.0,
          height: 100.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ],
    );
  }

}
