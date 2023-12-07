// ignore_for_file: non_constant_identifier_names

class NutritionalNeed {
  String nutrition_need(int age, String gender) {
    if (age <= 3) {
      return "iwUGa1jnc3XfhPXE1JRk";
    } else if (age <= 6) {
      return "H8Zjyf5spMNxzpBfM1zA";
    } else if (age <= 9) {
      return "3mUfhX4FjJZR5VazmInu";
    } else if (age <= 12) {
      if (gender == "Laki Laki") {
        return "snK1GT5IzeNYR17GDZF5";
      } else if (gender == "Perempuan") {
        return "lzyukZbjnkiUcYqoqEYW";
      } else {
        return "";
      }
    } else if (age <= 15) {
      if (gender == "Laki Laki") {
        return "MahX7itdNxJznoFBmtgS";
      } else if (gender == "Perempuan") {
        return "jdjN0q1jGrqhWSHOK2Si";
      } else {
        return "";
      }
    } else if (age <= 18) {
      if (gender == "Laki Laki") {
        return "b39R7hnOJMmEKLn9ZKCa";
      } else if (gender == "Perempuan") {
        return "dTRzGRIMExfu0ASJ1o1M";
      } else {
        return "";
      }
    } else if (age <= 29) {
      if (gender == "Laki Laki") {
        return "hblsOt5PCgdzdZUTNjuM";
      } else if (gender == "Perempuan") {
        return "iUDU4eIhotFmmYuGmntA";
      } else {
        return "";
      }
    } else if (age <= 49) {
      return "MPvzjTpUb7w3QQfS0Px8";
    } else if (age <= 64) {
      return "pW72wplF8z7UQ8OXnHfE";
    } else if (age <= 80) {
      return "erSfYkq9L8juZLhcjoh7";
    } else if (age > 80) {
      return "529NEAvdBNzQtgCIBVSU";
    } else {
      return "lzyukZbjnkiUcYqoqEYW";
    }
  }
}
