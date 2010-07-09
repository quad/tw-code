Feature: ThoughtWorks PROBLEM definition
	In order to provide a basic sanity check
	as I want a job at ThoughtWorks
	I want to ensure their sample test runs

	Background: 
		Given a graph with "AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7"

	Scenario: Problem 1 calculable
		When the route is "ABC"
		Then the distance should be 9

	Scenario: Problem 2 should be calculable
		When the route is "AD"
		Then the distance should be 5

	Scenario: Problem 3 should be calculable
		When the route is "ADC"
		Then the distance should be 13

	Scenario: Problem 4 should be calculable
		When the route is "AEBCD"
		Then the distance should be 22

	Scenario: Problem 5 should be calculable
		When the route is "AED"
		Then there should be no route!

	Scenario: Problem 6 should be calculable
		When I look for all routes from "C" to "C" with at most 3 stops
		Then there should be 2 routes
		Then those routes should be:
			| Routes |
			| CDC    |
			| CEBC   |

	Scenario: Problem 7 should be calculable
		When I look for all routes from "A" to "C" with exactly 4 stops
		Then there should be 3 routes
		Then those routes should be:
			| Routes |
			| ABCDC  |
			| ADCDC  |
			| ADEBC  |

	Scenario: Problem 8 should be calculable
		When I look for the shortest route from "A" to "C"
		Then the total distance should be 9

	Scenario: Problem 9 should be calculable
		When I look for the shortest route from "B" to "B"
		Then the total distance should be 9

	Scenario: Problem 10 should be calculable
		When I look for all routes from "C" to "C" with a distance of less than 30
		Then those routes should be:
			| Routes     |
			| CDC        |
			| CEBC       |
			| CEBCDC     |
			| CDCEBC     |
			| CDEBC      |
			| CEBCEBC    |
			| CEBCEBCEBC |

	Scenario: Program output should be calculable
		When I run the program with:
			"""
			Graph: AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7
			"""
		Then I should see:
			"""
			Output #1: 9
			Output #2: 5
			Output #3: 13
			Output #4: 22
			Output #5: NO SUCH ROUTE
			Output #6: 2
			Output #7: 3
			Output #8: 9
			Output #9: 9
			Output #10: 7
			"""
