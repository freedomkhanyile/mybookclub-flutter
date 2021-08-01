class OurTimeLeft {
  List<String> timeLeft(DateTime bookDue) {
    List<String> retVal = List.filled(2, "", growable: false);

    Duration _timeUntilDue = bookDue.difference(DateTime.now());

    // days
    // returns the days left until book due date.
    int _daysUntil = _timeUntilDue.inDays;

    // subtract the hours until book is due in days remaining on hour format of 24hr i.e. 2 days = 48hrs.
    int _hoursUntil = _timeUntilDue.inHours - (_daysUntil * 24);

    // subtract the hours until book is due in days remaining on hourly minute format.
    int _minUntil =
        _timeUntilDue.inMinutes - (_daysUntil * 24 * 60) - (_hoursUntil * 60);

    // subtract the seconds until book is due in days remaining on hourly minute seconds format.
    int _secondsUntil = _timeUntilDue.inSeconds -
        (_daysUntil * 24 * 60 * 60) -
        (_hoursUntil * 60 * 60) -
        (_minUntil * 60);

    if (_daysUntil > 0) {
      retVal[0] = _daysUntil.toString() +
          " days\n" +
          _hoursUntil.toString() +
          " hours\n" +
          _minUntil.toString() +
          " mins\n" +
          _secondsUntil.toString() +
          "secs";
    } else if (_hoursUntil > 0) {
      retVal[0] = _hoursUntil.toString() +
          " hours\n" +
          _minUntil.toString() +
          " mins\n" +
          _secondsUntil.toString() +
          "secs";
    } else if (_minUntil > 0) {
      retVal[0] =
          _minUntil.toString() + " mins\n" + _secondsUntil.toString() + "secs";
    } else if (_secondsUntil > 0) {
      retVal[0] = _secondsUntil.toString() + "secs";
    } else {
      retVal[0] = "error";
    }

    Duration _timeUntilReveal = bookDue.subtract(Duration(days: 7)).difference(
        DateTime
            .now()); // the next book reveal must be a week before the book due date.

    int _daysUntilReveal = _timeUntilReveal.inDays;

    int _hoursUntilReveal = _timeUntilReveal.inHours - (_daysUntilReveal * 24);

    int _minUntilReveal = _timeUntilReveal.inMinutes -
        (_daysUntilReveal * 24 * 60) -
        (_hoursUntil * 60);

    int _secondsUntilReveal = _timeUntilReveal.inSeconds -
        (_daysUntilReveal * 24 * 60 * 60) -
        (_hoursUntilReveal * 60 * 60) -
        (_minUntilReveal * 60);

    if (_daysUntilReveal > 0) {
      retVal[1] = _daysUntilReveal.toString() +
          " days\n" +
          _hoursUntilReveal.toString() +
          " hours\n" +
          _minUntilReveal.toString() +
          " mins\n" +
          _secondsUntilReveal.toString() +
          "secs";
    } else if (_hoursUntilReveal > 0) {
      retVal[1] = _hoursUntilReveal.toString() +
          " hours\n" +
          _minUntilReveal.toString() +
          " mins\n" +
          _secondsUntilReveal.toString() +
          "secs";
    } else if (_minUntilReveal > 0) {
      retVal[1] = _secondsUntilReveal.toString() +
          " mins\n" +
          _secondsUntilReveal.toString() +
          "secs";
    } else if (_secondsUntilReveal > 0) {
      retVal[1] = _secondsUntilReveal.toString() + "secs";
    } else {
      retVal[1] = "error";
    }
    return retVal;
  }
}
