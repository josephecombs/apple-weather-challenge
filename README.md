# README

## Installation

To install the necessary gems, you will need to run the following command in your terminal:

```
bundle install
```

This command will install all the gems specified in the Gemfile.

## Running Tests

This application uses RSpec for testing. To run the tests, use the following command:

```
bundle exec rspec
```

This command will run all the tests located in the `spec` directory.

## Using the Site

The application is a weather forecast service. It allows you to input an address or zip code and get the current weather and extended forecast for that location.

To start the server, run the following command:

```
rails server
```

Then, open your web browser and navigate to `http://localhost:3000`. You will see a form where you can input an address or zip code. After submitting the form, you will be redirected to a page displaying the weather data for the specified location.

Please note that the weather data is cached for 30 minutes, so if you request the weather for the same location within that time frame, you will see the same data. After 30 minutes, the cache is cleared and new data will be fetched from the API.

For more details on how to use the application, refer to the codebase and comments within.
