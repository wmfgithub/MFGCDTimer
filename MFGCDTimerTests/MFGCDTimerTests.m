//
//  MFGCDTimerTests.m
//  MFGCDTimerTests
//
//  Created by wangfeng'pro on 2018/11/8.
//  Copyright © 2018 wangfeng'pro. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MFGCDTimer.h"

@interface MFGCDTimerTests : XCTestCase

@end

@implementation MFGCDTimerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

NSString *task = @"test";
NSString *task1 = @"test1";
NSString *task2 = @"test2";
NSString *task3 = @"test3";
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    int count = 0;
    
    
    dispatch_source_t timer;
  
    
  task =  [MFGCDTimer execTask:self
                selector:@selector(doTask)
                   start:2.0
                interval:1.0
                 repeats:YES
                   async:NO];
    
    // 队列
    //    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_queue_t queue = dispatch_queue_create("timer", DISPATCH_QUEUE_SERIAL);
    
    // 创建定时器
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置时间
    uint64_t start = 2.0; // 2秒后开始执行
    uint64_t interval = 1.0; // 每隔1秒执行
    dispatch_source_set_timer(timer,
                              dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC),
                              interval * NSEC_PER_SEC, 0);
    
    // 设置回调
    //    dispatch_source_set_event_handler(timer, ^{
    //        NSLog(@"1111");
    //    });
    dispatch_source_set_event_handler_f(timer, timerFire);
    
    // 启动定时器
    dispatch_resume(timer);
    
    
    
}

void timerFire(void *param)
{
    NSLog(@"2222 - %@", [NSThread currentThread]);
}

int count = 0;
- (void)doTask
{
    count ++ ;
    if (count >= 10) {
        [MFGCDTimer cancelTask:task];
    }
    NSLog(@"doTask - %@", [NSThread currentThread]);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
