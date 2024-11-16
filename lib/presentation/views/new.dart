import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ModalDialogExample(),
    );
  }
}

class ModalDialogExample extends StatelessWidget {
  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.topRight,
          child: Material(
            // Wrapping with Material for Material Design context
            color: Colors.transparent, // Keep the background transparent
            child: Container(
              margin: EdgeInsets.only(top: 80, right: 10),
              width: 250,
              decoration: BoxDecoration(
                color: Colors.green[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.add, color: Colors.white),
                    title: Text('Yangi varaq',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.visibility_off, color: Colors.white),
                    title: Text('Yangi Inkognito varaq',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.close, color: Colors.white),
                    title: Text('Barcha varaqni yopish',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.white),
                    title: Text('Sozlamalar',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Dialog Example'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showCustomDialog(context),
          ),
        ],
      ),
      body: Center(
        child: Text('Custom menyu ochish uchun 3 nuqta ikonkasini bosing'),
      ),
    );
  }
}
