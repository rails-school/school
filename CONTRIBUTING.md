# Contributing

We love pull requests. Here's a quick guide.

Fork, then clone the repo:

    git clone git@github.com:your-username/school.git

Set up your machine:

    cd school
    bundle install
    rake db:setup

Make sure the tests pass:

    rake

Make your change. Add tests for your change. Make the tests pass:

    rake

Push to your fork and [submit a pull request][pr].

[pr]:https://github.com/rails-school/school/compare

At this point you're waiting on us. We like to at least comment on pull requests
within three business days (and, typically, one business day). We may suggest
some changes or improvements or alternatives.

Once we are satisfied with your pull request, we will comment "+1" and grant you
push access to the origin repo. Then you may merge your PR yourself.

Some things that will increase the chance that your pull request is accepted:

* Write tests.
* Follow the [Ruby style guide][ruby-style] and [Rails style guide][rails-style].
* Write a [good commit message][commit].

[ruby-style]: https://github.com/bbatsov/ruby-style-guide
[rails-style]: https://github.com/bbatsov/rails-style-guide
[commit]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
