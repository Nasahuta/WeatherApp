# WeatherApp

Simple weather application that uses https://openweathermap.org/ api.

User can use gps to get current weather data or type in a city name. Application also provides 5 day forecast.

The project set out to accomplish:

- Three tabs: 
    - 1) current weather
      - Has city name, some weather information, temperature and icon (image) displaying current weather.
    - 2) weather forecast for 5 days
      - Has a table view containing 5 day forecast. Each table cell has information for the day and features also a icon.
    - 3) chosen city
      - Holds a list of cities in table view. User can add and remove cities. First “city” is “Use GPS”.
- Connection to weather map api 
- UI State
- Weather information is stored in cache (Not Implemented)
- Display some activity indicator if it takes time to fetch stuff from the backend. (Not Implemented)
- Polished UI and app icon
