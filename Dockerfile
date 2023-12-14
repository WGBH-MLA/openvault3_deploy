FROM ruby:3.2
WORKDIR /root

COPY Gemfile Gemfile.lock ./

RUN bundle install

CMD bundle exec cap aws deploy
