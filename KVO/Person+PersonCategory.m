//
//  Person+PersonCategory.m
//  KVO
//
//  Created by XinGou on 2017/11/9.
//  Copyright © 2017年 XinGou. All rights reserved.
//

#import "Person+PersonCategory.h"
#import <objc/runtime.h>
const char *str = "myKey"; //作为key，字符常量必须是c语言字符串。
@implementation Person (PersonCategory)
-(void)setHeight:(float)height
{
    NSNumber *num = [NSNumber numberWithFloat:height];
    /*
     *第一个参数是要添加属性的对象
     *第二个参数是属性的key
     *第三个参数是属性的值，类型必须为id，所以此处height转换为nsnumber
     *第四个参数是使用策略，是一个枚举值，类似@property属性创建时设置的关键字，可从命名看出各枚举的意义； 
    objc_setAssociatedObject(<#id  _Nonnull object#>, <#const void * _Nonnull key#>, <#id  _Nullable value#>, <#objc_AssociationPolicy policy#>)
    */
    
    objc_setAssociatedObject(self, str, num, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(float)height{
    NSNumber *number = objc_getAssociatedObject(self, str);
    return [number floatValue];
}
@end
