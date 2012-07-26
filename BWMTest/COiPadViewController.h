//
//  COiPadViewController.h
//  BWMTest
//
//  Created by 陈渊佑 on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COiPadViewController : UIViewController{
    NSMutableArray *_array;//图片文件
    CGPoint _touchBeginLocation;//触摸的点
    
    NSUInteger _pageIndex;
    NSUInteger _lastPageIndex;
    NSUInteger _currentIndex;
    
    NSUInteger _currentCount;//当前有多少张图片
    
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)changeSpeed:(id)sender;

@end
