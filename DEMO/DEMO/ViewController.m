//
//  ViewController.m
//  DEMO
//
//  Created by Songwen Ding on 6/30/16.
//  Copyright © 2016 Songwen Ding. All rights reserved.
//

#import "ViewController.h"
#import "DEMO-Swift.h"

@interface ViewController ()
@end

@implementation ViewController {
    UIImageView *imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    [CCPDFImage instance].useRamCache = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    imageView.frame = self.view.bounds;
    [[CCPDFImage instance] asyncGetImageWithResource:@"Group" bundle:[NSBundle mainBundle] page:1 size:imageView.bounds.size mainQueueBlock:^(UIImage *image) {
        imageView.image = image;
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
