//
//  KKAboutViewController.m
//  ilove
//
//  Created by 王亚康 on 16/3/2.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKAboutViewController.h"

@interface KKAboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *content_lb;

@end

@implementation KKAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.content_lb.text = @"	《爱祝福》是一款短信增强工具，用简短的文字，通过送祝福的方式，在节日、重要纪念日、生日、日常的时候，通过手机短信给父母、爱人、同学、朋友、客户送去一个简单的祝福，用爱温暖我们的亲情、爱情、友情。\n\
    爱祝福功能亮点：\n\
    1、内容海量、原创、时时更新：涵盖节日、日常、结婚、生子、表白、康复、校园、商务、整蛊等。\n\
    2、软件完全免费，无暗扣：仅需支付流量费用即可。在WIFI环境下完全免费。爱祝福还支持离线使用。\n\
    3、短信随时发：专题中的每条内容都可通过短信直接发送给亲朋好友。\n\
    4、收藏搜索全都有：看到喜欢的内容，收藏后可以直接使用！通过搜索关键字可找到你需要内容，还有常用热门的关键字供你选择。";
    
    // Do any additional setup after loading the view.
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
