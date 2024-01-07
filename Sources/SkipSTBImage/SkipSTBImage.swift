// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import Foundation
import SkipFFI
#if !SKIP
import STBImage
#endif

/// `STBImageLibrary` is a Swift encapsulation of the embedded C library's functions and structures.
internal final class STBImageLibrary {
    /// The singleton library instance, registered using JNA to map the Kotlin functions to their native equivalents
    static let instance = registerNatives(STBImageLibrary(), frameworkName: "STBImage", libraryName: "stbimage")

    // Functions marked with "SKIP EXTERN" will eliminate the bodies and
    // mark the transpiled Kotlin functions as "extern",
    // which causes JNA to match them with the corresponding C functions
    // when `registerNatives` is called

    /* SKIP EXTERN */ public func stbi_convert_iphone_png_to_rgb(_ i: Int32) {
        return STBImage.stbi_convert_iphone_png_to_rgb(i)
    }

    /* SKIP EXTERN */ public func demo_number() -> Int32 {
        return STBImage.demo_number()
    }

    /* SKIP EXTERN */ public func demo_string() -> String {
        // JNA will automatically convert the Pointer to a Java String
        return String(cString: STBImage.demo_string())
    }

    /* SKIP EXTERN */ public func demo_compute(n: Int32, a: Double, b: Double) -> Double {
        return STBImage.demo_compute(n, a, b)
    }
}
