//
//  COiPadViewController.m
//  BWMTest
//
//  Created by 陈渊佑 on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "COiPadViewController.h"

@interface COiPadViewController ()

@end

@implementation COiPadViewController
@synthesize scrollView = _scrollView;
@synthesize imageView;

#pragma mark 生命周期方法
- (void)dealloc{
    //要释放的变量
    self.imageView = nil;
    [_array release],_array = nil;
    _touchBeginLocation = CGPointZero;
    [_scrollView release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //不通过nib文件的初始化
    
}
#define ImageCount 120
#define TouchPix 10
- (void)loadView{
    [super loadView];
    //通过nib文件初始化
    _array=[[NSMutableArray alloc] initWithCapacity:10];
    
    for (int i=0; i<ImageCount; i++) {
        [_array addObject:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"VR_F25_%.6d",i] ofType:@"png"]];
    }
    NSLog(@" \n %@ ",_array);
    
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        return interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}
#pragma mark -- touch

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint _beginLocation=[[touches anyObject] locationInView:self.view];
    //如果开始触摸的是在view之内,则获取这个定位,不然是Zero
    if (CGRectContainsPoint(self.imageView.frame, _beginLocation)) {
        _touchBeginLocation=[[touches anyObject] locationInView:self.imageView];
    }
    else{
        _touchBeginLocation=CGPointZero;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //如果不等于0,说明开始移动是在view范围内
    if (_touchBeginLocation.x!=0) {
        CGPoint _locationPoint=[[touches anyObject] locationInView:self.imageView];
        //当前的坐标和开始的坐标差距如果是30的倍数,30说明是否经过了30个像素
        NSUInteger _index=abs((int)(_locationPoint.x-_touchBeginLocation.x)/TouchPix);
        //向右边移动的话
        if (_locationPoint.x-_touchBeginLocation.x<0) {
            //显示的是图片数的余数,就算小于图片数,也是一样,旋转的时候,只要当前的坐标+移动的30的倍数,然后超过图片数,则会从头开始显示
            self.imageView.image=[UIImage imageWithContentsOfFile:[_array objectAtIndex:(_index+_currentIndex)%ImageCount]];
            _count=(_index+_currentIndex)%ImageCount;
        }
        else{
            self.imageView.image=[UIImage imageWithContentsOfFile:[_array objectAtIndex:(ImageCount-_index+_currentIndex)%ImageCount]];
            _count=(ImageCount-_index+_currentIndex)%ImageCount;
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    _currentIndex=_count;
}
//
//-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    self.imageView.frame=CGRectMake(200, 200, 552, 376);
//}


@end
