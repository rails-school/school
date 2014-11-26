# encoding: UTF-8

puts "Creating School - San Francisco"
school = School.where(name: "San Francisco").first_or_create do |school|
  school.slug = 'sf'
  school.timezone = 'Pacific Time (US & Canada)'
  school.day_of_week = "tuesday"
end

puts "Creating School - Charlottesville, VA"
school = School.where(name: "Charlottesville, VA").first_or_create do |school|
  school.slug = 'cville'
  school.timezone = 'Eastern Time (US & Canada)'
end

puts "Creating Venue - Noisebridge"
venue = Venue.where(name: "Noisebridge").first_or_create do |venue|
  venue.address = '2169 Mission Street'
  venue.city = 'San Francisco'
  venue.state = 'California'
  venue.country = 'United States'
  venue.zip = '94103'
  venue.comment = 'Church room'
  venue.school_id = 1
end

puts "Creating Venue - HackCville"
venue = Venue.where(name: "Hack Cville").first_or_create do |venue|
  venue.address = '9 Elliewood Avenue'
  venue.city = 'Charlottesville'
  venue.state = 'Virginia'
  venue.country = 'United States'
  venue.zip = '22903'
  venue.school_id = 2
end


puts "Creating lesson Class: topic is BLOGS"
lesson = Lesson.where(title: "Class: topic is BLOGS").first_or_create do |lesson|
  lesson.title = "Class: topic is BLOGS"
  lesson.start_time = Time.parse("2013-05-08 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = " We'll take a look at some blog features and talk about how they might be implemented."
  lesson.description = <<EOF
In preparation please tackle <a href="http://guides.rubyonrails.org/">http://guides.rubyonrails.org/</a> getting_started.html and get as far as you can in setting up a simple blog app.
Please post some links here to your favorite blogs. We'll take a look at some blog features and talk about how they might be implemented.
Gabe's pick:  <a href="http://www.overheardinnewyork.com/">http://www.overheardinnewyork.com/</a>
Notes:
<a href="http://openetherpad.org/sIYNUEPzld">http://openetherpad.org/sIYNUEPzld</a>
EOF
end
puts "Creating lesson Demo Day!"
lesson = Lesson.where(title: "Demo Day!").first_or_create do |lesson|
  lesson.title = "Demo Day!"
  lesson.start_time = Time.parse("2013-05-15 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = " We'll take a look at some blog features and talk about how they might be implemented."
  lesson.description = <<EOF
This class we're going to start with a show-and-tell of projects we're working on or have recently completed. The demos don't have to be Ruby- or Rails-related, but should be related to web programming in some way. This is a chance to get answers to your project-specific questions, find fun new projects to work on, and receive great feedback.
Then we'll break up into two groups, one for beginners and one for more experienced students.
EOF
end
puts "Creating lesson  Authentication with the Devise gem"
lesson = Lesson.where(title: " Authentication with the Devise gem").first_or_create do |lesson|
  lesson.title = " Authentication with the Devise gem"
  lesson.start_time = Time.parse("2013-05-22 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "add authentication to the blogs we created"
  lesson.description = <<EOF
In preparation please finish the tutorial at http://guides.rubyonrails.org/getting_started.html . Seriously!
Enough talking about awesome Rails gems, let's use one in an app. We're going to add authentication to the blogs we created in the Getting Started guide, using the devise gem.
We will also have a beginners' group for folks needing help getting Rails set up or wanting to learn Ruby.
EOF
end
puts "Creating lesson Rails class"
lesson = Lesson.where(title: "Rails class").first_or_create do |lesson|
  lesson.title = "Rails class"
  lesson.start_time = Time.parse("2013-05-29 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Intro to Product Development"
  lesson.description = <<EOF
5/29 Class

http://rails-school.heroku.com/

* Useful and convenient single tool for our class
* Taking attendance, discussion of theme for upcoming less
* Lots of Rails features-- comments, ratings, pics, friendly ID's

New folks
Will - W Kentuckian on vacation, CS student
Antonio - HTML, building game to connect unemployed folks with online work, works in social enterprise

What's great
Functionality is amazing
Random comments
Layout and use of space
Intuitive use of ajax
Edit stuff in main interface

Suggestions/questions
Clarity on RSVP vs. attendance
AgileZen #1
Moderation
Deleting comments - AgileZen #2
Email
Skills on profiles of students attend will help teacher organize
We want to know how difficult a class is, maybe denoted in stars?
Slideshow is noisy -- maybe let it run once or with longer intervals between


Vision statement?

" Single place to organize information and interaction about a recurring class transparently and accessibly to facilitate planning, scheduling, and sharing. "

EOF
end
puts "Creating lesson Ajax in Rails"
lesson = Lesson.where(title: "Ajax in Rails").first_or_create do |lesson|
  lesson.title = "Ajax in Rails"
  lesson.start_time = Time.parse("2013-06-05 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Rails' Unobtrusive Javascript framework"
  lesson.description = <<EOF
We're going to continue our discussion of using Rails' Unobtrusive Javascript framework to add ajax interaction to our blog apps.

Please make sure you've completed <a href="http://guides.rubyonrails.org/getting_started.html">Blog guide</a> so we're all on the same page.

And RSVP here, please!
EOF
end
puts "Creating lesson Dissecting the request lifecycle with pry"
lesson = Lesson.where(title: "Dissecting the request lifecycle with pry").first_or_create do |lesson|
  lesson.title = "Dissecting the request lifecycle with pry"
  lesson.start_time = Time.parse("2013-06-12 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Let's investigate the journey of a request through Rails with some help from the debugging tool pry."
  lesson.description = <<EOF
Required reading

"Rails 3 in a Nutshell" by O'Reilly, Chapter 2, up to and including the Controller section
http://ofps.oreilly.com/titles/9780596521424/rails.html

Required viewing

"Pry with Rails" by Railscasts
http://railscasts.com/episodes/280-pry-with-rails
EOF
end
puts "Creating lesson Test-Driven-Development and Sending Emails"
lesson = Lesson.where(title: "Test-Driven-Development and Sending Emails").first_or_create do |lesson|
  lesson.title = "Test-Driven-Development and Sending Emails"
  lesson.start_time = Time.parse("2013-06-19 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "In this ambitious lecture-workshop, we're going to introduce Test-Driven-Development, and apply it to sending emails from our blogs."
  lesson.description = <<EOF
New students and others interested will have the option of learning Ruby 101 separately.

Homework: First make sure you've completed <a href="http://guides.rubyonrails.org/getting_started.html">http://guides.rubyonrails.org/getting_started.html</a>, we will continue to work off of this tutorial.  Then get as far as you can in both of the following tutorials.  Don't worry if you don't finish them.

''Action Mailer Basics'' by RailsGuides

<a href="http://guides.rubyonrails.org/action_mailer_basics.html">http://guides.rubyonrails.org/action_mailer_basics.html</a>

''Request Specs and Capybara'' by Railscasts

<a href="http://railscasts.com/episodes/257-request-specs-and-capybara">http://railscasts.com/episodes/257-request-specs-and-capybara</a>
EOF
end
puts "Creating lesson Layouts and Rendering in Rails"
lesson = Lesson.where(title: "Layouts and Rendering in Rails").first_or_create do |lesson|
  lesson.title = "Layouts and Rendering in Rails"
  lesson.start_time = Time.parse("2013-06-26 18:59:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Will go through the layout features of Action Controller and Action View"
  lesson.description = <<EOF
You will learn how to:

Use the various rendering methods built into Rails
Create layouts with multiple content sections
Use partials to DRY up your views
Use nested layouts (sub-templates)
EOF
end
puts "Creating lesson Playing with APIs"
lesson = Lesson.where(title: "Playing with APIs").first_or_create do |lesson|
  lesson.title = "Playing with APIs"
  lesson.start_time = Time.parse("2013-07-03 19:01:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "We will use Twitter API in a rails app"
  lesson.description = <<EOF
In this class we will use Twitter's API (https://dev.twitter.com/docs/api) and integrate Twitter functionality into our Rails app.
EOF
end
puts "Creating lesson Continuous Integration with Travis"
lesson = Lesson.where(title: "Continuous Integration with Travis").first_or_create do |lesson|
  lesson.title = "Continuous Integration with Travis"
  lesson.start_time = Time.parse("2013-07-10 19:01:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Intro to CI including configuring our apps to run on Travis-CI"
  lesson.description = <<EOF
Please bring a Rails app that you've already pushed to Github.

Suggested reading:

<a href='http://martinfowler.com/articles/continuousIntegration.html'>''Continuous Integration'' by Martin Fowler</a>

EOF
end
puts "Creating lesson Catch-up Day"
lesson = Lesson.where(title: "Catch-up Day").first_or_create do |lesson|
  lesson.title = "Catch-up Day"
  lesson.start_time = Time.parse("2013-07-17 07:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "We're going to use this class to catch up new students."
  lesson.description = <<EOF
The two big things we want to accomplish:

a)  bootstrapping your development environment - follow <a href="http://installfest.railsbridge.org/installfest/installfest">http://installfest.railsbridge.org/installfest/installfest</a>

b)  setting up a basic blog application - follow <a href="http://guides.rubyonrails.org/getting_started.html">http://guides.rubyonrails.org/getting_started.html</a>

To prepare for this class, get as far as you can in these two tutorials.

Experienced students please consider coming out to help troubleshoot.  This class will be a looser format than usual, so everyone, please bring snacks!  If there's interest, we will get beers at Shotwell's afterward to celebrate being caught up.
EOF
end
puts "Creating lesson Fun with the Stripe payment API"
lesson = Lesson.where(title: "Fun with the Stripe payment API").first_or_create do |lesson|
  lesson.title = "Fun with the Stripe payment API"
  lesson.start_time = Time.parse("2013-07-24 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "We'll hook up Stripe's API in our blog apps."
  lesson.description = <<EOF
Please sign up for Stripe ahead of time - 

<a href="https://manage.stripe.com/register">https://manage.stripe.com/register</a>

Here's a handy link to Stripe's API docs - 

<a href="https://stripe.com/docs">https://stripe.com/docs</a>

Required reading
How I Explained REST to My Wife by Ryan Tomayko

<a href="http://tomayko.com/writings/rest-to-my-wife">http://tomayko.com/writings/rest-to-my-wife</a>
EOF
end
puts "Creating lesson Rails' Asset Pipeline"
lesson = Lesson.where(title: "Rails' Asset Pipeline").first_or_create do |lesson|
  lesson.title = "Rails' Asset Pipeline"
  lesson.start_time = Time.parse("2013-07-31 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "We'll look closely at asset organization, compilation, and packaging, and also check out SCSS and Coffeescript."
  lesson.description = <<EOF
Required viewing 

"Understanding the Asset Pipeline" by RailsCasts

<a href="http://railscasts.com/episodes/279-understanding-the-asset-pipeline">http://railscasts.com/episodes/279-understanding-the-asset-pipeline</a>
EOF
end
puts "Creating lesson Ruby, API's, and Gems"
lesson = Lesson.where(title: "Ruby, API's, and Gems").first_or_create do |lesson|
  lesson.title = "Ruby, API's, and Gems"
  lesson.start_time = Time.parse("2013-08-07 19:01:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "No Rails today; Ruby, Rest API's and Ruby Gems instead!"
  lesson.description = <<EOF
Highly Recommended Reading

<a href="http://mislav.uniqpath.com/poignant-guide/">Why's (Poignant) Guide to Ruby</a>
EOF
end
puts "Creating lesson Twitter API"
lesson = Lesson.where(title: "Twitter API").first_or_create do |lesson|
  lesson.title = "Twitter API"
  lesson.start_time = Time.parse("2013-08-14 19:03:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Using twitter API to build fun app"
  lesson.description = <<EOF
Homework: think how you want to use twitter API and what kind of APPs do you want to make with it.

We will use this gem: <a href="https://github.com/sferik/twitter">twitter gem</a>

Twitter API methods: <a href="https://dev.twitter.com/docs/api">Twitter API methods</a>
EOF
end
puts "Creating lesson ActiveRecord"
lesson = Lesson.where(title: "ActiveRecord").first_or_create do |lesson|
  lesson.title = "ActiveRecord"
  lesson.start_time = Time.parse("2013-08-21 07:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Taking a better look at this essential part of Rails"
  lesson.description = <<EOF
Suggested reading:

http://guides.rubyonrails.org/active_record_querying.html

http://guides.rubyonrails.org/association_basics.html

http://guides.rubyonrails.org/active_record_validations_callbacks.html

EOF
end
puts "Creating lesson Self-posting Novelty Twitter Accounts"
lesson = Lesson.where(title: "Self-posting Novelty Twitter Accounts").first_or_create do |lesson|
  lesson.title = "Self-posting Novelty Twitter Accounts"
  lesson.start_time = Time.parse("2013-08-28 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Let's create bots that make interesting tweets periodically"
  lesson.description = <<EOF
The homework is just to come up with a fun and simple idea for the tweets you want your bot to post.   Also, register your novelty twitter username and a twitter app: <a href="http://dev.twitter.com">http://dev.twitter.com</a>.
And make sure you have a heroku account set up.

We'll also have a Ruby 101 break-out group for people that are not ready to program twitter bots.

Backup etherpad
<a href="http://openetherpad.org/2fkGG5usTT">http://openetherpad.org/2fkGG5usTT</a>


POOP!
EOF
end
puts "Creating lesson Scraping and Parsing the Web"
lesson = Lesson.where(title: "Scraping and Parsing the Web").first_or_create do |lesson|
  lesson.title = "Scraping and Parsing the Web"
  lesson.start_time = Time.parse("2013-09-11 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "The last resort when there is no API, scraping and parsing isn't much fun, but Ruby's got some great tools to alleviate the pain."
  lesson.description = <<EOF
Please bring some sources you want to scrape as well as ideas for what to do with the scraped data.

The homework is to complete this tutorial on regular expressions: <a href="http://net.tutsplus.com/tutorials/ruby/ruby-for-newbies-regular-expressions/">http://net.tutsplus.com/tutorials/ruby/ruby-for-newbies-regular-expressions/</a>

Regular expressions are a must-know tool when you're parsing textual data: <a href="http://xkcd.com/208/">http://xkcd.com/208/</a>

But they're not the right tool for every problem: <a href="http://www.codinghorror.com/blog/2008/06/regular-expressions-now-you-have-two-problems.html">http://www.codinghorror.com/blog/2008/06/regular-expressions-now-you-have-two-problems.html</a>

This class is Ruby-only.  New students that are Ruby newbies, please complete <a href = "http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html">http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html</a> before class.  You don't need to know Rails are have completed the Rails getting started guide before attending Ruby-only classes like this one.
EOF
end
puts "Creating lesson Hack with Foursquare API"
lesson = Lesson.where(title: "Hack with Foursquare API").first_or_create do |lesson|
  lesson.title = "Hack with Foursquare API"
  lesson.start_time = Time.parse("2013-09-04 19:01:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Lets learn how to use foursquare API and what can we make out of it"
  lesson.description = <<EOF
Homework:

1. generate ideas about how to use foursquare API and what apps could be made with it. 
We will decide what app we are going to build at the beginning of the class.

2. Scan through <a href="https://developer.foursquare.com/">Foursquare API documentation</a>

http://openetherpad.org/pdi19woeHg

https://gist.github.com/3630081
EOF
end
puts "Creating lesson Roll-your-own Chat App with the Goliath web server"
lesson = Lesson.where(title: "Roll-your-own Chat App with the Goliath web server").first_or_create do |lesson|
  lesson.title = "Roll-your-own Chat App with the Goliath web server"
  lesson.start_time = Time.parse("2013-09-18 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Rails isn't perfect for interactive, real-time, scalable apps.  Let's play with Goliath, a Ruby-based web server that is."
  lesson.description = <<EOF
This is Ruby-only class for which no Rails experience is required.

However, please complete this small tutorial on EventMachine beforehand: <a href="http://rubysource.com/introduction-to-event-machine/">http://rubysource.com/introduction-to-event-machine/</a>

<a href="http://openetherpad.org/6JyMNcehni">http://openetherpad.org/6JyMNcehni</a>
EOF
end
puts "Creating lesson Catch-up Day"
lesson = Lesson.where(title: "Catch-up Day").first_or_create do |lesson|
  lesson.title = "Catch-up Day"
  lesson.start_time = Time.parse("2013-09-25 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "We're going to use this class to catch up new students."
  lesson.description = <<EOF
The two big things we want to accomplish: 

a) bootstrapping your development environment - follow <a href="http://installfest.railsbridge.org/installfest/installfest">http://installfest.railsbridge.org/installfest/installfest</a> 

b) setting up a basic blog application - follow <a href="http://guides.rubyonrails.org/getting_started.html">http://guides.rubyonrails.org/getting_started.html</a>

To prepare for this class, get as far as you can in these two tutorials. 

Experienced students please consider coming out to help troubleshoot. This class will be a looser format than usual, so everyone, please bring snacks! If there's interest, we will get beers at Shotwell's afterward to celebrate being caught up.
EOF
end
puts "Creating lesson Etherpad Bots"
lesson = Lesson.where(title: "Etherpad Bots").first_or_create do |lesson|
  lesson.title = "Etherpad Bots"
  lesson.start_time = Time.parse("2013-10-02 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Let's write some bots that interact in Etherpads"
  lesson.description = <<EOF
Etherpads are the shared docs we take our class notes on.

Read about Etherpads here: <a href="http://etherpad.org/">http://etherpad.org/</a>

We will target an Etherpad-Lite instance using Ruby.  Visit <a href="https://github.com/jhollinger/ruby-etherpad-lite">https://github.com/jhollinger/ruby-etherpad-lite</a> to get some ideas what might be possible.
EOF
end
puts "Creating lesson Sending email using background workers"
lesson = Lesson.where(title: "Sending email using background workers").first_or_create do |lesson|
  lesson.title = "Sending email using background workers"
  lesson.start_time = Time.parse("2013-10-09 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Sending email using background workers"
  lesson.description = <<EOF
In this class we will show how to send email using Rails. We will also utilize delayed_job gem to handle the actual email sending in the background. 

Suggested reading:

ActiveMailer: http://guides.rubyonrails.org/action_mailer_basics.html

Delayed Job: https://github.com/collectiveidea/delayed_job
EOF
end
puts "Creating lesson How to prepare your Rails app for production"
lesson = Lesson.where(title: "How to prepare your Rails app for production").first_or_create do |lesson|
  lesson.title = "How to prepare your Rails app for production"
  lesson.start_time = Time.parse("2013-10-16 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Essential steps to take before you launch"
  lesson.description = <<EOF
By choosing to build your web app in Rails, countless choices have been made for you that give you the best chance of a successful launch.  Nevertheless, there are some details you will need to take care of on your own.

In this class, we will implement the minimum precautionary steps to ensure the performance and security of our Rails apps.

Please make sure you have completed the Getting Started guide at <a href="http://guides.rubyonrails.org/getting_started.html">http://guides.rubyonrails.org/getting_started.html</a> and be ready to hack on your blogs in class.

Recommended reading
<a href="http://guides.rubyonrails.org/security.html">http://guides.rubyonrails.org/security.html</a>
<a href="http://guides.rubyonrails.org/caching_with_rails.html">http://guides.rubyonrails.org/caching_with_rails.html</a>
EOF
end
puts "Creating lesson Calculating π with Object-Oriented Ruby and Test-Driven Development"
lesson = Lesson.where(title: "Calculating π with Object-Oriented Ruby and Test-Driven Development").first_or_create do |lesson|
  lesson.title = "Calculating π with Object-Oriented Ruby and Test-Driven Development"
  lesson.start_time = Time.parse("2013-10-23 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Let's use our favorite programming language to calculate one of our favorite irrationals"
  lesson.description = <<EOF
You don't need Rails for this class; it's Ruby-only.  Just bring a laptop with Ruby 1.9.

Suggested Preparation

<a href="http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html">http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html</a>

<a href="http://blog.teamtreehouse.com/an-introduction-to-rspec">http://blog.teamtreehouse.com/an-introduction-to-rspec</a>
EOF
end
puts "Creating lesson Image Uploads in Rails with TDD"
lesson = Lesson.where(title: "Image Uploads in Rails with TDD").first_or_create do |lesson|
  lesson.title = "Image Uploads in Rails with TDD"
  lesson.start_time = Time.parse("2013-10-30 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "Let's add images to out blog posts"
  lesson.description = <<EOF
Please complete <a href="http://guides.rubyonrails.org/getting_started.html">http://guides.rubyonrails.org/getting_started.html</a> beforehand.
EOF
end
puts "Creating lesson Refactoring existing code"
lesson = Lesson.where(title: "Refactoring existing code").first_or_create do |lesson|
  lesson.title = "Refactoring existing code"
  lesson.start_time = Time.parse("2013-11-06 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "How to refactor Rails code"
  lesson.description = <<EOF
We're going to take a look at refactoring an existing Rails up. Learn how to improve your models, controllers and views.
EOF
end
puts "Creating lesson Rails and Mixpanel"
lesson = Lesson.where(title: "Rails and Mixpanel").first_or_create do |lesson|
  lesson.title = "Rails and Mixpanel"
  lesson.start_time = Time.parse("2015-04-14 19:00:00 UTC")
  lesson.end_time = lesson.start_time + 2.hours
  lesson.venue_id = 1
  lesson.summary = "How to implement mixpanel and rails"
  lesson.description = <<EOF
We're going to learn how to send data to mixpanel in a rails app using javascript.
EOF
end
