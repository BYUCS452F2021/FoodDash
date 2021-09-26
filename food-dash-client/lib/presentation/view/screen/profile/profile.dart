import 'package:dating_idea/presentation/config/theming/sample.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  //TODO: pass user to profile page
  // final User idea;


  ProfileScreen(/*{@required this.idea}*/);

  @override
  Widget build(BuildContext context) {
    //print(idea.toJson());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            RichText(
                text: TextSpan(
              text: 'User\'s name here?',
              style: CustomTheme.lightTheme.textTheme.headline1,
            )),
            const SizedBox(
              height: 10.0,
            ),
            RichText(
                text: TextSpan(
              text: 'My Ideas',
              style: CustomTheme.lightTheme.textTheme.headline1,
            )),
            const SizedBox(
              height: 10.0,
            ),
            
          ]),
        ),
      ),
    );
  }
}
