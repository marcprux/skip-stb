# SkipSTB

This is a [Skip](https://skip.tools) Swift/Kotlin library project providing modules for the https://github.com/nothings/stb project, which contains a number of portable single-file C header utility libraries.

The project utilizes Swift's built-in C integration on the Swift side, and takes advantage of gradle's support for building with the Android NDK using the cmake build tool on the Kotlin side.

The C code is called from the transpiled Kotlin using Java Native Access (JNA). A JNA direct mapping class `SkipSTBImage.swift` contains the library's functions, marked with `SKIP EXTERN` to cause the Skip transpiler to annotate the functions so JNA lines them up with the equivalent C functions.

## Implementation Details

Running `swift test` will run the Swift tests as well as the transpiled Kotlin tests against the native library's declared functions.

The `STBImage` Swift target builds a `SkipCDemo.framework` for Xcode or `libSkipCDemo.dylib` for SwiftPM. These libraries are built for the host system (macOS, either ARM or Intel), and when testing the `SkipCDemoTests` target, the correct local shared library is linked, and so the Robolectric JVM tests use the same shared library that is used by the Swift tests.

When building and testing for Android (either the emulator or device), the generated gradle contains the `externalNativeBuild` clause, directing it to use the `CMakeLists.txt` to build the native libraries for each of the supported Android NDK targets. The resulting `STBImage.aar` archive will look something like:

```plaintext
classes.dex
lib/arm64-v8a/libclibrary.so
lib/armeabi-v7a/libclibrary.so
lib/x86/libclibrary.so
lib/x86_64/libclibrary.so
AndroidManifest.xml
resources.arsc
```

## Project Structure

The target definition for a native target in the `Package.swift` file must contain only
`.c` and `.cpp` source files; it is not permitted to mix in `.swift` files.
In addition, the target containing the native libraries must declare a `publicHeadersPath`
and add the `skipstone` plugin in order for Skip to generate gradle build for the native module.


```swift
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "skip-stb",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "SkipSTBImage", type: .dynamic, targets: ["SkipSTBImage"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "0.7.40"),
        .package(url: "https://source.skip.tools/skip-foundation.git", from: "0.0.0"),
        .package(url: "https://source.skip.tools/skip-ffi.git", from: "0.0.0")
    ],
    targets: [
        .target(name: "SkipSTBImage", dependencies: [
            "STBImage",
            .product(name: "SkipFoundation", package: "skip-foundation"),
            .product(name: "SkipFFI", package: "skip-ffi")
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),

        .testTarget(name: "SkipSTBImageTests", dependencies: [
            "SkipSTBImage",
            .product(name: "SkipTest", package: "skip")
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),

        .target(name: "STBImage", sources: ["src"], cSettings: [
            .define("SKIP_BUILD_NDK") // needed for Skip to add native gradle build support
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)

```

## Building

Building the module requires that Skip be installed using 
[Homebrew](https://brew.sh) with `brew install skiptools/skip/skip`.
This will also install the necessary build prerequisites:
Kotlin, Gradle, and the Android build tools.

## Testing

The module can be tested using the standard `swift test` command
or by running the test target for the macOS destination in Xcode,
which will run the Swift tests as well as the transpiled
Kotlin JUnit tests in the Robolectric Android simulation environment.

Parity testing can be performed with `skip test`,
which will output a table of the test results for both platforms.


## About STB 

single-file public domain (or MIT licensed) libraries for C/C++

# This project discusses security-relevant bugs in public in Github Issues and Pull Requests, and it may take significant time for security fixes to be implemented or merged. If this poses an unreasonable risk to your project, do not use stb libraries.

Noteworthy:

* image loader: [stb_image.h](stb_image.h)
* image writer: [stb_image_write.h](stb_image_write.h)
* image resizer: [stb_image_resize2.h](stb_image_resize2.h)
* font text rasterizer: [stb_truetype.h](stb_truetype.h)
* typesafe containers: [stb_ds.h](stb_ds.h)

Most libraries by stb, except: stb_dxt by Fabian "ryg" Giesen, original stb_image_resize
by Jorge L. "VinoBS" Rodriguez, and stb_image_resize2 and stb_sprintf by Jeff Roberts.

<a name="stb_libs"></a>

library    | lastest version | category | LoC | description
--------------------- | ---- | -------- | --- | --------------------------------
**[stb_vorbis.c](stb_vorbis.c)** | 1.22 | audio | 5584 | decode ogg vorbis files from file/memory to float/16-bit signed output
**[stb_hexwave.h](stb_hexwave.h)** | 0.5 | audio | 680 | audio waveform synthesizer
**[stb_image.h](stb_image.h)** | 2.29 | graphics | 7985 | image loading/decoding from file/memory: JPG, PNG, TGA, BMP, PSD, GIF, HDR, PIC
**[stb_truetype.h](stb_truetype.h)** | 1.26 | graphics | 5077 | parse, decode, and rasterize characters from truetype fonts
**[stb_image_write.h](stb_image_write.h)** | 1.16 | graphics | 1724 | image writing to disk: PNG, TGA, BMP
**[stb_image_resize2.h](stb_image_resize2.h)** | 2.04 | graphics | 10325 | resize images larger/smaller with good quality
**[stb_rect_pack.h](stb_rect_pack.h)** | 1.01 | graphics | 623 | simple 2D rectangle packer with decent quality
**[stb_perlin.h](stb_perlin.h)** | 0.5 | graphics | 428 | perlin's revised simplex noise w/ different seeds
**[stb_ds.h](stb_ds.h)** | 0.67 | utility | 1895 | typesafe dynamic array and hash tables for C, will compile in C++
**[stb_sprintf.h](stb_sprintf.h)** | 1.10 | utility | 1906 | fast sprintf, snprintf for C/C++
**[stb_textedit.h](stb_textedit.h)** | 1.14 | user&nbsp;interface | 1429 | guts of a text editor for games etc implementing them from scratch
**[stb_voxel_render.h](stb_voxel_render.h)** | 0.89 | 3D&nbsp;graphics | 3807 | Minecraft-esque voxel rendering "engine" with many more features
**[stb_dxt.h](stb_dxt.h)** | 1.12 | 3D&nbsp;graphics | 719 | Fabian "ryg" Giesen's real-time DXT compressor
**[stb_easy_font.h](stb_easy_font.h)** | 1.1 | 3D&nbsp;graphics | 305 | quick-and-dirty easy-to-deploy bitmap font for printing frame rate, etc
**[stb_tilemap_editor.h](stb_tilemap_editor.h)** | 0.42 | game&nbsp;dev | 4187 | embeddable tilemap editor
**[stb_herringbone_wa...](stb_herringbone_wang_tile.h)** | 0.7 | game&nbsp;dev | 1221 | herringbone Wang tile map generator
**[stb_c_lexer.h](stb_c_lexer.h)** | 0.12 | parsing | 940 | simplify writing parsers for C-like languages
**[stb_divide.h](stb_divide.h)** | 0.94 | math | 433 | more useful 32-bit modulus e.g. "euclidean divide"
**[stb_connected_comp...](stb_connected_components.h)** | 0.96 | misc | 1049 | incrementally compute reachability on grids
**[stb_leakcheck.h](stb_leakcheck.h)** | 0.6 | misc | 194 | quick-and-dirty malloc/free leak-checking
**[stb_include.h](stb_include.h)** | 0.02 | misc | 295 | implement recursive #include support, particularly for GLSL

Total libraries: 21
Total lines of C code: 50806
