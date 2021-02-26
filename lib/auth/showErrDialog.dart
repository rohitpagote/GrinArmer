import 'package:distributer_application/base/color_properties.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// a simple dialog to be visible everytime some error occurs
showErrDialog(BuildContext context, String msg) {
  // to hide the keyboard, if it is still p
  FocusScope.of(context).requestFocus(new FocusNode());
  // return showDialog(
  //   context: context,
  //   child: AlertDialog(
  //     title: Text("Error"),
  //     content: Text(err),
  //     actions: <Widget>[
  //       OutlineButton(
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         child: Text("Ok"),
  //       ),
  //     ],
  //   ),
  // );
  return Alert(
    context: context,
    style: AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.center,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        // side: BorderSide(
        //   color: mainColor,
        // ),
      ),
      titleStyle: TextStyle(
        color: Colors.red,
      ),
      alertAlignment: Alignment.center,
    ),
    type: AlertType.error,
    title: "ERROR",
    content: Text(msg,
        style: TextStyle(
          fontSize: 14.0,
        )),
    // desc: err,
    buttons: [
      DialogButton(
        // border: Border.all(width: 1.0),
        color: Colors.transparent,
        child: Text(
          "OK",
          style: TextStyle(color: mainColor, fontSize: 16),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

// a simple sialog to be visible everytime some error occurs
showSuccessDialog(BuildContext context, String msg) {
  // to hide the keyboard, if it is still p
  FocusScope.of(context).requestFocus(new FocusNode());
  return Alert(
    context: context,
    style: AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.center,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        // side: BorderSide(
        //   color: mainColor,
        // ),
      ),
      titleStyle: TextStyle(
        color: appColor,
      ),
      alertAlignment: Alignment.center,
    ),
    type: AlertType.success,
    title: "SUCCESS",
    content: Center(
      child: Text(msg,
          style: TextStyle(
            fontSize: 14.0,
          )),
    ),
    // desc: err,
    buttons: [
      DialogButton(
        // border: Border.all(width: 1.0),
        color: Colors.transparent,
        child: Text(
          "OK",
          style: TextStyle(color: mainColor, fontSize: 16),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

// confirmation of product removal from cart
showErrConfirmDialog(BuildContext context, String msg) {
  // to hide the keyboard, if it is still p
  FocusScope.of(context).requestFocus(new FocusNode());
  return Alert(
    context: context,
    type: AlertType.error,
    title: "ERROR",
    content: Align(
      alignment: Alignment.center,
      child: Text(
        msg,
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
    ),
    style: AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.center,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      titleStyle: TextStyle(
        color: Colors.red,
      ),
      alertAlignment: Alignment.center,
    ),
    buttons: [
      DialogButton(
        border: Border.all(width: 1.0),
        color: Colors.transparent,
        child: Text(
          "YES",
          style: TextStyle(color: mainColor, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
      DialogButton(
        border: Border.all(width: 1.0, color: Colors.red),
        color: Colors.red,
        child: Text(
          "NO",
          style: TextStyle(color: white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
      // DialogButton(
      //   child: Text(
      //     "FLAT",
      //     style: TextStyle(color: Colors.white, fontSize: 20),
      //   ),
      //   onPressed: () => Navigator.pop(context),
      //   color: Colors.red,
      // ),
      // DialogButton(
      //   child: Text(
      //     "GRADIENT",
      //     style: TextStyle(color: Colors.white, fontSize: 20),
      //   ),
      //   onPressed: () => Navigator.pop(context),
      //   gradient: LinearGradient(colors: [
      //     Color.fromRGBO(116, 116, 191, 1.0),
      //     Color.fromRGBO(52, 138, 199, 1.0)
      //   ]),
      // )
    ],
  ).show();
  return Alert(
    context: context,
    style: AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.center,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        // side: BorderSide(
        //   color: mainColor,
        // ),
      ),
      titleStyle: TextStyle(
        color: Colors.red,
      ),
      alertAlignment: Alignment.center,
    ),
    type: AlertType.error,
    title: "ERROR",
    content: Text(msg,
        style: TextStyle(
          fontSize: 16.0,
        )),
    // desc: err,
    buttons: [
      DialogButton(
        border: Border.all(width: 1.0),
        color: Colors.transparent,
        child: Text(
          "OK",
          style: TextStyle(color: mainColor, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

// a simple dialog to be visible everytime when user status is not 1
showInfoDialog(BuildContext context, String msg) {
  // to hide the keyboard, if it is still p
  FocusScope.of(context).requestFocus(new FocusNode());
  return Alert(
    context: context,
    style: AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.center,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        // side: BorderSide(
        //   color: mainColor,
        // ),
      ),
      titleStyle: TextStyle(
        color: Colors.blue,
      ),
      alertAlignment: Alignment.center,
    ),
    type: AlertType.info,
    title: "OOPS!",
    content: Center(
      child: Text(msg,
          style: TextStyle(
            fontSize: 14.0,
          )),
    ),
    // desc: err,
    buttons: [
      DialogButton(
        // border: Border.all(width: 1.0),
        color: Colors.transparent,
        child: Text(
          "OK",
          style: TextStyle(color: mainColor, fontSize: 16),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}
