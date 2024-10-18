# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/features/'
  add_filter 'app/mailers/application_mailer.rb'
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/channels/application_cable'
end
