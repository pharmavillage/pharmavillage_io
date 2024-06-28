# Stage 1: Cloning the repository
FROM arm64v8/ruby AS clone-stage

# Install git
RUN apt-get update -qq && apt-get install -y git

# Set the working directory and clone the repository
WORKDIR /usr/src/app
RUN git clone https://github.com/pharmavillage/documentation.git pharmavillage-doc

# Stage 2: Building the final image
FROM arm64v8/ruby

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Copy the cloned repository from the previous stage
COPY --from=clone-stage /usr/src/app/pharmavillage-doc /usr/src/app/pharmavillage-doc

# Set the working directory
WORKDIR /usr/src/app

# Copy the rest of the application code
COPY . .

# Install the required gems
RUN gem install tilt dep rackup && dep install

EXPOSE 9292

# Start the application
CMD ["sh", "-c", "PHARMAVILLAGE_DOC=/usr/src/app/pharmavillage-doc rackup -o 0.0.0.0"]
