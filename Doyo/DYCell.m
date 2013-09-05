//
//  DYCell.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYCell.h"

@implementation DYCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation DYTLCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.frame = CGRectMake(10, 10, 40, 40);
        _iconImgView.backgroundColor = [UIColor cyanColor];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_iconImgView];
        
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(_iconImgView.frame.origin.x + _iconImgView.frame.size.width + 20,
                                                             _iconImgView.frame.origin.y + 10,
                                                             100, 20)];
        _nameLbl.numberOfLines = 1;
        _nameLbl.font = [UIFont boldSystemFontOfSize:14.0];
        _nameLbl.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLbl];
        _nameLbl.backgroundColor = [UIColor lightGrayColor];
        
        _contentLbl = [[UILabel alloc] init];
        _contentLbl.frame = CGRectMake(_iconImgView.frame.origin.x,
                                       _iconImgView.frame.origin.y + _iconImgView.frame.size.height + 10,
                                       300,
                                       50);
        _contentLbl.numberOfLines = 0;
        _contentLbl.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLbl.font = [UIFont boldSystemFontOfSize:14.0];
        [self.contentView addSubview:_contentLbl];
        _contentLbl.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)reflesh
{
    if (_contentLbl) {
        [_contentLbl removeFromSuperview];
        _contentLbl = nil;
    }
    
    _contentLbl = [[UILabel alloc] init];
    _contentLbl.frame = CGRectMake(_iconImgView.frame.origin.x,
                                   _iconImgView.frame.origin.y + _iconImgView.frame.size.height + 10,
                                   300,
                                   50);
    _contentLbl.numberOfLines = 0;
    _contentLbl.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLbl.font = [UIFont boldSystemFontOfSize:14.0];
    [self.contentView addSubview:_contentLbl];
    _contentLbl.backgroundColor = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
