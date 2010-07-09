Feature: Bad graph robustness
	In order to not choke on weird graphs
	I want to check some popular corner cases

	Scenario: No routes exist between two vertices
		Given a graph with "AB1 CD1"
		Then there should be 2 edges
		When the route is "AD"
		Then there should be no route!
		When I look for all routes from "A" to "D"
		Then there should be 0 routes
		When I look for the shortest route from "A" to "D"
		Then there should be no shortest route!

	Scenario: Two equal shortest paths exist between two vertices
		Given a graph with "AB1 BC1 AD1 DC1"
		Then there should be 4 edges
		When I look for the shortest route from "A" to "C"
		Then the total distance should be 2

	Scenario: There are no vertices
		Given a graph with ""
		Then there should be 0 edges
		When the route is "AB"
		Then there should be no route!
		When I look for all routes from "A" to "B"
		Then there should be 0 routes
		When I look for the shortest route from "A" to "B"
		Then there should be no shortest route!

	Scenario: A route that needs backtracking
		Given a graph with "AB1 BC6 AC2"
		Then there should be 3 edges
		When the route is "ABC"
		Then the distance should be 7
		When the route is "AC"
		Then the distance should be 2
		When I look for all routes from "A" to "C"
		Then there should be 2 routes
		When I look for the shortest route from "A" to "C"
		Then the total distance should be 2
