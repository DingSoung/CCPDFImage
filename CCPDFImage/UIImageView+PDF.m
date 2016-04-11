//
//  ImageView+PDF.m
//  MCompass
//
//  Created by D.Alex on 11/19/15.
//  Copyright © 2015 haizhi. All rights reserved.
//

#import "UIImageView+PDF.h"
#import "CCPDFImage.h"

@implementation  UIImageView( PDF )

- (void) setimageVithPDF:(NSString *)url size:(CGSize)size pageIndex:(NSUInteger)pageIndex success: (void (^)(UIImage * image))success fail: (void (^)(NSError * error))fail {
    
    [[CCPDFImage instance] generateImageWithPDF:url size:size pageIndex:pageIndex success:^(UIImage *image) {
        self.image = image;
        success(image);
    } fail:fail];
}

@end
