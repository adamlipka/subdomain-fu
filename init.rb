require 'action_controller/base'

# Allow whatever Ruby Package tool is being used to manage load paths. Also prevents from loading subdomain fu twice.
require 'subdomain-fu' unless defined?(SubdomainFu)

ActionController::Base.send :include, SubdomainFu::Controller
