//
//  imageScrollview.h
//  图片轮播封装
//
//  Created by 911 on 16/1/6.
//  Copyright © 2016年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imageScrollview : UIView

+ (instancetype) imageScrollView;
@property (nonatomic, strong) NSArray *images;
@end
