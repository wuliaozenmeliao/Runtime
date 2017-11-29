//
//  UITextView+Category.m
//  KVO
//
//  Created by XinGou on 2017/11/10.
//  Copyright © 2017年 XinGou. All rights reserved.
//

#import "UITextView+Category.h"
#import <objc/runtime.h>
const char *str = "placeholder";
@implementation UITextView (Category)
-(void)setPlaceholder:(NSString *)placeholder
{
    objc_setAssociatedObject(self, str, placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString*)placeholder
{
    NSString *string = objc_getAssociatedObject(self, str);
    return string;
}
@end
