graphhopper-ios
===============

graphhopper-ios wraps [graphhopper](https://github.com/graphhopper/graphhopper/) 
and creates the `libgraphhopper.a` library to be used on iOS and OS X. 
(Right now MacOS does not work) 

It uses [j2objc](https://github.com/google/j2objc) to translate the .java sources 
into Objective-C.

> **Disclaimer:** This is experimental so treat it accordingly. [Feel free to help](CONTRIBUTING.md) in any way.


## Prerequistes
JDK 8 (Yes, jts source needs JDK 8), recommended is AdoptOpenJDK8
Maven 
XCode 11.4+

## Getting Started

To get started run the following commands in Terminal:

```sh
git clone --recursive https://github.com/graphhopper/graphhopper-ios.git
cd graphhopper-ios
make class.list
make optimize    # optionally
make translate
open graphhopper-ios-sample/graphhopper-ios-sample.xcodeproj
```

Running `make optimize` optionally before `make translate` will use ProGuard to remove dead code from translated sources. Project provides 2 config files: `proguard-full.cfg` and `proguard-slim.cfg`. `Full` config will create a binary with all graphhopper classes, where `silm` config will create a binary with just the classes necessary by the project.

Switch to graphhopper project build
Switch to graphhoppper-ios-sample -> build (two times, first time usually gives error)
 

## Old (obsolete?) info

This will clone the repository and all its submodules. Now you are ready 
to use GraphHopper on iOS or OS X.

(For now you need to use  https://github.com/oflebbe/graphhopper/ branch ios_compat ) 
Beware there are unresolved issues


You have two options:

1. Head over to [graphhopper-ios-sample](graphhopper-ios-sample) 
and follow the instructions there. This is the easiest way to get started.

2. (untested) Manually add *graphhopper.xcodeproj* to your Xcode project. See the Usage section below.
 
## Community

Feel free to raise problems or questions in [our forum](https://discuss.graphhopper.com/c/graphhopper/graphhopper-ios-and-android).

## Usage

You can either add *graphhopper.xcodeproj* to your project and let Xcode compile the library 
or you can compile it from the Terminal and then add the library and sources
to your Xcode project.

### Xcode

To configure your project to use *graphhopper.xcodeproj* follow the steps below:

- Drag&drop *graphhopper.xcodeproj* into your project (or use the menu File -> Add Files to...)
- Expand graphhopper.xcodeproj and drag&drop the **Translations** and **Libraries** 
groups into your project (make sure you check "Create folder references" and have 
your target selected in "Add to targets:")
- In the Build Settings of your project:
    - add `-ObjC` to your target's Other Linker Flags
    - add `{path-to-graphhopper-ios}/j2objc/include` and `{path-to-graphhopper-ios}/src` 
    to your target's User Header Search Paths
- In the Build Phases of your project:
    - in Target Dependencies add the **graphhopper** target
    - in Link Binary With Libraries add **Security.framework** (to support secure hash generation), 
**libz.dylib** (needed to support java.util.zip) and **libicucore.dylib** (to support java.text, 
which is a dependency introduced by [j2objc 0.9.5](https://github.com/google/j2objc/releases/tag/0.9.5))

You're now ready to use GraphHopper on iOS and OS X.

> You are responsible for importing graph data. For an example check out 
[graphhopper-ios-sample](graphhopper-ios-sample).

### Terminal

Alternatively, you can translate and compile the library by invoking `make` 
in the Terminal. You can then link the library 
`graphhopper-ios/build/libgraphhopper.a` and it's header files at `graphhopper-ios/src` 
manually into your project. For all the other configurations see the Xcode section above.

> This method compiles the library for the following architectures: 
macosx, simulator, iphoneos, so using Xcode instead is recommended.

## Example

![iPhone-offline-routing](screenshots/iPhone-offline-routing.gif)

## Requirements

* iOS 11.0+ or OS X 10.10 (it might work on older versions but haven't tested)
* JDK 1.8 or higher
* Xcode 11.0 or higher

## Troubleshooting

If you run into problems, you can try one of the following:

* if using Xcode, try cleaning up the project (Product -> Clean)
* if using the Terminal, you can use one of these 2 cleanup commands:
  * `make clean` - will delete the /graphhopper-ios/build directory
  * `make cleanall` - if the first one didn't do it, this will delete everything 
related to the build process (you then need to run `make class.list`)

## Refresh Code

The dependencies j2objc, hppc and jts should be downloaded automatically if not present. You can force to reload by removing them: 

```rm -rf dependencies/hppc dependencies/jts j2objc
make dependencies/hppc dependencies/jts j2objc
```

