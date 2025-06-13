# frozen_string_literal: true

require "git_on"

module Producing
  def self.true?
    environment == :production
  end

  def self.production?
    true?
  end

  def self.development?
    environment == :development
  end

  def self.test?
    environment == :test
  end

  def self.environment
    if ENV['ENVIRONMENT']
      case ENV['ENVIRONMENT'].downcase
      when 'production'
        return :production
      when 'development'
        return :development
      when 'test'
        return :test
      end
    end
    if ENV['RAILS_ENV']
      return ENV['RAILS_ENV'].downcase.to_sym
    end
    if ENV['RACK_ENV']
      return ENV['RACK_ENV'].downcase.to_sym
    end
    git_status = GitOn.status
    if git_status[:git] == :active 
      return :production if git_status[:branch] == "master"
    end
    :development
  end
end
