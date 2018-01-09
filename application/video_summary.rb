# frozen_string_literal: true

require 'econfig'
require 'aws-sdk-sqs'

require_relative '../init.rb'

extend Econfig::Shortcut
Econfig.env = ENV['WORKER_ENV'] || 'development'
Econfig.root = File.expand_path('..', File.dirname(__FILE__))

ENV['AWS_ACCESS_KEY_ID'] = config.AWS_ACCESS_KEY_ID
ENV['AWS_SECRET_ACCESS_KEY'] = config.AWS_SECRET_ACCESS_KEY
ENV['AWS_REGION'] = config.AWS_REGION

queue = VideosPraise::Messaging::Queue.new(config.SCHEDULED_QUEUE_URL)
videos = []

queue.poll do |video_json|
  video = VideosPraise::VideosRepresenter
            .new(OpenStruct.new)
            .from_json(video_json)
  videos << video
end

# Notify user about popular videos of all time.
puts "\n\nPopular videos of all time:\n\n"
videos.each do |video|
  puts "Video:  https://www.youtube.com/embed/#{video.video_id}"
end
