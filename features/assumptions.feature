Feature: ThoughtWorks PROBLEM assumptions
	In order to not be an infinite locking crappy jerk program
	I want to ensure basic assumptions are checked

	Scenario: A given route appears more than once.
		Given a bad graph with "AB5 AB10"
		Then an ArgumentError of "AB is routed multiple times" should be thrown

	Scenario: A given route has the same starting and ending town.
		Given a bad graph with "AA1"
		Then an ArgumentError of "AA routes to itself" should be thrown

	Scenario: A route search has an unconstrained loop.
		Given a graph with "AB5 BC5 CA5"
		When I look for all routes from "A" to "A"
		Then a NoMemoryError of "Too deep (limit of 1000)" should be thrown
