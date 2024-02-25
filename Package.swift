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
		.testTarget(
			name: "sw_versTests",
			dependencies: ["sw_vers"]
		),
	]
)
