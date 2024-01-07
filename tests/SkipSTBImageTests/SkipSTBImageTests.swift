// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import XCTest
import Foundation
import OSLog
@testable import SkipSTBImage

fileprivate let logger: Logger = Logger(subsystem: "test", category: "SkipCDemoTests")

fileprivate let lib: STBImageLibrary = STBImageLibrary.instance

final class SkipCDemoTests: XCTestCase {
    func testSkipSTBImage() throws {
        XCTAssertEqual(123, lib.demo_number())
        XCTAssertEqual("Hello Skip!", lib.demo_string())
        XCTAssertEqual(105.95723590826853, lib.demo_compute(n: 1_000_000, a: 2.5, b: 3.5))

        lib.stbi_convert_iphone_png_to_rgb(1)
    }
}
