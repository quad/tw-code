# Helpers for the BDD test implementations.

begin
  require 'rspec/expectations'
rescue LoadError
  require 'spec/expectations'
end

require 'trains'

class GraphWorld        # :nodoc:
  # Make a route string for an enumeration of edges.
  def route_string(edges)
    edges.first and edges.first.from + edges.map { |e| e.to }.join
  end
end

World do
  GraphWorld.new
end
