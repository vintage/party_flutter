import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/contributor.dart';
import 'package:zgadula/ui/templates/back_template.dart';

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

  Widget buildContent(context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: ScopedModelDescendant<ContributorModel>(
        builder: (context, child, model) {
          return Column(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackTemplate(
      child: buildContent(context),
    );
  }
}
