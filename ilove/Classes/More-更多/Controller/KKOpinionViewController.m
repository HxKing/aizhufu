//
//  KKOpinionViewController.m
//  ilove
//
//  Created by 王亚康 on 16/3/1.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKOpinionViewController.h"
#import "UIView+Extension.h"
#import "HMTextView.h"
#import "SVProgressHUD.h"

@interface KKOpinionViewController ()

@property (weak, nonatomic) IBOutlet UITextView *optextView;
@property (weak, nonatomic) IBOutlet UITextField *assess_tf;
@end

@implementation KKOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"back_hover"] forState:UIControlStateSelected];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.size = CGSizeMake(44, 29);
    btn.backgroundColor = [UIColor lightGrayColor];
    
    [btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

- (void)submit{
    
    if (!self.optextView.text.length) {
        [SVProgressHUD showErrorWithStatus:@"反馈意见不能为空"];
        return;
    }
    
    if (!self.assess_tf.text.length) {
        [SVProgressHUD showErrorWithStatus:@"邮箱地址不能为空"];
        return;
    }
    
    if (![self checkEmail:self.assess_tf.text]) {
        [SVProgressHUD showErrorWithStatus:@"邮箱格式不正确"];
        return;
    }
    
}

- (BOOL)checkEmail:(NSString *)email{
    
    NSString *pattern = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:email];
    return isMatch;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
