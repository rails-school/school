puts "Creating lesson Class: topic is BLOGS"
lesson = Lesson.find_or_create_by_title("Class: topic is BLOGS") do |lesson|
  lesson.title = "Class: topic is BLOGS"
  lesson.description = " We'll take a look at some blog features and talk about how they might be implemented."
  lesson.address = "NoiseBridge"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-05-08 19:00:00 UTC')
  lesson.text = <<EOF
In preparation please tackle <a href="http://guides.rubyonrails.org/">http://guides.rubyonrails.org/</a> getting_started.html and get as far as you can in setting up a simple blog app.
Please post some links here to your favorite blogs. We'll take a look at some blog features and talk about how they might be implemented.
Gabe's pick:  <a href="http://www.overheardinnewyork.com/">http://www.overheardinnewyork.com/</a>
Notes:
<a href="http://openetherpad.org/sIYNUEPzld">http://openetherpad.org/sIYNUEPzld</a>
EOF
end
puts "Creating lesson Demo Day!"
lesson = Lesson.find_or_create_by_title("Demo Day!") do |lesson|
  lesson.title = "Demo Day!"
  lesson.description = " We'll take a look at some blog features and talk about how they might be implemented."
  lesson.address = "NoiseBridge"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-05-15 19:00:00 UTC')
  lesson.text = <<EOF
This class we're going to start with a show-and-tell of projects we're working on or have recently completed. The demos don't have to be Ruby- or Rails-related, but should be related to web programming in some way. This is a chance to get answers to your project-specific questions, find fun new projects to work on, and receive great feedback.
Then we'll break up into two groups, one for beginners and one for more experienced students.
EOF
end
puts "Creating lesson  Authentication with the Devise gem"
lesson = Lesson.find_or_create_by_title(" Authentication with the Devise gem") do |lesson|
  lesson.title = " Authentication with the Devise gem"
  lesson.description = "add authentication to the blogs we created"
  lesson.address = "NoiseBridge"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-05-22 19:00:00 UTC')
  lesson.text = <<EOF
In preparation please finish the tutorial at http://guides.rubyonrails.org/getting_started.html . Seriously!
Enough talking about awesome Rails gems, let's use one in an app. We're going to add authentication to the blogs we created in the Getting Started guide, using the devise gem.
We will also have a beginners' group for folks needing help getting Rails set up or wanting to learn Ruby.
EOF
end
puts "Creating lesson Rails class"
lesson = Lesson.find_or_create_by_title("Rails class") do |lesson|
  lesson.title = "Rails class"
  lesson.description = "Intro to Product Development"
  lesson.address = "NoiseBridge"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-05-29 19:00:00 UTC')
  lesson.text = <<EOF
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
lesson = Lesson.find_or_create_by_title("Ajax in Rails") do |lesson|
  lesson.title = "Ajax in Rails"
  lesson.description = "Rails' Unobtrusive Javascript framework"
  lesson.address = "San Francisco"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-06-05 19:00:00 UTC')
  lesson.text = <<EOF
We're going to continue our discussion of using Rails' Unobtrusive Javascript framework to add ajax interaction to our blog apps.

Please make sure you've completed <a href="http://guides.rubyonrails.org/getting_started.html">Blog guide</a> so we're all on the same page.

And RSVP here, please!
EOF
end
puts "Creating lesson Dissecting the request lifecycle with pry"
lesson = Lesson.find_or_create_by_title("Dissecting the request lifecycle with pry") do |lesson|
  lesson.title = "Dissecting the request lifecycle with pry"
  lesson.description = "Let's investigate the journey of a request through Rails with some help from the debugging tool pry."
  lesson.address = "Church Room, Noisebridge, 2169 Mission, SF"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-06-12 19:00:00 UTC')
  lesson.text = <<EOF
Required reading

"Rails 3 in a Nutshell" by O'Reilly, Chapter 2, up to and including the Controller section
http://ofps.oreilly.com/titles/9780596521424/rails.html

Required viewing

"Pry with Rails" by Railscasts
http://railscasts.com/episodes/280-pry-with-rails
EOF
end
puts "Creating lesson Test-Driven-Development and Sending Emails"
lesson = Lesson.find_or_create_by_title("Test-Driven-Development and Sending Emails") do |lesson|
  lesson.title = "Test-Driven-Development and Sending Emails"
  lesson.description = "In this ambitious lecture-workshop, we're going to introduce Test-Driven-Development, and apply it to sending emails from our blogs."
  lesson.address = "Church Room, Noisebridge, 2169 Mission, SF"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-06-19 19:00:00 UTC')
  lesson.text = <<EOF
New students and others interested will have the option of learning Ruby 101 separately.

Homework: First make sure you've completed <a href="http://guides.rubyonrails.org/getting_started.html">http://guides.rubyonrails.org/getting_started.html</a>, we will continue to work off of this tutorial.  Then get as far as you can in both of the following tutorials.  Don't worry if you don't finish them.

''Action Mailer Basics'' by RailsGuides

<a href="http://guides.rubyonrails.org/action_mailer_basics.html">http://guides.rubyonrails.org/action_mailer_basics.html</a>

''Request Specs and Capybara'' by Railscasts

<a href="http://railscasts.com/episodes/257-request-specs-and-capybara">http://railscasts.com/episodes/257-request-specs-and-capybara</a>
EOF
end
puts "Creating lesson Layouts and Rendering in Rails"
lesson = Lesson.find_or_create_by_title("Layouts and Rendering in Rails") do |lesson|
  lesson.title = "Layouts and Rendering in Rails"
  lesson.description = "Will go through the layout features of Action Controller and Action View"
  lesson.address = "Church Room, Noisebridge, 2169 Mission, SF"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-06-26 18:59:00 UTC')
  lesson.text = <<EOF
You will learn how to:

Use the various rendering methods built into Rails
Create layouts with multiple content sections
Use partials to DRY up your views
Use nested layouts (sub-templates)
EOF
end
puts "Creating lesson Playing with APIs"
lesson = Lesson.find_or_create_by_title("Playing with APIs") do |lesson|
  lesson.title = "Playing with APIs"
  lesson.description = "We will use Twitter API in a rails app"
  lesson.address = "Church Room, Noisebridge, 2169 Mission, SF"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-07-03 19:01:00 UTC')
  lesson.text = <<EOF
In this class we will use Twitter's API (https://dev.twitter.com/docs/api) and integrate Twitter functionality into our Rails app.
EOF
end
puts "Creating lesson Continuous Integration with Travis"
lesson = Lesson.find_or_create_by_title("Continuous Integration with Travis") do |lesson|
  lesson.title = "Continuous Integration with Travis"
  lesson.description = "Intro to CI including configuring our apps to run on Travis-CI"
  lesson.address = "Church Room, Noisebridge, 2169 Mission, SF"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-07-10 19:01:00 UTC')
  lesson.text = <<EOF
Please bring a Rails app that you've already pushed to Github.

Suggested reading:

<a href='http://martinfowler.com/articles/continuousIntegration.html'>''Continuous Integration'' by Martin Fowler</a>

EOF
end
puts "Creating lesson Catch-up Day"
lesson = Lesson.find_or_create_by_title("Catch-up Day") do |lesson|
  lesson.title = "Catch-up Day"
  lesson.description = "We're going to use this class to catch up new students."
  lesson.address = "NoiseBridge"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-07-17 07:00:00 UTC')
  lesson.text = <<EOF
The two big things we want to accomplish:

a)  bootstrapping your development environment - follow <a href="http://installfest.railsbridge.org/installfest/installfest">http://installfest.railsbridge.org/installfest/installfest</a>

b)  setting up a basic blog application - follow <a href="http://guides.rubyonrails.org/getting_started.html">http://guides.rubyonrails.org/getting_started.html</a>

To prepare for this class, get as far as you can in these two tutorials.

Experienced students please consider coming out to help troubleshoot.  This class will be a looser format than usual, so everyone, please bring snacks!  If there's interest, we will get beers at Shotwell's afterward to celebrate being caught up.
EOF
end
puts "Creating lesson Fun with the Stripe payment API"
lesson = Lesson.find_or_create_by_title("Fun with the Stripe payment API") do |lesson|
  lesson.title = "Fun with the Stripe payment API"
  lesson.description = "We'll hook up Stripe's API in our blog apps."
  lesson.address = "NoiseBridge"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-07-24 19:00:00 UTC')
  lesson.text = <<EOF
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
lesson = Lesson.find_or_create_by_title("Rails' Asset Pipeline") do |lesson|
  lesson.title = "Rails' Asset Pipeline"
  lesson.description = "We'll look closely at asset organization, compilation, and packaging, and also check out SCSS and Coffeescript."
  lesson.address = "NoiseBridge"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-07-31 19:00:00 UTC')
  lesson.text = <<EOF
Required viewing 

"Understanding the Asset Pipeline" by RailsCasts

<a href="http://railscasts.com/episodes/279-understanding-the-asset-pipeline">http://railscasts.com/episodes/279-understanding-the-asset-pipeline</a>
EOF
end
puts "Creating lesson Ruby, API's, and Gems"
lesson = Lesson.find_or_create_by_title("Ruby, API's, and Gems") do |lesson|
  lesson.title = "Ruby, API's, and Gems"
  lesson.description = "No Rails today; Ruby, Rest API's and Ruby Gems instead!"
  lesson.address = "NoiseBridge"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-08-07 19:01:00 UTC')
  lesson.text = <<EOF
Highly Recommended Reading

<a href="http://mislav.uniqpath.com/poignant-guide/">Why's (Poignant) Guide to Ruby</a>
EOF
end
puts "Creating lesson Twitter API"
lesson = Lesson.find_or_create_by_title("Twitter API") do |lesson|
  lesson.title = "Twitter API"
  lesson.description = "Using twitter API to build fun app"
  lesson.address = "Noisebridge"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-08-14 19:03:00 UTC')
  lesson.text = <<EOF
Homework: think how you want to use twitter API and what kind of APPs do you want to make with it.

We will use this gem: <a href="https://github.com/sferik/twitter">twitter gem</a>

Twitter API methods: <a href="https://dev.twitter.com/docs/api">Twitter API methods</a>
EOF
end
puts "Creating lesson ActiveRecord"
lesson = Lesson.find_or_create_by_title("ActiveRecord") do |lesson|
  lesson.title = "ActiveRecord"
  lesson.description = "Taking a better look at this essential part of Rails"
  lesson.address = "Church Room, Noisebridge, 2169 Mission, SF"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-08-21 07:00:00 UTC')
  lesson.text = <<EOF
Suggested reading:

http://guides.rubyonrails.org/active_record_querying.html

http://guides.rubyonrails.org/association_basics.html

http://guides.rubyonrails.org/active_record_validations_callbacks.html

EOF
end
puts "Creating lesson Self-posting Novelty Twitter Accounts"
lesson = Lesson.find_or_create_by_title("Self-posting Novelty Twitter Accounts") do |lesson|
  lesson.title = "Self-posting Novelty Twitter Accounts"
  lesson.description = "Let's create bots that make interesting tweets periodically"
  lesson.address = "NoiseBridge"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-08-28 19:00:00 UTC')
  lesson.text = <<EOF
The homework is just to come up with a fun and simple idea for the tweets you want your bot to post.   Also, register your novelty twitter username and a twitter app: <a href="http://dev.twitter.com">http://dev.twitter.com</a>.
And make sure you have a heroku account set up.

We'll also have a Ruby 101 break-out group for people that are not ready to program twitter bots.

Backup etherpad
<a href="http://openetherpad.org/2fkGG5usTT">http://openetherpad.org/2fkGG5usTT</a>


POOP!
EOF
end
puts "Creating lesson Scraping and Parsing the Web"
lesson = Lesson.find_or_create_by_title("Scraping and Parsing the Web") do |lesson|
  lesson.title = "Scraping and Parsing the Web"
  lesson.description = "The last resort when there is no API, scraping and parsing isn't much fun, but Ruby's got some great tools to alleviate the pain."
  lesson.address = "NoiseBridge"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-09-11 19:00:00 UTC')
  lesson.text = <<EOF
Please bring some sources you want to scrape as well as ideas for what to do with the scraped data.

The homework is to complete this tutorial on regular expressions: <a href="http://net.tutsplus.com/tutorials/ruby/ruby-for-newbies-regular-expressions/">http://net.tutsplus.com/tutorials/ruby/ruby-for-newbies-regular-expressions/</a>

Regular expressions are a must-know tool when you're parsing textual data: <a href="http://xkcd.com/208/">http://xkcd.com/208/</a>

But they're not the right tool for every problem: <a href="http://www.codinghorror.com/blog/2008/06/regular-expressions-now-you-have-two-problems.html">http://www.codinghorror.com/blog/2008/06/regular-expressions-now-you-have-two-problems.html</a>

This class is Ruby-only.  New students that are Ruby newbies, please complete <a href = "http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html">http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html</a> before class.  You don't need to know Rails are have completed the Rails getting started guide before attending Ruby-only classes like this one.
EOF
end
puts "Creating lesson Hack with Foursquare API"
lesson = Lesson.find_or_create_by_title("Hack with Foursquare API") do |lesson|
  lesson.title = "Hack with Foursquare API"
  lesson.description = "Lets learn how to use foursquare API and what can we make out of it"
  lesson.address = "Noisebridge"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-09-04 19:01:00 UTC')
  lesson.text = <<EOF
Homework:

1. generate ideas about how to use foursquare API and what apps could be made with it. 
We will decide what app we are going to build at the beginning of the class.

2. Scan through <a href="https://developer.foursquare.com/">Foursquare API documentation</a>

http://openetherpad.org/pdi19woeHg

https://gist.github.com/3630081
EOF
end
puts "Creating lesson Roll-your-own Chat App with the Goliath web server"
lesson = Lesson.find_or_create_by_title("Roll-your-own Chat App with the Goliath web server") do |lesson|
  lesson.title = "Roll-your-own Chat App with the Goliath web server"
  lesson.description = "Rails isn't perfect for interactive, real-time, scalable apps.  Let's play with Goliath, a Ruby-based web server that is."
  lesson.address = "NoiseBridge"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-09-18 19:00:00 UTC')
  lesson.text = <<EOF
This is Ruby-only class for which no Rails experience is required.

However, please complete this small tutorial on EventMachine beforehand: <a href="http://rubysource.com/introduction-to-event-machine/">http://rubysource.com/introduction-to-event-machine/</a>

<a href="http://openetherpad.org/6JyMNcehni">http://openetherpad.org/6JyMNcehni</a>
EOF
end
puts "Creating lesson Catch-up Day"
lesson = Lesson.find_or_create_by_title("Catch-up Day") do |lesson|
  lesson.title = "Catch-up Day"
  lesson.description = "We're going to use this class to catch up new students."
  lesson.address = "Noisebridge, Church room"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-09-25 19:00:00 UTC')
  lesson.text = <<EOF
The two big things we want to accomplish: 

a) bootstrapping your development environment - follow <a href="http://installfest.railsbridge.org/installfest/installfest">http://installfest.railsbridge.org/installfest/installfest</a> 

b) setting up a basic blog application - follow <a href="http://guides.rubyonrails.org/getting_started.html">http://guides.rubyonrails.org/getting_started.html</a>

To prepare for this class, get as far as you can in these two tutorials. 

Experienced students please consider coming out to help troubleshoot. This class will be a looser format than usual, so everyone, please bring snacks! If there's interest, we will get beers at Shotwell's afterward to celebrate being caught up.
EOF
end
puts "Creating lesson Etherpad Bots"
lesson = Lesson.find_or_create_by_title("Etherpad Bots") do |lesson|
  lesson.title = "Etherpad Bots"
  lesson.description = "Let's write some bots that interact in Etherpads"
  lesson.address = "Noisebridge, Church room"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-10-02 19:00:00 UTC')
  lesson.text = <<EOF
Etherpads are the shared docs we take our class notes on.

Read about Etherpads here: <a href="http://etherpad.org/">http://etherpad.org/</a>

We will target an Etherpad-Lite instance using Ruby.  Visit <a href="https://github.com/jhollinger/ruby-etherpad-lite">https://github.com/jhollinger/ruby-etherpad-lite</a> to get some ideas what might be possible.
EOF
end
puts "Creating lesson Sending email using background workers"
lesson = Lesson.find_or_create_by_title("Sending email using background workers") do |lesson|
  lesson.title = "Sending email using background workers"
  lesson.description = "Sending email using background workers"
  lesson.address = "Noisebridge, SF"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-10-09 19:00:00 UTC')
  lesson.text = <<EOF
In this class we will show how to send email using Rails. We will also utilize delayed_job gem to handle the actual email sending in the background. 

Suggested reading:

ActiveMailer: http://guides.rubyonrails.org/action_mailer_basics.html

Delayed Job: https://github.com/collectiveidea/delayed_job
EOF
end
puts "Creating lesson How to prepare your Rails app for production"
lesson = Lesson.find_or_create_by_title("How to prepare your Rails app for production") do |lesson|
  lesson.title = "How to prepare your Rails app for production"
  lesson.description = "Essential steps to take before you launch"
  lesson.address = "Noisebridge"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-10-16 19:00:00 UTC')
  lesson.text = <<EOF
By choosing to build your web app in Rails, countless choices have been made for you that give you the best chance of a successful launch.  Nevertheless, there are some details you will need to take care of on your own.

In this class, we will implement the minimum precautionary steps to ensure the performance and security of our Rails apps.

Please make sure you have completed the Getting Started guide at <a href="http://guides.rubyonrails.org/getting_started.html">http://guides.rubyonrails.org/getting_started.html</a> and be ready to hack on your blogs in class.

Recommended reading
<a href="http://guides.rubyonrails.org/security.html">http://guides.rubyonrails.org/security.html</a>
<a href="http://guides.rubyonrails.org/caching_with_rails.html">http://guides.rubyonrails.org/caching_with_rails.html</a>
EOF
end
puts "Creating lesson Calculating Pi with Object-Oriented Ruby and Test-Driven Development"
lesson = Lesson.find_or_create_by_title("Calculating Pi with Object-Oriented Ruby and Test-Driven Development") do |lesson|
  lesson.title = "Calculating Pi with Object-Oriented Ruby and Test-Driven Development"
  lesson.description = "Let's use our favorite programming language to calculate one of our favorite irrationals"
  lesson.address = "Noisebridge, Church room"
  lesson.city = 'San Francisco'
  lesson.course_id = 1
  lesson.date = Time.parse('2012-10-23 19:00:00 UTC')
  lesson.text = <<EOF
You don't need Rails for this class; it's Ruby-only.  Just bring a laptop with Ruby 1.9.

Suggested Preparation

<a href="http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html">http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html</a>

<a href="http://blog.teamtreehouse.com/an-introduction-to-rspec">http://blog.teamtreehouse.com/an-introduction-to-rspec</a>
EOF
end