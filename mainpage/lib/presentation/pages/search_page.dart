import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;
  var textInput = "";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            onChanged: (value) {
              setState(() {
                textInput = value;
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Search",
            ),
          ),
          const SizedBox(height: 8.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                SearchTag(text: "Hotel"),
                SearchTag(text: "Staycation"),
                SearchTag(text: "Airplane"),
                SearchTag(text: "Train"),
                SearchTag(text: "Bus"),
                SearchTag(text: "Trip"),
              ],
            ),
          ),
          Text(textInput),
          Text(
            "Last Search",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const LastSearchText(text: "Farmhouse Susu Lembang"),
          const LastSearchText(text: "The Trans Luxury Hotel"),
          const LastSearchText(text: "Floating Market"),
        ],
      ),
    );
  }
}

class SearchTag extends StatelessWidget {
  const SearchTag({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

class LastSearchText extends StatelessWidget {
  const LastSearchText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 10.0,
          ),
          const SizedBox(width: 4.0),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
