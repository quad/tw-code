Feature: Graph definition parsing
	In order to accept data of varying levels of quality
	I want to ensure the graph definition parser can handle some odd cases.

	Scenario: Empty definition
		Given a graph with ""
		Then there should be 0 edges

	Scenario: Distance-less definition
		Given a bad graph with "FG"
		Then an ArgumentError of "'FG' not in [A-Z][A-Z][0-9] edge format" should be thrown

	Scenario: A single vertex definition
		Given a bad graph with "F2"
		Then an ArgumentError of "'F2' not in [A-Z][A-Z][0-9] edge format" should be thrown

	Scenario: A single character definition
		Given a bad graph with "F"
		Then an ArgumentError of "'F' not in [A-Z][A-Z][0-9] edge format" should be thrown

		Given a bad graph with "2"
		Then an ArgumentError of "'2' not in [A-Z][A-Z][0-9] edge format" should be thrown

	Scenario: Definition with lowercase letters
		Given a bad graph with "aa12"
		Then an ArgumentError of "'aa12' not in [A-Z][A-Z][0-9] edge format" should be thrown

	Scenario: Trash characters in the definitions
		Given a graph with "FB2-CD9, ZA7}{#${!}@{$#%>#$<''KB5"
		Then there should be edges:
			| Edges    |
			| FB2      |
			| CD9      |
			| ZA7      |
			| KB5	   |

		Given a graph with "98hsFB2kjh21"
		Then there should be edges:
			| Edges |
			| FB2   |
