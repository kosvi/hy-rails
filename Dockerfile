FROM ruby:3.1.2-alpine
RUN apk add build-base postgresql-dev tzdata nodejs
WORKDIR /usr/src/app
COPY . .
RUN bundle config set --local without 'development test'
RUN bundle install
RUN rails assets:precompile
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
