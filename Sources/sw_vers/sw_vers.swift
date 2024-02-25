import Foundation

@main
final class sw_vers {
	static func main() throws {
		let usage = "Usage: sw_vers [--help|--productName|--productVersion|--productVersionExtra|--buildVersion]"

		let arguments = sw_versArgument.process(ProcessInfo.processInfo.arguments)

		let systemVersion = try SystemVersion()

		guard arguments.isEmpty == false else {
			let output = """
				ProductName:    \(systemVersion.productName)
				ProductVersion: \(systemVersion.productVersion)
				BuildVersion:   \(systemVersion.productBuildVersion)
				"""
			print(output)
			return
		}

		switch arguments {
			case _ where arguments.contains(.productName):
				print(systemVersion.productName)
				return
			case _ where arguments.contains(.productVersion):
				print(systemVersion.productVersion)
				return
			case _ where arguments.contains(.productVersionExtra):
				// do nothing
				print()
			case _ where arguments.contains(.buildVersion):
				print(systemVersion.productBuildVersion)
			default:
				print(usage)
		}
	}

	enum sw_versArgument: String, CaseIterable {
		case help
		case productName
		case productVersion
		case productVersionExtra
		case buildVersion

		init?(rawValue: String) {
			for argument in sw_versArgument.allCases {
				if rawValue.localizedLowercase.contains(argument.rawValue.localizedLowercase) {
					self = argument
					return
				}
			}
			return nil
		}

		static func process(_ arguments: [String]) -> [sw_versArgument] {
			arguments.compactMap { sw_versArgument(rawValue: $0) }
		}
	}
}

private struct SystemVersion {
	let buildID: String
	let productBuildVersion: String
	let productCopyright: String
	let productName: String
	let productUserVisibleVersion: String
	let productVersion: String
	let iOSSupportVersion: String

	init(
		buildID: String,
		productBuildVersion: String,
		productCopyright: String,
		productName: String,
		productUserVisibleVersion: String,
		productVersion: String,
		iOSSupportVersion: String
	) {
		self.buildID = buildID
		self.productBuildVersion = productBuildVersion
		self.productCopyright = productCopyright
		self.productName = productName
		self.productUserVisibleVersion = productUserVisibleVersion
		self.productVersion = productVersion
		self.iOSSupportVersion = iOSSupportVersion
	}
}

extension SystemVersion: Decodable {
	enum CodingKeys: String, CodingKey {
		case buildID = "BuildID"
		case productBuildVersion = "ProductBuildVersion"
		case productCopyright = "ProductCopyright"
		case productName = "ProductName"
		case productUserVisibleVersion = "ProductUserVisibleVersion"
		case productVersion = "ProductVersion"
		case iOSSupportVersion = "iOSSupportVersion"
	}

	init() throws {
		let plistPath = "/System/Library/CoreServices/SystemVersion.plist"
		let plistURL: URL
		if #available(macOS 13.0, *) {
			plistURL = URL(filePath: plistPath)
		} else {
			plistURL = URL(fileURLWithPath: plistPath)
		}
		let plistData = try Data(contentsOf: plistURL)
		self = try PropertyListDecoder().decode(SystemVersion.self, from: plistData)
	}
}
