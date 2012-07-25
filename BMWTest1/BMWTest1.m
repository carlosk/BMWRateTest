//
//  BMWTest1.m
//  BMWTest1
//
//  Created by 陈渊佑 on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BMWTest1.h"

@implementation BMWTest1

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
//    STFail(@"Unit tests are not implemented yet in BMWTest1");
    //验证%i加数字是否会在前面加0000
    for (int i = 0; i <120; i++) {
        NSLog(@"%.6d",i);
    }
}

@end
