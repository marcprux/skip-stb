// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import XCTest
import Foundation
import OSLog
@testable import SkipSTBImage

fileprivate let logger: Logger = Logger(subsystem: "test", category: "SkipSTBImageTests")

fileprivate let lib: STBImageLibrary = STBImageLibrary.instance

final class SkipSTBImageTests: XCTestCase {
    func testSkipSTBImage() throws {
        lib.stbi_convert_iphone_png_to_rgb(1)
    }
}
