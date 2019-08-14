//
//  ViewController.m
//  OCBaseKnowledge
//
//  Created by conan on 2019/8/14.
//  Copyright © 2019年 conan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self propertyBaseCopy];
}


- (void)propertyBaseCopy{
    NSString *string = @"不可变对象";
    
    NSMutableString *mutableString = [NSMutableString stringWithFormat:@"可变对象"];
    
    NSLog(@"string %p",string);
    NSLog(@"string %p",[string copy]);
    NSLog(@"string %p",[string mutableCopy]);
    
    NSLog(@"mutableString %p",mutableString);
    NSLog(@"mutableString %p",[mutableString copy]);
    NSLog(@"mutableString %p",[mutableString mutableCopy]);
    
    /**
     log:
     string 0x1024bd068
     string 0x1024bd068
     string 0x60000024c5a0
     mutableString 0x60c0002598f0
     mutableString 0x60000002b260
     mutableString 0x60000024c5a0
     
     非容器类结论：
     不可变对象：copy为浅拷贝，地址不变指针拷贝；mutableCopy 为深拷贝，地址改变
     可变对象： copy和mutableCopy 均为深拷贝，地址改变
     */

    NSArray *array = @[@1,@"content"];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithObjects:@"content",@"可变数组", nil];
    NSLog(@"array %p",array);
    NSLog(@"array %p",[array copy]);
    NSLog(@"array %p",[array mutableCopy]);
    
    NSLog(@"mutableArray %p",mutableArray);
    NSLog(@"mutableArray %p",[mutableArray copy]);
    NSLog(@"mutableArray %p",[mutableArray mutableCopy]);
    /**
     log:
     array 0x60c000033bc0
     array 0x60c000033bc0
     array 0x604000442070
     mutableArray 0x60c00004a9e0
     mutableArray 0x608000031fa0
     mutableArray 0x60800004d800
     
     容器类概念：NSArray、NSDictionary、NSSet为容器类型的对象
     容器类结论：
     不可变对象：copy为浅拷贝，地址不变指针拷贝；mutableCopy 为深拷贝，地址改变
     可变对象： copy和mutableCopy 均为深拷贝，地址改变
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
