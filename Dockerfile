FROM ruby:3.1
WORKDIR /root

COPY Gemfile Gemfile.lock ./

RUN bundle install

CMD bash
