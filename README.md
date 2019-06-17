# WaveformView iOS

A UIView subclass, in Swift, that reproduces the waveform effect seen in Siri on iOS 7 and 8.

Originally a Swift and iOS port of [SISinusWaveView](https://github.com/raffael/SISinusWaveView) that also removed the requirement of `EZAudio`. There is also a [WaveformView for macOS](https://github.com/jyunderwood/WaveformView-macOS) that shares most of the same code. This project includes a simple demo application but it's also used in the example application [Talkboy for iOS](https://github.com/jyunderwood/Talkboy-iOS).

![Talkboy Demo](https://raw.githubusercontent.com/jyunderwood/Talkboy-iOS/master/talkboy-demo.gif)

## Install via Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate WaveformView into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "jyunderwood/WaveformView-iOS" ~> 2.0
```

Then follow the [iOS building instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos) in the Carthage README.

## Change Log

- __2.0.5__
  - Swift 5 compatibility
  - SPM compatibility
  - Example project suppression

- __2.0.4__
  - Swift 4 compatibility
- __2.0.3__
  - Remove 10.0 as the deployment target
- __2.0.2__
  - Framework scheme is now shared for Carthage support
- __2.0.1__
  - Remove unneeded get of current context within the wave loop
- __2.0__
  - Updated for Swift 3.0
  - Now a proper iOS framework
  - Includes a simplified example application
  - Renamed from SiriWaveformView to WaveformView
- __1.2__
  - Updated for Swift 2.2
- __1.0__
  - Initial release
