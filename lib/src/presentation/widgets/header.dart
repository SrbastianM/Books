import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});
  final titleStyleText = const TextStyle(
    color: Colors.white,
    fontSize: 40.0,
    fontWeight: FontWeight.bold,
  );
  final subTitleStyleText = const TextStyle(
    color: Colors.white,
    fontSize: 17.0,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(25.0),
      height: 170.0,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 41, 40, 30)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Bookis", style: titleStyleText),
            Text("Found What You Want", style: subTitleStyleText)
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.1),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: IconButton(
                icon: const Icon(Icons.search),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.1),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
          ],
        )
      ]),
    );
  }
}
