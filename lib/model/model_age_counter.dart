class AgeCounter {
  int calculateAge(String dateOfBirth) {
    List<String> parts = dateOfBirth.split(' '); // Split the date string

    if (parts.length == 3) {
      // Check if there are three parts (day, month, year)
      int? day = int.tryParse(parts[0]);
      String month = parts[1];
      int? year = int.tryParse(parts[2]);

      if (day != null && year != null) {
        Map<String, int> monthMap = {
          'January': 1,
          'February': 2,
          'March': 3,
          'April': 4,
          'May': 5,
          'June': 6,
          'July': 7,
          'August': 8,
          'September': 9,
          'October': 10,
          'November': 11,
          'December': 12,
        };

        int? birthMonth = monthMap[month];

        if (birthMonth != null) {
          DateTime currentDate = DateTime.now();
          DateTime birthDate = DateTime(year, birthMonth, day);

          int age = currentDate.year - birthDate.year;

          // Adjust age if the birthday hasn't occurred yet this year
          if (currentDate.month < birthDate.month ||
              (currentDate.month == birthDate.month &&
                  currentDate.day < birthDate.day)) {
            age--;
          }

          return age;
        }
      }
    }

    return 0;
  }
}
