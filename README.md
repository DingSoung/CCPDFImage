 [![Language](https://img.shields.io/badge/Swift-3.1-FFAC45.svg?style=flat)](https://swift.org/)
[![Release](https://img.shields.io/github/release/DingSoung/PDFImage.svg)](https://github.com/DingSoung)
[![Status](https://travis-ci.org/DingSoung/PDFImage.svg?branch=master)](https://travis-ci.org/DingSoung/PDFImage)
[![Platform](http://img.shields.io/badge/platform-iOS-E9C2BD.svg?style=flat)](https://developer.apple.com)
[![Carthage](https://img.shields.io/badge/carthage-Compatible-yellow.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/DingSoung/PDFImage/master/LICENSE.md)
[![Donate](https://img.shields.io/badge/donate-Alipay-00BBEE.svg)](https://qr.alipay.com/paipai/downloadQrCodeImg.resource?code=aex06042bir8odhpd1fgs00)

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


### Usage

add code below to your Cartfile and command `carthage update`

```
github "DingSoung/PDFImage" 
```

```objective-c
    [[PDFImage instance] asyncGetImageWithResource:@"Group" bundle:[NSBundle mainBundle] page:1 size:imageView.bounds.size mainQueueBlock:^(UIImage *image) {
        imageView.image = image;
    }];
```

