//
//  Person.m
//  KVO
//
//  Created by XinGou on 2017/11/9.
//  Copyright © 2017年 XinGou. All rights reserved.
//

#import "Person.h"
#import "Person+PersonCategory.h"
@implementation Person
{
    NSString *name;//实例变量
}
-(instancetype)init
{
    if (self = [super init]) {
        name = @"Tom";
        self.age = 12;
    }
    return self;
}
-(void)func1
{
    NSLog(@"执行func1方法");
}
-(void)func2
{
    NSLog(@"执行func2方法");
}
//输出person对象时的方法
-(NSString*)description
{
    return [NSString stringWithFormat:@"name:%@ age:%d",name,self.age];
}
@end
