import 'package:ambee/utils/helper/string_extensions.dart';

class WeatherData {
  double? lat;
  double? lon;
  Current? current;
  List<Hourly>? hourly;
  List<Daily>? daily;

  WeatherData({this.lat, this.lon, this.current, this.hourly, this.daily});

  WeatherData.fromJson(Map<String, dynamic> json) {
    lat = json['lat']?.toString().toDouble;
    lon = json['lon']?.toString().toDouble;
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
    if (json['hourly'] != null) {
      hourly = <Hourly>[];
      json['hourly'].forEach((v) {
        hourly!.add(Hourly.fromJson(v));
      });
    }
    if (json['daily'] != null) {
      daily = <Daily>[];
      json['daily'].forEach((v) {
        daily!.add(Daily.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    if (current != null) {
      data['current'] = current!.toJson();
    }
    if (hourly != null) {
      data['hourly'] = hourly!.map((v) => v.toJson()).toList();
    }
    if (daily != null) {
      data['daily'] = daily!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Current {
  int? dt;
  double? temp;
  int? humidity;
  double? windSpeed;
  List<Weather>? weather;
  double? uvi;

  Current(
      {this.dt,
      this.temp,
      this.humidity,
      this.windSpeed,
      this.weather,
      this.uvi});

  Current.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'].toString().toDouble;
    humidity = json['humidity'];
    uvi = json['uvi']?.toString().toDouble;
    windSpeed = json['wind_speed']?.toString().toDouble;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['temp'] = temp;
    data['humidity'] = humidity;
    data['uvi'] = uvi;
    data['wind_speed'] = windSpeed;
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class Hourly {
  int? dt;
  double? temp;
  double? pop;
  int? humidity;
  double? windSpeed;
  List<Weather>? weather;

  Hourly({
    this.dt,
    this.temp,
    this.humidity,
    this.windSpeed,
    this.weather,
    this.pop,
  });

  Hourly.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'].toString().toDouble;
    humidity = json['humidity'];
    pop = json['pop']?.toString().toDouble;
    windSpeed = json['wind_speed']?.toString().toDouble;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['temp'] = temp;
    data['humidity'] = humidity;
    data['pop'] = pop;
    data['wind_speed'] = windSpeed;
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Daily {
  int? dt;
  Temp? temp;
  int? humidity;
  double? windSpeed;
  List<Weather>? weather;
  double? pop;

  Daily({
    this.dt,
    this.temp,
    this.humidity,
    this.windSpeed,
    this.weather,
    this.pop,
  });

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'] != null ? Temp.fromJson(json['temp']) : null;
    humidity = json['humidity'];
    windSpeed = json['wind_speed']?.toString().toDouble;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    pop = json['pop']?.toString().toDouble;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    if (temp != null) {
      data['temp'] = temp!.toJson();
    }
    data['humidity'] = humidity;
    data['wind_speed'] = windSpeed;
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Temp {
  double? min;
  double? max;

  Temp({
    this.min,
    this.max,
  });

  Temp.fromJson(Map<String, dynamic> json) {
    min = json['min']?.toString().toDouble;
    max = json['max']?.toString().toDouble;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min'] = min;
    data['max'] = max;
    return data;
  }
}
