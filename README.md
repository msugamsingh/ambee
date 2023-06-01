# Ambee Weather App

The Weather App is a small application that provides users with up-to-date weather information for their desired locations. With a user-friendly interface, it allows users to search for a location and view current weather conditions, as well as a 7-day forecast.


## **Features**
- ## Current Weather ☁️
Shows the current weather according to the device location.


- ## Dynamic Theme 🌙
The app has dark mode support for a better user experience.


- ## 3D Weather Icons 🤩
Utilizes 3D icons to enhance the app's UI.
*Please note that using 3D icons increases the app's size (currently 45mb of assets) due to the inclusion of high-quality weather icons.*


- ## Dynamic Links 🔗
Users can use dynamic links to open specific locations. Use the following format for the link:
https://aeweather.page.link/?link=https%3A%2F%2Fwww.getambee.com%3Flat%3D{{lat_of_desired_city}}%26lon%3D{{lon_of_desired_city}}&apn=com.ambee.ambee&afl=https://www.getambee.com&efr=1

Dynamic link for `Bangluru`
https://aeweather.page.link/?link=https%3A%2F%2Fwww.getambee.com%3Flat%3D12.97%26lon%3D77.59&apn=com.ambee.ambee&afl=https://www.getambee.com&efr=1

Dynamic link for `Delhi`
https://aeweather.page.link/?link=https%3A%2F%2Fwww.getambee.com%3Flat%3D28.7%26lon%3D77.10&apn=com.ambee.ambee&afl=https://www.getambee.com&efr=1

Adjust the latitude (**lat**) and longitude (**lon**) values in the link to the desired location's coordinates.


- ## Push Notifications 🔔
Users receive daily notifications from the app at 12 PM and 4 PM.

## **Other Features**
- **Auto Complete Places:** Provides auto-complete suggestions when searching for a location.

- **Silent Data Updates:** The app silently updates weather data every 10 minutes.

- **Smooth Animations:** Features smooth and visually appealing animations.


## Future Improvements
- **Firebase Remote Config Support:** Implement support for Flutter Remote Config to securely store and retrieve important keys from Firebase, ensuring better management and security.

- **Icon Resizing:** Optimize the app size by resizing and compressing the included weather icons to reduce the overall size without compromising the UI quality.

- **Screen_util:** Utilize the Screen_util package to achieve extraordinary responsiveness across various screen sizes and devices, improving the app's user experience.

- **Flutter Flavors:** Implement Flutter Flavors to support different environments (e.g., development, staging, production) and easily manage configurations for each environment.
 
- **Crashlytics:**  Integrate Crashlytics for better crash reporting and monitoring, enabling developers to identify and fix issues more efficiently.

- **Firebase Analytics:**  Incorporate analytics tools (e.g., Firebase Analytics) to gain insights into user behavior, track app usage, and make data-driven decisions for further app enhancements.

## Installation

1. Go to the [release page](https://github.com/msugamsingh/ambee/releases).
2. Download the appropriate APK file for your device. If you are unsure, choose the FAT APK.
3. Install the downloaded APK on your device.


## Usage

1. Open the Weather App on your device.
2. Allow location access when prompted, or manually enter a location in the search bar.
3. The app will display the current weather conditions and the 7-day forecast for the searched location.
4. Toggle between dark and light mode by accessing the app's settings.
5. Enjoy the dynamic weather icons and smooth animations.
6. Receive daily push notifications at 12 PM and 4 PM.
7. Customize your experience by exploring the various features and options available in the app.
