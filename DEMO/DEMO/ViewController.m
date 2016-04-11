//
//  ViewController.m
//  DEMO
//
//  Created by Alex D. on 4/11/16.
//  Copyright © 2016 ifnil. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+PDF.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageL1;
@property (weak, nonatomic) IBOutlet UIImageView *imageL2;
@property (weak, nonatomic) IBOutlet UIImageView *imageL3;
@property (weak, nonatomic) IBOutlet UIImageView *imageL4;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSArray *imageViews = @[self.imageL1, self.imageL2, self.imageL3, self.imageL4];
    for (UIImageView *imageView in imageViews) {
        if ([imageView isKindOfClass:[UIImageView class]]) {
            [imageView setimageVithPDF:@"Group" size:imageView.bounds.size pageIndex:1 success:^(UIImage *image) {
                NSLog(@"%@", image);
            } fail:^(NSError *error) {
                NSLog(@"%@", error.domain);
            }];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
