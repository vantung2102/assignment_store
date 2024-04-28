FROM ruby:3.0.0

WORKDIR /app

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
RUN npm install --global yarn

COPY package.json yarn.lock /app/
RUN yarn install

COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app

EXPOSE 3000

RUN bundle exec rake assets:precompile
CMD bundle exec rails s -p 3000 -b 0.0.0.0
