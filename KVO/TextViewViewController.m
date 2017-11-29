//
//  TextViewViewController.m
//  KVO
//
//  Created by XinGou on 2017/11/10.
//  Copyright © 2017年 XinGou. All rights reserved.
//

#import "TextViewViewController.h"
//#import "UITextView+Test.h"
@interface TextViewViewController ()
{
    UITextView *_textView;
}
@end

@implementation TextViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
//    _textView.placeholder = @"请输入用户名";
    _textView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
