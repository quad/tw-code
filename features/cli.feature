Feature: Command-line front-end input and output
	In order to give a convenient interface to supply test data
	I want to do test runs.

	Scenario: Empty graph should work
		When I run the program with:
			"""
			Graph:
			"""
		Then I should see:
			"""
			Output #1: NO SUCH ROUTE
			Output #2: NO SUCH ROUTE
			Output #3: NO SUCH ROUTE
			Output #4: NO SUCH ROUTE
			Output #5: NO SUCH ROUTE
			Output #6: 0
			Output #7: 0
			Output #8: NO SUCH ROUTE
			Output #9: NO SUCH ROUTE
			Output #10: 0
			"""
		And the program should have exited normally

	Scenario: Multiple graps in a single run
		When I run the program with:
			"""
			Graph: OZ4
			Graph: AB2 BC2
			"""
		Then I should see:
			"""
			Output #1: NO SUCH ROUTE
			Output #2: NO SUCH ROUTE
			Output #3: NO SUCH ROUTE
			Output #4: NO SUCH ROUTE
			Output #5: NO SUCH ROUTE
			Output #6: 0
			Output #7: 0
			Output #8: NO SUCH ROUTE
			Output #9: NO SUCH ROUTE
			Output #10: 0
			Output #1: 4
			Output #2: NO SUCH ROUTE
			Output #3: NO SUCH ROUTE
			Output #4: NO SUCH ROUTE
			Output #5: NO SUCH ROUTE
			Output #6: 0
			Output #7: 0
			Output #8: 4
			Output #9: NO SUCH ROUTE
			Output #10: 0
			"""

	Scenario: Invalid inputs error out
		When I run the program with:
			"""
			Graph: ZZ1
			"""
		Then I should see:
			"""
			"""
		And the program should have errored out

		When I run the program with:
			"""
			Xyzzy
			"""
		Then I should see:
			"""
			"""
		And the program should have exited normally

	Scenario: Question 1 and 8
		When I run the program with:
			"""
			Graph: AB1 BC5 
			"""
		Then I should see:
			"""
			Output #1: 6
			Output #2: NO SUCH ROUTE
			Output #3: NO SUCH ROUTE
			Output #4: NO SUCH ROUTE
			Output #5: NO SUCH ROUTE
			Output #6: 0
			Output #7: 0
			Output #8: 6
			Output #9: NO SUCH ROUTE
			Output #10: 0
			"""
		And the program should have exited normally

	Scenario: Question 2
		When I run the program with:
			"""
			Graph: AD87
			"""
		Then I should see:
			"""
			Output #1: NO SUCH ROUTE
			Output #2: 87
			Output #3: NO SUCH ROUTE
			Output #4: NO SUCH ROUTE
			Output #5: NO SUCH ROUTE
			Output #6: 0
			Output #7: 0
			Output #8: NO SUCH ROUTE
			Output #9: NO SUCH ROUTE
			Output #10: 0
			"""
		And the program should have exited normally

	Scenario: Question 2, 3 and 8
		When I run the program with:
			"""
			Graph: AD0 DC10
			"""
		Then I should see:
			"""
			Output #1: NO SUCH ROUTE
			Output #2: 0
			Output #3: 10
			Output #4: NO SUCH ROUTE
			Output #5: NO SUCH ROUTE
			Output #6: 0
			Output #7: 0
			Output #8: 10
			Output #9: NO SUCH ROUTE
			Output #10: 0
			"""
		And the program should have exited normally

	Scenario: Question 4 and 8
		When I run the program with:
			"""
			Graph: AE0 EB2 BC0 CD10
			"""
		Then I should see:
			"""
			Output #1: NO SUCH ROUTE
			Output #2: NO SUCH ROUTE
			Output #3: NO SUCH ROUTE
			Output #4: 12
			Output #5: NO SUCH ROUTE
			Output #6: 0
			Output #7: 0
			Output #8: 2
			Output #9: NO SUCH ROUTE
			Output #10: 0
			"""
		And the program should have exited normally

	Scenario: Question 5
		When I run the program with:
			"""
			Graph: AE0 ED10
			"""
		Then I should see:
			"""
			Output #1: NO SUCH ROUTE
			Output #2: NO SUCH ROUTE
			Output #3: NO SUCH ROUTE
			Output #4: NO SUCH ROUTE
			Output #5: 10
			Output #6: 0
			Output #7: 0
			Output #8: NO SUCH ROUTE
			Output #9: NO SUCH ROUTE
			Output #10: 0
			"""
		And the program should have exited normally

	Scenario: Question 6
		When I run the program with:
			"""
			Graph: QC0 CQ30
			"""
		Then I should see:
			"""
			Output #1: NO SUCH ROUTE
			Output #2: NO SUCH ROUTE
			Output #3: NO SUCH ROUTE
			Output #4: NO SUCH ROUTE
			Output #5: NO SUCH ROUTE
			Output #6: 1
			Output #7: 0
			Output #8: NO SUCH ROUTE
			Output #9: NO SUCH ROUTE
			Output #10: 0
			"""
		And the program should have exited normally

	Scenario: Question 7 and 8
		When I run the program with:
			"""
			Graph: AQ1 QR0 RS0 SC1
			"""
		Then I should see:
			"""
			Output #1: NO SUCH ROUTE
			Output #2: NO SUCH ROUTE
			Output #3: NO SUCH ROUTE
			Output #4: NO SUCH ROUTE
			Output #5: NO SUCH ROUTE
			Output #6: 0
			Output #7: 1
			Output #8: 2
			Output #9: NO SUCH ROUTE
			Output #10: 0
			"""
		And the program should have exited normally

	Scenario: Question 8
		When I run the program with:
			"""
			Graph: AC30 AQ15 QC1 AZ3 ZC2
			"""
		Then I should see:
			"""
			Output #1: NO SUCH ROUTE
			Output #2: NO SUCH ROUTE
			Output #3: NO SUCH ROUTE
			Output #4: NO SUCH ROUTE
			Output #5: NO SUCH ROUTE
			Output #6: 0
			Output #7: 0
			Output #8: 5
			Output #9: NO SUCH ROUTE
			Output #10: 0
			"""
		And the program should have exited normally

	Scenario: Question 9
		When I run the program with:
			"""
			Graph: BZ30 BY15 YB5 BX10 XJ0 JB0
			"""
		Then I should see:
			"""
			Output #1: NO SUCH ROUTE
			Output #2: NO SUCH ROUTE
			Output #3: NO SUCH ROUTE
			Output #4: NO SUCH ROUTE
			Output #5: NO SUCH ROUTE
			Output #6: 0
			Output #7: 0
			Output #8: NO SUCH ROUTE
			Output #9: 10
			Output #10: 0
			"""
		And the program should have exited normally

	Scenario: Question 10
		When I run the program with:
			"""
			Graph: CZ3 ZC2
			"""
		Then I should see:
			"""
			Output #1: NO SUCH ROUTE
			Output #2: NO SUCH ROUTE
			Output #3: NO SUCH ROUTE
			Output #4: NO SUCH ROUTE
			Output #5: NO SUCH ROUTE
			Output #6: 1
			Output #7: 0
			Output #8: NO SUCH ROUTE
			Output #9: NO SUCH ROUTE
			Output #10: 5
			"""
		And the program should have exited normally
