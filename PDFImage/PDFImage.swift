//  Created by Songwen Ding on 4/14/16.
//  Copyright © 2016 DingSoung. All rights reserved.

import UIKit

@objcMembers
final public class PDFImage: NSObject {
    public static let instance = PDFImage()
    private override init() {
        super.init()
        self.useRamCache = true
    }

    deinit {
        _ramCache = nil;
    }

    private var _ramCache:NSCache<NSString, UIImage>?
    private var _useRamCache = false;
    public var useRamCache : Bool {
        set {
            _useRamCache = newValue;
            if newValue {
                if _ramCache == nil {
                    _ramCache = NSCache()
                }
            } else {
                _ramCache?.removeAllObjects()
            }
        }
        get {
            return _useRamCache;
        }
    }

    public final func image(resource: String, bundle: Bundle, page: Int, size: CGSize) -> UIImage? {
        guard size.width > 0 && size.height > 0 && page > 0 else {return nil;}
        guard let filePath = bundle.path(forResource: resource, ofType: "pdf") else {return nil;}
        let cacheName = self.cacheName(filePath: filePath, page: page, size: size)
        // use cache
        if let image = _ramCache?.object(forKey: cacheName as NSString) {return image}
        // render
        guard let pdf = CGPDFDocument(NSURL.fileURL(withPath: filePath) as CFURL) else {return nil}
        guard page > pdf.numberOfPages else { return nil }
        guard let pdfPage = pdf.page(at: page) else { return nil }
        guard let image = self.image(pdfPage: pdfPage, size: size) else { return nil}
        // cache
        if _useRamCache {_ramCache?.setObject(image, forKey: cacheName as NSString)}
        return image
    }

    /// struct cache name
    final private func cacheName(filePath: String, page: Int, size: CGSize) -> String {
        let fileParameter = "-\(page)-\(size.width)-\(size.height)"
        do {
            let fileAttrbutes = try FileManager.default.attributesOfItem(atPath: filePath)
            return filePath + fileParameter + "-\(String(describing: fileAttrbutes[FileAttributeKey.size]))-\(String(describing: fileAttrbutes[FileAttributeKey.modificationDate]))" + ".png"
        } catch {
            return filePath + fileParameter + ".png"
        }
    }

    /// render image
    final private func image(pdfPage: CGPDFPage, size: CGSize) -> UIImage? {
        let pageFrame = pdfPage.getBoxRect(CGPDFBox.cropBox)
        let screenScale = UIScreen.main.scale // pix per bitMap @2x or @3x
        guard let context = CGContext(data: nil,
                                      width: Int(size.width * screenScale),
                                      height: Int(size.height * screenScale),
                                      bitsPerComponent: 8,
                                      bytesPerRow: 0,
                                      space: CGColorSpaceCreateDeviceRGB(),
                                      bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
            else {return nil}
        context.scaleBy(x: screenScale, y: screenScale) // scale pix / bit map
        context.scaleBy(x: size.width / pageFrame.size.width, y: size.height / pageFrame.size.height )  // target size scale file
        context.translateBy(x: -pageFrame.origin.x, y: -pageFrame.origin.y) // transform
        context.drawPDFPage(pdfPage); // rendering pdf
        guard let imageRef = context.makeImage() else {
            return nil
        }
        return UIImage(cgImage: imageRef, scale: screenScale, orientation: UIImageOrientation.up)
    }
}













