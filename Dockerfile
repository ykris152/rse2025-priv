# Start with Ubuntu as the base image
FROM ubuntu:latest

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    ruby-full \
    build-essential \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up environment variables for Ruby Gems
ENV GEM_HOME="/root/gems"
ENV PATH="/root/gems/bin:${PATH}"

# Install Jekyll and Bundler
RUN gem install jekyll bundler

# Create a working directory
WORKDIR /app

# Set up a volume to persist data
VOLUME /app

COPY . /app/

# Expose port 4000 for Jekyll server
EXPOSE 4000

# Initialize bundle and add Jekyll to Gemfile
RUN bundle init && \
    echo 'gem "jekyll"' >> Gemfile

# Command to serve Jekyll with host binding
CMD ["jekyll", "serve", "--host", "0.0.0.0"]