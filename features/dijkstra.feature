Feature: Dijkstra's algorithm
	In order to not slip up
	I want to include test data from some net sources

	Scenario: Literate Program's source
		Given a graph with "BN250-NB250  MN260-NM260  TN150-NT150  NG550-GN550  MG470-GM470  TP680-PT680  TG700-GT700  GP540-PG540  GL64-LG64  LP536-PL536"
		When I look for the shortest route from "B" to "L"
		Then the total distance should be 864
		When I look for the shortest route from "L" to "B"
		Then the total distance should be 864

	Scenario: Renaud source
		Given a graph with "AB4 BD2 AC4 CD1"
		When I look for the shortest route from "A" to "D"
		Then the total distance should be 5
		When I look for the shortest route from "D" to "C"
		Then there should be no shortest route!
		When I look for the shortest route from "C" to "A"
		Then there should be no shortest route!

	Scenario: Schwarcz test
		Given a graph with "BE3 AC7 AE9 AD8 EF1 AB2"
		When I look for the shortest route from "A" to "F"
		Then the total distance should be 6
		When I look for the shortest route from "F" to "A"
		Then there should be no shortest route!

	Scenario: Engine3
		Given a graph with "CD5 AC2 BC3 CB1 CA2 AB4 BD1"
		When I look for the shortest route from "A" to "D"
		Then the total distance should be 4

		Given a graph with "BC3 ED2 BD1 AC2 AB4 CD5 AE1 CA2 CB1"
		When I look for the shortest route from "A" to "D"
		Then the total distance should be 3
