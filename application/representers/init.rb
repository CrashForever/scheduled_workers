# frozen_string_literal: false

require 'roar/decorator'
require 'roar/json'

Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
  require file
end
