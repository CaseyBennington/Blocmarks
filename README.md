[![See demo.](shmarks.png)](https://quiet-plains-42389.herokuapp.com/)

# Shmarks

Shmarks is a social bookmarking app that allows users to email, manage and share bookmarked URLs. Using the mailgun API, users can send an email to a specific address to have a data be created and categorized.

The app is deployed on Heroku: https://quiet-plains-42389.herokuapp.com/

The source code is here on GitHub: https://github.com/CaseyBennington/Shmarks

# Features

+ Users can create a standard account in order to create, edit, and collaborate on public topics which have a list of bookmarks. Anyone can add a bookmark to a particular topic.


+ To use Shmarks functionality, you simply need to send an email to quiet-plains-42389@app6f89ab31539e4054aa5ae3b68089cd19.mailgun.org.
  + Important Details are as follows:
    + **Your email**: Shmarks will search for your email it its database. If you are not yet a user, Blocmarks will create an account with your email with the default password Blocmarks2016 (remember to change it when you log in!)
    + **Email Subject**: Shmarks will search its database for a topic with the same name. If no such topic exists, it will create a new topic with whatever you typed into the subject.
    + **Email Body**: Shmarks will create a new bookmark with the data within. Please ensure that you use proper urls, or Blocmarks will just place a string under the topic, and no image will be generated.
+ Users can like bookmarks, with a list of their created and liked bookmarks on their user profile page.

# Setup and Configuration

**Languages and Frameworks**: Ruby on Rails and Bootstrap

**Ruby version 2.3.0p0**

**Rails version 4.2.5**

**Databases**: SQLite (Test, Development), PostgreSQL (Production)

**Development Tools and Gems include**:

+ Devise for user authentication
+ SendGrid for email confirmation
+ Mailgun for email confirmation and API
+ Faker and Factory Girl for test suite success
+ Pundit for authorization
+ HAML for some markup
+ Gravatar for user icon

**Setup:**

+ Environment variables were set using Figaro and are stored in config/application.yml (ignored by git).

+ The config/application.example.yml file illustrates how environment variables should be stored.

**To run Shamrks locally:**

+ Clone the repository
+ Run bundle install
+ Create and migrate the SQLite database with `rake db:create` and `rake db:migrate`
+ Start the server using `rails server`
+ Run the app on `localhost:3000`
