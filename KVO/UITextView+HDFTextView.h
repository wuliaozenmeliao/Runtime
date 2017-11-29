//
//  UITextView+HDFTextView.h
//  KVO
//
//  Created by XinGou on 2017/11/10.
//  Copyright © 2017年 XinGou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (HDFTextView)
/**
 * 占位提示语
 */
@property(nonatomic,strong)NSString *hdf_placeholder;
/**
 * 占位提示语的字体颜色
 */
@property (nonatomic, strong) UIColor *hdf_placeholderColor;

/**
 * 占位提示语的字体
 */
@property (nonatomic, strong) UIFont  *hdf_placeholderFont;

/**
 * 占位提示语标签
 */
@property (nonatomic, strong, readonly) UILabel *hdf_placeholderLabel;
@end
