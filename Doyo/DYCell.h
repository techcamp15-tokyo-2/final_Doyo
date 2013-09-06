//
//  DYCell.h
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYCell : UITableViewCell

@end

@interface DYTLCell : UITableViewCell

@property (nonatomic, retain) UIImageView *iconImgView;
@property (nonatomic, retain) UILabel *nameLbl;
@property (nonatomic, retain) UILabel *contentLbl;

- (void)reflesh;

@end


@interface DYTopicCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLbl;
@property (nonatomic, retain) UIImageView *iconImgView;
@property (nonatomic, retain) UILabel *nameLbl;
@property (nonatomic, retain) UILabel *rankLbl;
@property (nonatomic, retain) UILabel *pointLbl;
@property (nonatomic, retain) UIButton *niceBtn;

-(void)refresh;

@end

