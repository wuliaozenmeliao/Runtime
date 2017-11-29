//
//  UIViewController+swizzling.m
//  KVO
//
//  Created by XinGou on 2017/11/10.
//  Copyright © 2017年 XinGou. All rights reserved.
//

#import "UIViewController+swizzling.h"
#import <objc/runtime.h>
@implementation UIViewController (swizzling)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获取viewCOntroller的生命周期的方法selector
        SEL systemSel = @selector(viewWillAppear:);
        //自己实现的将要被交换的方法selector
        SEL swizzSel = @selector(swiz_viewWillAppear:);
        //两个方法交换
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(swizzMethod));
        }else{
            //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
}
-(void)swiz_viewWillAppear:(BOOL)animated
{
    //这时候调用自己，看起来像是死循环
    //但是其实自己的实现已经被替换了
    [self swiz_viewWillAppear:animated];
    NSLog(@"swizzle");
}
@end
