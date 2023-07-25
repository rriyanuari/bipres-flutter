import 'package:intl/intl.dart';

class extensionFunction {
  _formattingDate(date) {
// Parse the original date string to a DateTime object
    DateTime newDate = DateFormat("yyyy-MM-dd").parse(date);

// Format the DateTime object to the desired format "dd-MMM-yyyy"
    return DateFormat("dd-MMM-yyyy").format(newDate);
  }
}
