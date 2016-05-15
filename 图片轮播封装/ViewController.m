//
//  ViewController.m
//  图片轮播封装
//
//  Created by 911 on 16/1/6.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "ViewController.h"
#import "imageScrollview.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   
    
    imageScrollview *imageView = [imageScrollview imageScrollView];
    
    

    
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 5; ++i) {
        NSString *imgName = [NSString stringWithFormat:@"img_0%d",i];
        UIImage *img = [UIImage imageNamed:imgName];
        [images addObject:img];
    }
    [self.view addSubview:imageView];
    imageView.images = images;
    imageView.frame = CGRectMake(0, 100, 300, 150);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
