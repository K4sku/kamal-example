#!/usr/bin/env ruby

# Only check the build status for staging deployments
if ENV["KAMAL_COMMAND"] == "rollback" || ENV["KAMAL_DESTINATION"] != "staging"
  exit 0
end

require 'open3'

# KAMAL_SERVICE_VERSION = app@150b24f
# KAMAL_DESTINATION - optional: destination, e.g. “staging”

# Define the network name
service_name = ENV["KAMAL_SERVICE_VERSION"].split("@").first
destination = ENV.fetch("KAMAL_DESTINATION", "")

network_name = "#{service_name}-#{destination}".freeze

$stdout.sync = true

# Check if the network exists
_stdout, status = Open3.capture2("docker network ls | grep #{network_name}")
if status.success?
  puts "Network #{network_name} already exists."
  exit 0
end

# Create the network
_stdout, stderr, status = Open3.capture3("docker network create --driver bridge #{network_name}")

if status.success?
  puts "Network #{network_name} created."
  exit 0
else
  $stderr.puts "Failed to create network #{network_name}. Error: #{stderr}"
  exit 1
end
