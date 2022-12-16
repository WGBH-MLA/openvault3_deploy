FROM ruby:3.1
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

CMD bash
