//
//  KKItemCell.m
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKItemCell.h"
#import "UIImageView+WebCache.h"
#import "FMDB.h"
#import "SVProgressHUD.h"
#import <MessageUI/MessageUI.h>

@interface KKItemCell()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (IBAction)collect_click:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

- (IBAction)sendToPenson:(UIButton *)sender;

@end


@implementation KKItemCell

- (void)awakeFromNib {
    
}

- (void)setItem:(KKDetailItem *)item{
    _item = item;
    
    self.contentLabel.text = item.content;
    if (item.icon_uri) {
        self.iconImgView.hidden = NO;
        [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:item.icon_uri] placeholderImage:[UIImage imageNamed:@"content"]];
    }else{
        
        self.iconImgView.hidden = YES;
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame{
    
    frame.size.width -= 20;
    frame.size.height -= 10;
    frame.origin.x = 10;
    frame.origin.y += 10;

    [super setFrame:frame];
}

- (IBAction)collect_click:(UIButton *)sender {
    
    NSString *contentText = self.item.content;
    NSString *icon_uriText = self.item.icon_uri;
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"Collection.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        
        NSString *query = [NSString stringWithFormat:@"select loveid from love where parent_id='%@' and conid='%@'",self.item.parent_id,self.item.id];

        FMResultSet *state = [db executeQuery:query];
        
        if ([state next]) {
            [db close];
            return;
        }
        
        NSString *insert = [NSString stringWithFormat:@"insert into love('content','icon_uri','conid','parent_id') values('%@','%@','%@','%@')",
                            contentText,
                            icon_uriText,
                            self.item.id,
                            self.item.parent_id];
        
        BOOL ins = [db executeUpdate:insert];
        
        if (ins) {
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"收藏出错"];
        }
        
    }
    [db close];

}
- (IBAction)sendToPenson:(UIButton *)sender {
    
    if ([self.itemCellDelegate respondsToSelector:@selector(itemCellSendToMessage:)]) {
        [self.itemCellDelegate itemCellSendToMessage:self];
    }
    
}
@end
