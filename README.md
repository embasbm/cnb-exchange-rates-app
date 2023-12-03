# Development process summary

* Conducted the initial setup of the application.
  - Using Ruby on Rails app, MVC architecture pattern; it will provide both a UI (browser) and REST API (Json format).
    * http://127.0.0.1:3000
    * http://127.0.0.1:3000/sidekiq/scheduled
    * `curl -X 'GET' 'http://127.0.0.1:3000' -H 'accept: application/json'`
* Set up services (Fetcher, Processor) and models (DailyDump, Currency) for better organization.
  - This way we separate concern: serivces to hit CNB api api and fetch data. Models to manage data on database level.
* Configured Sidekiq and Sidekiq-Cron:

  - For both asynchronous and scheduled jobs/workers, they will be triggering the previously mentioned services.
* Fixed fixture tests for the Currency model: unit test
* Added a route URL to the Sidekiq dashboard.
* Added basic pages controller with a home method to display currencies for today. And apply basic styling to improve the visual appearance.
* Switched from chromedriver to headless_chrome for integration testing.
* Moved Currency scaffold to Rails convention, so we can use turbo-rails and action cable subscription from Model to View: made updates in the Currency model broadcast changes via Action Cable to Home page View.
* Ensure Fetcher worker idempotent due to CNB API not providing rates on weekends.

  - Modified worker behavior to avoid hitting CNB API on weekends.

  - Scheduled a job for 6 AM every day, excluding weekends.

# Room for improvements

* Deploy to some suitable platform (e.g. https://fly.io/docs/rails/getting-started/)
* Adapt basic auth to REST API
  - And add some basic API documentation (e.g. swagger)
* Add devise to UI side
