//
//  ViewController.m
//  KVO
//
//  Created by XinGou on 2017/11/9.
//  Copyright © 2017年 XinGou. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Person+PersonCategory.h"
#import <objc/runtime.h>
#import "TextViewViewController.h"
@interface ViewController ()
{
    Person *per;
}
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}
- (void)viewDidLoad {
    [super viewDidLoad];

    per = [[Person alloc] init];
    float mainWidth = [UIScreen mainScreen].bounds.size.width;
    float btnHeight = 50;
    float btnRow = 30;
    NSArray *arr = [NSArray arrayWithObjects:@"获取所有变量",@"获取所有方法",@"改变私有变量的值",@"添加一个新属性",@"添加一个新方法",@"交换2格方法功能",@"获取协议列表",@"例子", nil];
    for (int i = 0; i<8; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 50+(btnHeight+btnRow)*i, mainWidth, btnHeight)];
        btn.backgroundColor = [UIColor grayColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.view addSubview:btn];
    }
    
    Class CreateClass0 = objc_allocateClassPair([Person class], "CreatClass0", 0);
    class_addIvar(CreateClass0, "light", sizeof(NSString*), log(sizeof(NSString*)), "i");
    Ivar ivar = class_getInstanceVariable(CreateClass0, "light");
    NSLog(@">>>>0:%@",[NSString stringWithUTF8String:ivar_getName(ivar)]);
    objc_registerClassPair(CreateClass0);
    NSLog(@"\n");
}
-(void)click:(UIButton*)sender
{
    if (sender.tag == 0) {//获取所有变量
        unsigned int count = 0;
        //获取类的一个包含所有变量的列表，Ivar时runtime声明的一个宏，是实例变量的意思。
        //        Ivar *allVariables = class_copyIvarList([Person class], &count);
        //        for ( int i = 0; i<count; i++) {
        //            Ivar ivar = allVariables[i];
//                    const char *Variablename = ivar_getName(ivar);//获取成员变量的名称
//                    const char *VariableType = ivar_getTypeEncoding(ivar);//获取成员变量的类型
//                    NSLog(@"(Name: %s)----------(Type: %s)",Variablename,VariableType);
        //        }
        //获取成员属性列表
        objc_property_t *propertyList = class_copyPropertyList([Person class], &count);
        for (int i = 0; i<count; i++) {
            const char *propertyName = property_getName(propertyList[i]);
            NSLog(@"property---->%@",[NSString stringWithUTF8String:propertyName]);
        }
    }else if (sender.tag == 1){//获取所有的方法
        unsigned int count;
        //获取方法列表，所有在.m文件显式实现的方法都会被找到，包括setter+getter方法；
        Method *allMethods = class_copyMethodList([Person class], &count);
        for (int i = 0; i<count; i++) {
            //Method 为runtime声明的一个宏，表示对一个方法的描述
            Method md = allMethods[i];
            //获取SEL：SEL类型，即获取方法选择器@selector()
            SEL sel = method_getName(md);
            //得到sel的方法名：以字符串式获取sel的name，也即@selector()中的方法名称
            const char *methodname = sel_getName(sel);
            NSLog(@"(Method: %s)",methodname);
        }
    }else if(sender.tag == 2){//改变私有变量的值
        NSLog(@"改变之前的person %@",per);
        unsigned int count = 0;
        Ivar *allList = class_copyIvarList([Person class], &count);
        Ivar ivv = allList[0]; //根据第一个按钮的点击事件显示name是第一个
//        [per setValue:@"Mike" forKey:@"name"];  也可以使用kvc的形式进行更改
        object_setIvar(per, ivv, @"Mike");
        NSLog(@"改变之后的person %@",per);
    }else if (sender.tag == 3){//添加新属性
        per.height = 12;
        NSLog(@"%f",[per height]);
    }else if (sender.tag == 4){//添加新方法 等价于对father类添加category对方法进行扩展
        /*
         *第一个参数表示class cls类型
         *第二个参数表示带调用方法名称
         *第三个参数（IMP）myAddingFunction,IMP一个函数指针，这里表示指定具体实现方法
         *第四个参数表方法的参数，0代表没有参数；
         */
        class_addMethod([per class], @selector(NewMethod), (IMP)myAddingFunction, 0);
        [per performSelector:@selector(NewMethod)];
    }else if (sender.tag == 5){//交换2个方法
        Method method1 = class_getInstanceMethod([per class], @selector(func1));
        Method method2 = class_getInstanceMethod([per class], @selector(func2));
        method_exchangeImplementations(method1, method2);
        [per func1];
    }else if (sender.tag == 6){
        unsigned int count;
        __unsafe_unretained Protocol **protocolList = class_copyProtocolList([Person class], &count);
        for (int i = 0; i<count; i++) {
            Protocol *myProtocal = protocolList[i];
            const char *protocolName = protocol_getName(myProtocal);
            NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
        }
    }else{
        TextViewViewController *vc = [[TextViewViewController alloc] init];
        self.view.window.rootViewController = vc;
    }
    
    
}
//具体的实现（方法的内部都默认包含两个参数Class类和SEL方法，被称为隐式参数。）
int myAddingFunction(id self,SEL _cmd){
    NSLog(@"已新增方法：NewMethod");
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
