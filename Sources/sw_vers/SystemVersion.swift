import Foundation

struct SystemVersion {
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
