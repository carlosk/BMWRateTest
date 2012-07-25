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
    
    NSUInteger _count;
    NSUInteger _currentIndex;

}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@end
