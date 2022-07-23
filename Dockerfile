FROM --platform=linux/amd64 ruby:3.1.2

RUN mkdir /app
WORKDIR /app

COPY ./Gemfile /app/Gemfile
COPY ./Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY . /app
RUN rm -f tmp/pids/server.pid

EXPOSE 3000
CMD bundle exec rails s -p 3000 -b '0.0.0.0'
