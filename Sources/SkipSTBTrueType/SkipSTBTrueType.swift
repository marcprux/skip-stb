// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
import Foundation
import SkipFFI
#if !SKIP
import STBTrueType
#endif

/// `STBTrueTypeLibrary` is a Swift encapsulation of the embedded C library's functions and structures.
internal final class STBTrueTypeLibrary {
    /// The singleton library instance, registered using JNA to map the Kotlin functions to their native equivalents
    static let instance = registerNatives(STBTrueTypeLibrary(), frameworkName: "SkipSTBTrueType", libraryName: "stbtruetype")

    // Functions marked with "SKIP EXTERN" will eliminate the bodies and
    // mark the transpiled Kotlin functions as "extern",
    // which causes JNA to match them with the corresponding C functions
    // when `registerNatives` is called

    // Note: the Int8 types should be UInt8, but they don't exist on the JVM (and Kotlin's fake UInt8 types aren't understood by JNA)

//    /* SKIP EXTERN */ public func stbtt_vertex(x: Int16, y: Int16, cx: Int16, cy: Int16, cx1: Int16, cy1: Int16, type: Int8, padding: Int8) -> stbtt_vertex {
//        return STBTrueType.stbtt_vertex(x: x, y: y, cx: cx, cy: cy, cx1: cx1, cy1: cy1, type: UInt8(type), padding: UInt8(padding))
//    }
}

#if SKIP
// SKIP INSERT: @com.sun.jna.Structure.FieldOrder("x", "y", "cx", "cy", "cx1", "cy1", "type", "padding")
public final class stbtt_vertex : SkipFFIStructure {
    /* SKIP INSERT: @JvmField */ var x: Int16
    /* SKIP INSERT: @JvmField */ var y: Int16
    /* SKIP INSERT: @JvmField */ var cx: Int16
    /* SKIP INSERT: @JvmField */ var cy: Int16
    /* SKIP INSERT: @JvmField */ var cx1: Int16
    /* SKIP INSERT: @JvmField */ var cy1: Int16
    /* SKIP INSERT: @JvmField */ var type: Int8 // should be UInt8, but error: "JvmField cannot be applied to a property of a value class type"
    /* SKIP INSERT: @JvmField */ var padding: Int8

    init(x: Int16 = Int16(0), y: Int16 = Int16(0), cx: Int16 = Int16(0), cy: Int16 = Int16(0), cx1: Int16 = Int16(0), cy1: Int16 = Int16(0), type: Int8 = Int8(0), padding: Int8 = Int8(0)) {
        self.x = x
        self.y = y
        self.cx = cx
        self.cy = cy
        self.cx1 = cx1
        self.cy1 = cy1
        self.type = type
        self.padding = padding
    }
}

#endif
