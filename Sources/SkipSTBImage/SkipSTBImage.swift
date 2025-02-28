// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
import Foundation
import SkipFFI
#if !SKIP
import STBImage
#endif

/// `STBImageLibrary` is a Swift encapsulation of the embedded C library's functions and structures.
internal final class STBImageLibrary {
    /// The singleton library instance, registered using JNA to map the Kotlin functions to their native equivalents
    static let instance = registerNatives(STBImageLibrary(), frameworkName: "SkipSTBImage", libraryName: "stbimage")

    // Functions marked with "SKIP EXTERN" will eliminate the bodies and
    // mark the transpiled Kotlin functions as "extern",
    // which causes JNA to match them with the corresponding C functions
    // when `registerNatives` is called

    /* SKIP EXTERN */ public func stbi_convert_iphone_png_to_rgb(_ i: Int32) {
        return STBImage.stbi_convert_iphone_png_to_rgb(i)
    }

}
