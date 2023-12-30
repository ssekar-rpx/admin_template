FROM ruby:3.2-alpine

WORKDIR /opt/ssekar

# Install dependencies
RUN apk update

RUN apk add --no-cache nodejs npm

RUN npm install -g yarn

RUN apk add --no-cache build-base postgresql-dev

RUN apk add --no-cache build-base libxml2-dev libxslt-dev

RUN apk add --no-cache libxml2 libxslt

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v 2.4.1 && bundle install

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
