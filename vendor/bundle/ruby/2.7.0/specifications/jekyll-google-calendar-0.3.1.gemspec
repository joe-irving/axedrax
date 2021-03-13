# -*- encoding: utf-8 -*-
# stub: jekyll-google-calendar 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-google-calendar".freeze
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Gundry".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-06-23"
  s.description = "Scrapes events from one or more Google Calendars based on their calendar ids and generates pages, providing the event data through Jekyll's page variable. ".freeze
  s.email = ["david@davidgundry.co.uk".freeze]
  s.homepage = "https://github.com/davidgundry/jekyll-google-calendar".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Generate Jekyll posts from Google Calendar events".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 12.3.3"])
    s.add_runtime_dependency(%q<google-api-client>.freeze, ["~> 0.9"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.3.3"])
    s.add_dependency(%q<google-api-client>.freeze, ["~> 0.9"])
  end
end
