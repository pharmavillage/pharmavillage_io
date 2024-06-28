# Use an official Ruby runtime as a parent image
FROM arm64v8/ruby

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs git

# Set the working directory and clone the repository
WORKDIR /usr/src/app
RUN git clone https://github.com/pharmavillage/documentation.git pharmavillage-doc

# Copy the rest of the application code
COPY . .

# Install the required gems
RUN gem install tilt dep rackup && dep install

# Expose the port the app runs on
EXPOSE 6379
EXPOSE 9292

# Start the application
CMD ["sh", "-c", "PHARMAVILLAGE_DOC=/usr/src/app/pharmavillage-doc rackup -o 0.0.0.0"]
