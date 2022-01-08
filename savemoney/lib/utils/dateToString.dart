
import 'package:intl/intl.dart';

String dateToString(DateTime date, String? format){
  DateFormat _format = new DateFormat(format == null ? 'dd-MM-yyyy' : format);
  String dateFormated = _format.format(date);
  
  return dateFormated;
}