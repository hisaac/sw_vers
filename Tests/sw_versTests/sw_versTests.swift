import XCTest
@testable import sw_vers

final class sw_versTests: XCTestCase {
	func testHelp() throws {
		try runAndAssertOutputEqual(argument: "--help")
	}

	func testProductName() throws {
		try runAndAssertOutputEqual(argument: "--productName")
	}

	func testProductVersion() throws {
		try runAndAssertOutputEqual(argument: "--productVersion")
	}

	func testProductVersionExtra() throws {
		try runAndAssertOutputEqual(argument: "--productVersionExtra")
	}

	func testBuildVersion() throws {
		try runAndAssertOutputEqual(argument: "--buildVersion")
	}

	func testNoArguments() throws {
		try runAndAssertOutputEqual(arguments: [])
	}

	func testInvalidArgument() throws {
		try runAndAssertOutputEqual(argument: "invalid")
	}

	func runAndAssertOutputEqual(
		argument: String = "",
		file: StaticString = #file,
		line: UInt = #line
	) throws {
		try runAndAssertOutputEqual(arguments: [argument], file: file, line: line)
	}

	func runAndAssertOutputEqual(
		arguments: [String] = [],
		file: StaticString = #file,
		line: UInt = #line
	) throws {
		let sw_versSwiftOutput = try sw_vers.run(arguments: arguments)
		let sw_versCOutput = try sw_versC.run(arguments: arguments)
		XCTAssertEqual(sw_versSwiftOutput, sw_versCOutput, file: file, line: line)
	}
}
