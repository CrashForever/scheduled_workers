folders = %w[infrastructure/messaging application/representers]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
