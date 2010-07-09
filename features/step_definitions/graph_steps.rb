Given /^a graph with "([^"]*)"$/ do |definition|
  @graph = Trains::Graph::parse(definition)
end

Given /^a bad graph with "([^"]*)"$/ do |definition|
  begin
    @graph = Trains::Graph::parse(definition)
    @graph.should be_nil
  rescue ArgumentError
    @exception = $!
  end
end

# Walk

When /^the route is "([^"]*)"$/ do |path|
  @distance_calc = @graph.route_distance(path.chars)
end

Then /^the distance should be (\d+)$/ do |distance_should|
  @distance_calc.should == distance_should.to_i
end

Then /^there should be no route!$/ do
  @distance_calc.should be_nil
end

# All routes

When /^I look for all routes from "([^"]*)" to "([^"]*)" with at most (\d+) stops$/ do |source, destination, stops_max|
  @routes = @graph.all_routes(source, destination) { |p| p.length <= stops_max.to_i }
end

When /^I look for all routes from "([^"]*)" to "([^"]*)" with exactly (\d+) stops$/ do |source, destination, stops|
  @routes = @graph.all_routes(source, destination) { |p| p.length <= stops.to_i }.reject { |p| p.length != stops.to_i }
end

When /^I look for all routes from "([^"]*)" to "([^"]*)" with a distance of less than (\d+)$/ do |source, destination, distance_limit|
  @routes = @graph.all_routes(source, destination) { |p| p.distance < distance_limit.to_i }
end

When /^I look for all routes from "([^"]*)" to "([^"]*)"$/ do |source, destination|
  begin
    @routes = @graph.all_routes(source, destination) { |p| true }
  rescue NoMemoryError
    @exception = $!
  end
end

Then /^there should be (\d+) routes$/ do |count|
  @routes.length.should == count.to_i
end

Then /^those routes should be:$/ do |table|
  routes_are = @routes.map { |r| route_string(r) }
  routes_should = table.hashes.map { |h| h.values }.flatten

  routes_are.sort.should == routes_should.sort
end

# Shortest route

When /^I look for the shortest route from "([^"]*)" to "([^"]*)"$/ do |source, destination|
  @route = @graph.shortest_route(source, destination)
end

Then /^the total distance should be (\d+)$/ do |distance|
  @route.distance.should == distance.to_i
end

Then /^there should be no shortest route!$/ do
  @route.should be_empty
end

# Exception checking

Then /^a[n]? (\w+) of "([^"]*)" should be thrown$/ do |exception_name, message|
  @exception.should_not be_nil
  @exception.class.name.should == exception_name
  @exception.message.should == message
end

# Graph examination

Then /^there should be (\d+) edges$/ do |count|
  @graph.length.should == count.to_i
end

Then /^there should be edges:$/ do |table|
  vertices_should = table.hashes.map { |h| h.values }.flatten
  vertices_are = @graph.distances.map { |f, e| e.map { |t, d| f + t + d.to_s } }.flatten

  vertices_are.sort.should == vertices_should.sort
end

# CLI fun times

When /^I run the program with:$/ do |input|
  Dir.chdir(File.join(File.dirname(__FILE__), '../../')) do
    IO.popen("bin/tw-problem /dev/stdin", "w+") do |io|
      io.puts input
      io.close_write
      @output = io.read.chomp
    end
  end
end

Then /^I should see:$/ do |expect|
  @output.should == expect
end
