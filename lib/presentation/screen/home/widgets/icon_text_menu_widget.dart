import 'package:flutter/material.dart';

import '../../../../external/ui_helpers.dart';

class IconTextMenuWidget extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final String title;

  const IconTextMenuWidget(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.7),
                child: Icon(
                  icon,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
            ),
            UIHelper.verticalSpaceVerySmall,
            SizedBox(
              width: 80,
              child: Text(
                title,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
