// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
import XCTest
import Foundation
import OSLog
@testable import SkipSTBTrueType

fileprivate let logger: Logger = Logger(subsystem: "test", category: "SkipSTBTrueTypeTests")

fileprivate let lib: STBTrueTypeLibrary = STBTrueTypeLibrary.instance

final class SkipSTBTrueTypeTests: XCTestCase {
    func testSkipSTBTrueType() throws {
        //let vertex = lib.stbtt_vertex(x: Int16(0), y: Int16(0), cx: Int16(0), cy: Int16(0), cx1: Int16(0), cy1: Int16(0), type: Int8(0), padding: Int8(0))
    }
}
