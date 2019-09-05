import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/contributor.dart';
import 'package:zgadula/ui/templates/screen.dart';

class ContributorsScreen extends StatefulWidget {
  @override
  _ContributorsScreenState createState() => _ContributorsScreenState();
}

class _ContributorsScreenState extends State<ContributorsScreen> {
  @override
  void initState() {
    super.initState();

    ContributorModel.of(context).load();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      child: SafeArea(
        child: Stack(
          children: [
            ScopedModelDescendant<ContributorModel>(
              builder: (context, child, model) {
                return ListView(
                  children: model.contributors.map((contributor) {
                    return ListTile(
                      leading: Icon(Icons.person),
                      title: Text(contributor.name),
                      subtitle: Text(contributor.username),
                    );
                  }).toList(),
                );
              },
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
