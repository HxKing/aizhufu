//
//  KKLoveCell.m
//  ilove
//
//  Created by 王亚康 on 16/3/1.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKLoveCell.h"
#import "UIImageView+WebCache.h"
#import "FMDB.h"


@interface KKLoveCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

@property (weak, nonatomic) IBOutlet UILabel *contentLb;

- (IBAction)collect_click:(UIButton *)sender;
- (IBAction)fenxiang:(UIButton *)sender;

@end

@implementation KKLoveCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setItem:(KKDetailItem *)item{
    _item = item;
    
    self.contentLb.text = item.content;
    
    if (item.icon_uri) {
        self.iconImgView.hidden = NO;
        [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:item.icon_uri] placeholderImage:[UIImage imageNamed:@"content"]];
    }else{
        
        self.iconImgView.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame{
    
    frame.size.width -= 20;
    frame.size.height -= 10;
    frame.origin.x = 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}

- (IBAction)collect_click:(UIButton *)sender {
    
    if ([self.loveDelegate respondsToSelector:@selector(loveCell:)]) {
        [self.loveDelegate loveCell:self];
    }
    
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    NSString *path = [doc stringByAppendingPathComponent:@"Collection.sqlite"];
//    
//    FMDatabase *db = [FMDatabase databaseWithPath:path];
//    if ([db open]) {
//        NSString *delete = [NSString stringWithFormat:@"delete from love where parent_id = '%@' and conid = '%@'",self.item.parent_id,self.item.id];
//        NSLog(@"delete %@",delete);
//        BOOL de = [db executeUpdate:delete];
//        if (de) {
//            
//        }
//    }

    
    
    
}

- (IBAction)fenxiang:(UIButton *)sender {
    NSLog(@"-----fen xiang");
    if ([self.loveDelegate respondsToSelector:@selector(loveCellFenXiang:)]) {
        [self.loveDelegate loveCellFenXiang:self];
    }
    
}

@end
