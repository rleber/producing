# frozen_string_literal: true

require "git_on"

module Producing
  def self.true?
    return true if ENV['RAILS_ENV']&.downcase == 'production'
    return true if ENV['RACK_ENV']&.downcase == 'production'
    git_status = GitOn.status
    return true if git_status[:git] == :active && git_status[:branch] == "master"
    false
  end
end
