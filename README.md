# API Engine

API Engine is an application created by [Cam Chery](https://github.com/ckccameron), as part of the Turing School of Software and Design [backend curriculum](https://backend.turing.io/module3/projects/viewing_party). It was completed over a period of 6 days.

## Table of Contents
1. [About This Project](#about_this_project)
2. [Learning Achievements](#learning_achievements)
3. [Local Setup](#setup)
4. [Schema Design](#schema)
5. [Testing](#testing)
6. [Contributors](#contributors)
7. [Resources](#resources)

## About This Project <a name="about_this_project"></a>

For this project, I had to imagine that I am working for a company developing an E-Commerce Application. The team is working in a service-oriented architecture, therefore the frontend and back end of this application are separate and communicate via APIs. My job is to expose the data that powers the site through an API. As a result, the frontend of the application can consume these API endpoints to call the data they need. I was not permitted to change the frontend repo in any way. Instead, I created JSON responses that included data needed to pass each test within the frontend spec harness.

There are two repos for this project. In addition to this API Engine repo, you can check out the frontend repo, [Rails Driver](https://github.com/ckccameron/rails_driver).

## Learning Achievements <a name="learning_achievements"></a>
- Expose an API 
- Use serializers to format JSON responses 
- Test API exposure 
- Compose advanced ActiveRecord queries to analyze information stored in SQL databases 
- Write basic SQL statements without the assistance of an ORM

## Local Setup <a name="setup"></a>

1. Fork and clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{create,migrate}`
4. Run the rake task to import all data: `rake import`
5. Open a second Terminal window with Rails Driver repo
5. (within Rails Driver) Install gem packages: `bundle install`
6. (within Rails Driver) Install Figaro gem to gain access to your local application.yml file: `bundle exec figaro install`
7. (within Rails Driver) Add your API key to config/application.yml file: must be in format of `RAILS_ENGINE_DOMAIN: http://localhost:3000`
8. Run `rails s` in your API Engine terminal window to fire up your localhost, then run `bundle exec rspec` in your Rails Driver window to view the frontend spec harness coverage.

  ### Versions

  - Ruby 2.5.3
  - Rails 5.2.4.3
  
## Schema Design <a name="schema"></a>

<img width="775" alt="Screen Shot 2020-10-23 at 9 13 37 AM" src="https://user-images.githubusercontent.com/57038617/97027897-3d7a0900-1510-11eb-818c-8e9ba65279bf.png">

## Testing <a name="testing"></a>

I used RSpec with the help of Capybara, Shoulda Matchers, FactoryBot, Faker and SimpleCov.

## Contributors <a name="contributors"></a>

[Cam Chery](https://github.com/ckccameron)

## Resources <a name="resources"></a>

- [Turing Backend Module 3 Lessons](https://backend.turing.io/module3/lessons/)
- [How to Use Scopes in Ruby on Rails (Guide)](https://www.rubyguides.com/2019/10/scopes-in-ruby-on-rails/)
- [Class: Date Ruby docs](https://ruby-doc.org/stdlib-2.7.2/libdoc/date/rdoc/Date.html)
- [How to Write a Custom Rake Task](https://cobwwweb.com/how-to-write-a-custom-rake-task)
- [Customizing Rails rake tasks - DEV](https://dev.to/vinistock/customizing-rails-rake-tasks-3bg5)
