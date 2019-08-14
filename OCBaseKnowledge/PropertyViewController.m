//
//  PropertyViewController.m
//  OCBaseKnowledge
//
//  Created by conan on 2019/8/14.
//  Copyright © 2019年 conan. All rights reserved.
//

#import "PropertyViewController.h"

@interface PropertyViewController ()
@property (nonatomic, strong) NSString *stringStrong;
@property (nonatomic, copy) NSString *stringCopy;
@end

@implementation PropertyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);

    [self prepertyStrongAndCopy];
    [self propertyBaseCopy];
}

- (void)prepertyStrongAndCopy{
    // 第一种场景：用NSString点语法赋值
    NSString *originStr1 = [NSString stringWithFormat:@"test"];
    
    self.stringStrong = originStr1;
    self.stringCopy = originStr1;
    
    NSLog(@"originStr: %p , %p , %@", originStr1, &originStr1, originStr1);
    NSLog(@"strongStr: %p , %p , %@", _stringStrong, &_stringStrong, _stringStrong);
    NSLog(@" copyyStr: %p , %p , %@", _stringCopy, &_stringCopy, _stringCopy);
    
    /**
     结论：这种情况下，不管是用strong还是copy修饰的对象，其指向的地址都是originStr的地址。
     */
    
    // 第二种场景：用NSMutableString点语法赋值
    NSMutableString *originStr2 = [NSMutableString stringWithFormat:@"test"];
    
    self.stringStrong = originStr2;
    self.stringCopy = originStr2;
    [originStr2 setString:@"hello"];
    NSLog(@"originStr: %p , %p , %@", originStr2, &originStr2, originStr2);
    NSLog(@"strongStr: %p , %p , %@", _stringStrong, &_stringStrong, _stringStrong);
    NSLog(@" copyyStr: %p , %p , %@", _stringCopy, &_stringCopy, _stringCopy);
    
    /**
     结论：用self.copyyStr = originStr3 赋值时，调用copyyStr的setter方法，setter方法对传入的copyyStr做了次深拷贝生成了一个新的对象赋值给_copyyStr，所以_copyyStr指向的地址和对象值都不再和originStr3相同。
     */
    
    /**
     当原字符串是NSString时，由于是不可变字符串，所以，不管使用strong还是copy修饰，都是指向原来的对象，copy操作只是做了一次浅拷贝。
     而当源字符串是NSMutableString时，strong只是将源字符串的引用计数加1，而copy则是对原字符串做了次深拷贝，从而生成了一个新的对象，并且copy的对象指向这个新对象。另外需要注意的是，这个copy属性对象的类型始终是NSString，而不是NSMutableString，如果想让拷贝过来的对象是可变的，就要使用mutableCopy。
     所以，如果源字符串是NSMutableString的时候，使用strong只会增加引用计数。
     但是copy会执行一次深拷贝，会造成不必要的内存浪费。而如果原字符串是NSString时，strong和copy效果一样，就不会有这个问题。
     
     但是，我们一般声明NSString时，也不希望它改变，所以一般情况下，建议使用copy，这样可以避免NSMutableString带来的错误。
     
     作者：QiShare
     链接：https://www.jianshu.com/p/62913d6cbc40
     来源：简书
     简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
     */
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
     不可变对象：copy为浅拷贝，地址不变；mutableCopy 为深拷贝，地址改变
     可变对象： copy和mutableCopy 均为深拷贝，地址改变
     */
}

@end
