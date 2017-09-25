//
//  MyCommentListCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/10.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "MyCommentListCell.h"
#import "JWStarView.h"

@interface MyCommentListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet JWStarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLbael;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end


@implementation MyCommentListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.thumbImageView.layer.cornerRadius = 4.f;
    self.thumbImageView.layer.masksToBounds = YES;
    
    self.starView.isIndicator = YES;
}


- (void)setHotel:(Hotel *)hotel {
    
    [_thumbImageView sd_setImageWithURL:[NSURL URLWithString:hotel.storeImage] placeholderImage:kImage(@"blank_default_nomal_bg")];
    _storeName.text = hotel.storeName;
    _starView.currentScore = [[NSString stringWithFormat:@"%0.1f", [hotel.storeScore floatValue]] floatValue];
    _scoreLbael.text = [NSString stringWithFormat:@"评分 %0.1f", [hotel.storeScore floatValue]];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@", hotel.storePrice];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
