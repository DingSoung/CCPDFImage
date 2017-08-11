![Release](https://img.shields.io/github/release/DingSoung/PDFImage.svg)
![Status](https://travis-ci.org/DingSoung/PDFImage.svg?branch=master)
![CocoaPods](https://img.shields.io/cocoapods/v/ModelCache.svg)
![Carthage](https://img.shields.io/badge/Carthage-compatible-yellow.svg?style=flat)
![Language](https://img.shields.io/badge/Swift-3.1-FFAC45.svg?style=flat)
![Platform](http://img.shields.io/badge/Platform-iOS-E9C2BD.svg?style=flat)
[![Donate](https://img.shields.io/badge/Donate-PayPal-9EA59D.svg)](paypal.me/DingSongwen)

### brief
a better way to set image for your app
convert PDF to Image

### why better
* much higher clearity then systen 2x or 3x
* save ipa size
* save memory size
* save network traffic
* faster to load image when use memory cache

### feature
* support custom NSBundle
* support memory cache
* support async progress

### Install

#### Carthage

add code below to your Cartfile and command `carthage update`

```swift
github "DingSoung/PDFImage" 
```
#### CocoaPod

add code below to your pod and command `pod update`

```swift
platform :ios, ‘8.0’
use_frameworks!
target 'AppStore' do
	pod	'PDFImage'
end
```

### Usage

```objective-c
[[PDFImage instance] asyncGetImageWithResource:@"Group" bundle:[NSBundle mainBundle] page:1 size:imageView.bounds.size mainQueueBlock:^(UIImage *image) {
    imageView.image = image;
}];
```

