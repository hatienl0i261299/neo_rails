# syntax=docker/dockerfile:1
FROM ruby:3.0.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client graphviz npm\
  && rm -rf /var/lib/apt/lists/* \
  && curl -o- -L https://yarnpkg.com/install.sh | bash
RUN mkdir /myapp
WORKDIR /myapp
COPY . /myapp
RUN bundle install
RUN npm install -g yarn

# Add a script to be executed every time the container starts.
RUN rm -f /myapp/tmp/pids/server.pid
EXPOSE 8888

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]