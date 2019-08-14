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

    [self dataAddress];
    [self prepertyStrongAndCopy];
    [self propertyBaseCopy];
}
- (void)descriptionProperty{
    /**
     atomic
     设置成员变量的@property属性时，默认为atomic，提供多线程安全。
     在多线程环境下，原子操作是必要的，否则有可能引起错误的结果。加了atomic，setter函数会变成下面这样：
     {lock}
     if (property != newValue) {
     [property release];
     property = [newValue retain];
     }
     {unlock}
     nonatomic
     禁止多线程，变量保护，提高性能。
     atomic是Objc使用的一种线程保护技术，基本上来讲，是防止在写未完成的时候被另外一个线程读取，造成数据错误。而这种机制是耗费系统资源的，所以在iPhone这种小型设备上，如果没有使用多线程间的通讯编程，那么nonatomic是一个非常好的选择。
     assign
     对基础数据类型 （NSInteger，CGFloat）和C数据类型（int, float, double, char）等等。
     此标记说明设置器直接进行赋值，这也是默认值。在使用垃圾收集的应用程序中，如果你要一个属性使用assign，且这个类符合NSCopying协 议，你就要明确指出这个标记，而不是简单地使用默认值，否则的话，你将得到一个编译警告。这再次向编译器说明你确实需要赋值，即使它是 可拷贝的。
     retain
     对其他NSObject和其子类对参数进行release旧值，再retain新值
     指定retain会在赋值时唤醒传入值的retain消息。此属性只能用于Objective-C对象类型，而不能用于Core Foundation对象。(原因很明显，retain会增加对象的引用计数，而基本数据类型或者Core Foundation对象都没有引用计数——译者注)。
     注意: 把对象添加到数组中时，引用计数将增加对象的引用次数+1。
     copy
     对NSString 它指出，在赋值时使用传入值的一份拷贝。拷贝工作由copy方法执行，此属性只对那些实行了NSCopying协议的对象类型有效。
     copy与retain区别：
     Copy其实是建立了一个相同的对象，而retain不是：
     1.比如一个NSString 对象，地址为0×1111 ，内容为@”STR”，Copy 到另外一个NSString 之后，地址为0×2222 ，内容相同。
     2.新的对象retain为1 ，旧有对象没有变化retain 到另外一个NSString 之后，地址相同（建立一个指针，指针拷贝），内容当然相同，这个对象的retain值+1。
     总结：retain 是指针拷贝，copy 是内容拷贝。
     assign与retain：
     
     接触过C，那么假设你用malloc分配了一块内存，并且把它的地址赋值给了指针a，后来你希望指针b也共享这块内存，于是你又把a赋值给（assign）了b。此时a和b指向同一块内存，请问当a不再需要这块内存，能否直接释放它？答案是否定的，因为a并不知道b是否还在使用这块内存，如果a释放了，那么b在使用这块内存的时候会引起程序crash掉。
     了解到1中assign的问题，那么如何解决？最简单的一个方法就是使用引用计数（reference counting），还是上面的那个例子，我们给那块内存设一个引用计数，当内存被分配并且赋值给a时，引用计数是1。当把a赋值给b时引用计数增加到2。这时如果a不再使用这块内存，它只需要把引用计数减1，表明自己不再拥有这块内存。b不再使用这块内存时也把引用计数减1。当引用计数变为0的时候，代表该内存不再被任何指针所引用，系统可以把它直接释放掉。
     
     const
     变量修饰符，只有只读权限，意思是这个参数只能读，不能修改内容，谁近修饰谁。
     用途： 1.便于测试快速找到问题
     2如果是大型算法可以快速找到是哪个模块出现错误
     修饰位置：
     register
     //register int b = 0;
     变量前面加register修饰，编译器会优先将此变量放在寄存器中，这样对这个变量进行的各种操作及运算，会很快，（适用于嵌入式编程）当然CPU周边的用户可用空闲寄存器是有限的，所以当定义多个register修饰的变量后，当可用寄存器已被占完，后面的变量即便用register修饰，也是不起作用的，依然是在普通内存中为变量开辟空间。
     static
     有时候我们非常希望，用一个小变量记录某函数调用的次数，解决这个问题
     方法1、可以使用全局变量；但是由于所有函数都可以修改它，对于较大程序出了问题不好调，所以使用全局变量并不好。
     方法2、可以在目标函数中定义一个static变量（测试会发现这个变量的地址已经不再栈区，而是在数据区），每次进入函数让其++，static作用在局部变量前，函数结束此变量的值不清空，即改变了此变量的生命期，而且直到整个程序结束，并且此变量的值只有在定义它的函数中才可以被使用和重新赋值
     extern
     extern int n;
     extern可以扩展全局变量或函数的作用范围，只有全局变量或函数才可以用extern扩展
     extern与register的区别
     extern可以用来扩展函数的作用范围，可以跨文件扩展，前提是被扩展全局变量或者函数在定义时没有被static修饰！
     简单来说，assign 修饰符用来修饰值类型和 id 类型（一般是 delegate）的属性，需要注意的是如果 id 类型的属性的修饰符用了 assign, 当你不再需要这个属性时，你必须将 delegate 手动置空，防止野指针产生，这也是为什么 delegate 一般都用 weak 修饰的原因。
     weak 和 strong 是 ARC 的产物，分别表示弱引用类型和强引用类型。在给 strong 修饰的属性赋值时，会将属性的指针指向新值的地址，同时持有这个新值（新值的引用计数被加1）。在给 weak 修饰的属性赋值时，只是简单地将属性的指针指向新值的地址，不会持有新值。
     retain 在 ARC 下基本等同于 strong。
     copy 表示强引用，但是不会持有新值，而是拷贝一份引用计数为1的值给属性。给这种修饰符修饰的属性赋值时，实际上是把 新值调用 copy 方法后的返回值 赋给属性。NSString 类型常常用 copy 修饰，就是防止修改某个对象后，对强引用这个对象的属性造成不必要影响。
     
     作者：单线程Jack
     链接：https://www.jianshu.com/p/53a67b0fdd17
     来源：简书
     简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
     */
}

- (void)dataAddress{
    //https://www.jianshu.com/p/a4388d343345
//    创建不可变 数组、字典、字符串，不管用类方法创建还是对象方法创建，只要是创建空的对象， 发现得到的地址都是一样的，由此可以知道初始化空的对象的时候会生成一个单例
    NSArray *aa = [NSArray array];
    NSArray *ab = [NSArray array];
    NSArray *ac = [NSArray array];
    NSArray *ae = [[NSArray alloc] init];
    NSArray *ad = [NSArray array];
    
    NSArray *af = [[NSArray alloc] initWithObjects:@"1", nil];
    
    NSArray *ag = [[NSArray alloc] initWithObjects:@"1", nil];
    NSLog(@"%p-%p-%p-%p-%p-%p-%p",aa,ab,ac,ae,ad,af,ag);
    
    NSString *sa = [NSString string];
    NSString *sb = [[NSString alloc]init];
    NSString *sc = [NSString new];
    
    NSString *sd = [NSString stringWithFormat:@""];
    NSString *se = [NSString stringWithFormat:@"%@",@""];
    
    NSString *sf = [NSString stringWithFormat:@"%@",nil];
    
    NSLog(@"%p-%p-%p-%p-%p-%p",sa,sb,sc,se,sd,sf);
    
    //创建可变 数组、字典、字符串，都会申请不同的内存空间。
    NSMutableString *msa = [NSMutableString string];
    //0x600000244ec0
    NSMutableString *msb = [NSMutableString string];
    //0x600000244b00
    NSMutableString *msc = [NSMutableString string];
    //0x600000244b90
    NSMutableString *msd = [NSMutableString string];
    //0x600000243ed0
    NSMutableString *msf = [[NSMutableString alloc] init];
    //0x6000002431b0
    NSLog(@"%p-%p-%p-%p-%p",msa,msb,msc,msd,msf);
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
