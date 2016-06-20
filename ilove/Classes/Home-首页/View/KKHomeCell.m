//
//  KKHomeCell.m
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKHomeCell.h"
#import "UIImageView+WebCache.h"

@interface KKHomeCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImg;

@property (weak, nonatomic) IBOutlet UILabel *titlelable;

@end

@implementation KKHomeCell

- (void)awakeFromNib {

}

- (void)setHomeItem:(KKHomeItem *)homeItem{
    _homeItem = homeItem;
    
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:homeItem.icon_small] placeholderImage:[UIImage imageNamed:@"mainleft"]];
    self.titlelable.text = homeItem.name;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
