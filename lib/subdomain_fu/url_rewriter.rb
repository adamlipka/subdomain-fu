require 'action_dispatch/routing/route_set'

module ActionDispatch
  module Routing
    class RouteSet #:nodoc:
      def url_for_with_subdomains(options, path_segments=nil)
        host_with_port   = options[:host]
        host_with_port ||= @request.host_with_port unless @request.nil?
        subdomain        = options.delete(:subdomain)
        
        if options[:only_path] == false || SubdomainFu.needs_rewrite?(subdomain, host_with_port)
          options[:only_path] = false if SubdomainFu.override_only_path?
          options[:host] = SubdomainFu.rewrite_host_for_subdomains(subdomain, host_with_port)
        end
        
        url_for_without_subdomains(options)
      end
      
      alias_method_chain :url_for, :subdomains
    end
  end
end
