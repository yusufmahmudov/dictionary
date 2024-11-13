import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/presentation/widgets/special_detail_widget.dart';

class SpecialDetailView extends StatefulWidget {
  final String appBarText;

  const SpecialDetailView({super.key, required this.appBarText});

  @override
  State<SpecialDetailView> createState() => _SpecialDetailViewState();
}

class _SpecialDetailViewState extends State<SpecialDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: Text(
          widget.appBarText,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 26,
              color: black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: ListView.separated(
          itemCount: 5,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 12);
          },
          itemBuilder: (BuildContext context, int index) {
            return SpecialDetailWidget(
                branch: "${widget.appBarText} bo'lim nomlari");
          },
        ),
      ),
    );
  }
}
