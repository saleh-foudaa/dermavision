import 'package:flutter/material.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  static const String routeName = '/log_out';
  final VoidCallback onLogoutPressed;
  final VoidCallback onCancelPressed;

  const LogoutConfirmationDialog({
    Key? key,
    required this.onLogoutPressed,
    required this.onCancelPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 27.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.exit_to_app,
            size: 56.0,
            color: Color(0xff1A766E),
          ),
          SizedBox(height: 20.0),
          Text(
            'Are you sure to log out of your account?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onLogoutPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A766E),
                padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: Text(
                'Log Out',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onCancelPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey[400]!, width: 1.5),
                padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[800], fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
