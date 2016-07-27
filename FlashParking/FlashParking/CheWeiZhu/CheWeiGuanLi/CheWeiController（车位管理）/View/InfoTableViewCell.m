//
//  InfoTableViewCell.m
//  FlashParking
//
//  Created by 张弛 on 16/7/19.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "InfoTableViewCell.h"
#import "CheWeiModel.h"
@implementation InfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setDingDanModel:(CheWeiModel *)CheWeiModel {
    _CheWeiModel = CheWeiModel;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
