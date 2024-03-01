// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "sw_vers",
	platforms: [.macOS(.v10_13)],
	products: [
		.executable(
			name: "sw_vers",
			targets: ["sw_vers"]
		),
	],
	targets: [
		.executableTarget(
			name: "sw_vers"
		),

		// I wanted to name this target `sw_versTests` to conform to the pattern,
		// but Xcode throws a weird warning saying the underscore is invalid:
		//
		// > Process empty-sw_versTests.plist
		// > invalid character in Bundle Identifier. This string must be a uniform type identifier (UTI) that contains only alphanumeric (A-Z,a-z,0-9), hyphen (-), and period (.) characters.
		.testTarget(
			name: "swVersTests",
			dependencies: ["sw_vers"]
		),
	]
)
