//
//  LTDingDanCell.m
//  FlashParking
//
//  Created by 薄号 on 16/6/30.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "LTDingDanCell.h"
#import "LTDingDanModel.h"

@implementation LTDingDanCell

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

- (void)setDingDanModel:(LTDingDanModel *)dingDanModel {
    _dingDanModel = dingDanModel;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
