//
//  CCPDFImage.m
//  MCompass
//
//  Created by D.Alex on 11/19/15.
//  Copyright © 2015 haizhi. All rights reserved.
//

#import "CCPDFImage.h"

@implementation CCPDFImage {
    dispatch_queue_t queue;
}

+ (id)instance {
    static CCPDFImage *sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        self->queue = dispatch_queue_create("com.dispatch.renderIntoContext", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


-(void) generateImageWithPDF:(NSString *)url size:(CGSize)size pageIndex:(NSUInteger)pageIndex success: (void (^)(UIImage * image))success fail: (void (^)(NSError * error))fail {
    
    dispatch_sync(self->queue, ^{
        
        NSString * path = [[ NSBundle mainBundle ] pathForResource:url ofType:@"pdf" ];
        NSURL * URL =  [NSURL fileURLWithPath:path];
        CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL( (__bridge CFURLRef) URL);
        if (pageIndex < 1 || pageIndex > CGPDFDocumentGetNumberOfPages(pdf)) {
            fail([[NSError alloc] initWithDomain:@"out of range" code:-1 userInfo:nil]);
        }
        
        //get page and frame
        CGPDFPageRef page = CGPDFDocumentGetPage(pdf, pageIndex);
        CGRect pageFrame = CGPDFPageGetBoxRect( page, kCGPDFCropBox );
        
        
        CGFloat screenScale = ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) ? [[[UIScreen mainScreen] valueForKey:@"scale"] floatValue] : 1.0f;
        CGImageRef imageRef = nil;
#if true
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(NULL, size.width * screenScale, size.height * screenScale, 8, 0, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
        
        //scale contex
        CGContextScaleCTM(context, screenScale, screenScale);
        CGContextScaleCTM( context, size.width / pageFrame.size.width, size.height / pageFrame.size.height );
        CGContextTranslateCTM( context, -pageFrame.origin.x, -pageFrame.origin.y );
        // rendering pdf
        CGContextDrawPDFPage( context, page );
        
        imageRef = CGBitmapContextCreateImage(context);
        
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);
#else
        //	Draw the page (flipped)
        UIGraphicsBeginPDFPageWithInfo(pageFrame, nil);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        CGContextScaleCTM(ctx, 1, -1);
        CGContextTranslateCTM(ctx, 0, -pageFrame.size.height);
        CGContextDrawPDFPage(ctx, page);
        
        imageRef = CGBitmapContextCreateImage(ctx);
        CGContextRestoreGState(ctx);
#endif
        if (imageRef == nil) {
            fail([[NSError alloc] initWithDomain:@"url wrong" code:-1 userInfo:nil]);
        } else {
            UIImage * image = [[UIImage alloc] initWithCGImage:imageRef scale:screenScale orientation:UIImageOrientationUp];
            success(image);
        }
        CGPDFDocumentRelease( pdf );
        CGImageRelease(imageRef);
    });
}

@end
