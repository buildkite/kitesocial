# Use Ruby 3.4.1
FROM ruby:3.4.1

# Install dependencies
RUN apt-get update -qq && \
  apt-get install -y nodejs npm sqlite3 build-essential && \
  rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application
COPY . .

# Precompile assets (for production-like environment)
# RUN RAILS_ENV=test bundle exec rails assets:precompile

# Create storage directories
RUN mkdir -p storage tmp/pids

# Expose port 3000
EXPOSE 3000

# Default command
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
