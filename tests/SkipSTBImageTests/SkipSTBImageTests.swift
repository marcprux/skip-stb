// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
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
