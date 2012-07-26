//
//  COiPadViewController.m
//  BWMTest
//
//  Created by 陈渊佑 on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "COiPadViewController.h"
#define ImageCount 120
#define TouchPix 10
#define OneImageCount 40

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
- (void)loadView{
    [super loadView];
    //通过nib文件初始化
    _array=[[NSMutableArray alloc] initWithCapacity:10];
    
    for (int i=0; i<ImageCount; i++) {
        [_array addObject:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"VR_F25_%.6d",i] ofType:@"png"]];
    }
    NSLog(@" \n %@ ",_array);
    _currentCount = ImageCount;
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
            //            int nextIndex = ImageCount < speed + _index +_currentIndex ? 0 :speed + _index +_currentIndex;
            
            _pageIndex=(_index+_currentIndex )%_currentCount;
        }
        else{
            _pageIndex=(_currentCount-_index+_currentIndex)%_currentCount;
        }
        NSLog(@"_pageIndex = %d _index = %d",_pageIndex,_index);

        if (_lastPageIndex != _pageIndex) {
            self.imageView.image=[UIImage imageWithContentsOfFile:[_array objectAtIndex:_pageIndex]];
            _lastPageIndex = _pageIndex;
            
        }
        
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    _currentIndex=_pageIndex;
}
//
//-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    self.imageView.frame=CGRectMake(200, 200, 552, 376);
//}

#pragma mark 按钮事件
//设置现在的增值
- (IBAction)changeSpeed:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    int chooseInt = segment.selectedSegmentIndex;
    int count = OneImageCount *(3 - chooseInt);
    //重新填充datas
    [_array release];
    _array  = [[NSMutableArray alloc] initWithCapacity:count];
    //设置当前的_pageIndex
    for (int i =0 ; i < ImageCount && [_array count] < count; i = i + chooseInt +1) {
        [_array addObject:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"VR_F25_%.6d",i] ofType:@"png"]];
        NSLog(@"添加的图片名为:%@",[NSString stringWithFormat:@"VR_F25_%.6d",i]);
    }
    //设置当前的图片
    _pageIndex = (double)_pageIndex / _currentCount * [_array count];
    NSLog(@"_pageIndex = %d,+currentCount = %d,count = %d",_pageIndex,_currentCount,[_array count]);
    _currentCount = [_array count];
    self.imageView.image=[UIImage imageWithContentsOfFile:[_array objectAtIndex:_pageIndex]];
    _currentIndex=_pageIndex;

}
@end
