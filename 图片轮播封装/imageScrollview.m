//
//  imageScrollview.m
//  图片轮播封装
//
//  Created by 911 on 16/1/6.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "imageScrollview.h"

@interface imageScrollview () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;

@property (nonatomic, weak) NSTimer *timer;

@end


@implementation imageScrollview


-(void)setImages:(NSArray *)images{
    [self.scrollV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _images = images;
    for (int i = 0; i < self.images.count;i++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:self.images[i]];
        
        imageView.frame = CGRectMake(i * self.scrollV.frame.size.width, 0, self.scrollV.frame.size.width, self.scrollV.frame.size.height);
        
//        imageView.translatesAutoresizingMaskIntoConstraints = NO;
//        
//        NSLayoutConstraint *imgVConStraintW = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.scrollV attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
//        [imageView addConstraint:imgVConStraintW];
//        
//        NSLayoutConstraint *imgVConStraintH = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.scrollV attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
//        [imageView addConstraint:imgVConStraintH];
//        
//        NSLayoutConstraint *imgVConStraintH = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.scrollV attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
//        [imageView addConstraint:imgVConStraintH];
        
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.scrollV addSubview:imageView];

    }
    self.pageControl.numberOfPages = _images.count;
    self.scrollV.contentSize = CGSizeMake(self.scrollV.frame.size.width * [_images count], 0);
    [self createTimer];
    
}

+ (instancetype) imageScrollView{
    
    
    return [[[NSBundle mainBundle]loadNibNamed:@"imageScrollView" owner:nil options:nil] lastObject];
    
}

- (void)awakeFromNib{
    
    self.scrollV.delegate = self;
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index = (scrollView.contentOffset.x/scrollView.frame.size.width) + 0.5;
    self.pageControl.currentPage = index;
    
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self startTimer];
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self startTimer];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self endTimer];
}

- (void)startTimer{
    
    self.timer.fireDate = [NSDate distantPast] ;
}

- (void)endTimer{
    //    [self.timer invalidate];
    self.timer.fireDate = [NSDate distantFuture];
}

- (void)createTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(pageScroll) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)pageScroll{
    CGPoint currentPoint = CGPointMake(self.scrollV.contentOffset.x + self.scrollV.frame.size.width, 0);
    [self.scrollV setContentOffset:currentPoint animated:YES];
    if (currentPoint.x == 5 * self.scrollV.frame.size.width ) {
        [self.scrollV setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
}

@end
