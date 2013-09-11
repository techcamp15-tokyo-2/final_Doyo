//
//  DYCell.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYCell.h"
#import "DYManager.h"

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
                                                             200, 20)];
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


@implementation DYTopicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.frame = CGRectMake(10,10,40, 40);
        _iconImgView.backgroundColor = [UIColor cyanColor];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_iconImgView];

        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(_iconImgView.frame.origin.x + _iconImgView.frame.size.width + 20,
                                                             _iconImgView.frame.origin.y + 10,
                                                             200, 20)];
        _nameLbl.numberOfLines = 1;
        _nameLbl.font = [UIFont boldSystemFontOfSize:14.0];
        _nameLbl.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLbl];
        _nameLbl.backgroundColor = [UIColor lightGrayColor];
        
        /*
        _rankLbl = [[UILabel alloc] initWithFrame:CGRectMake(280, 10, 30, 30)];
        _rankLbl.backgroundColor = [UIColor redColor];
        _rankLbl.textAlignment = NSTextAlignmentCenter;
        //[self.contentView addSubview:_rankLbl];
        */
        
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, _iconImgView.frame.origin.y + _iconImgView.frame.size.height + 10
                                                              ,300, 50)];
        _titleLbl.numberOfLines = 0;
        _titleLbl.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLbl.font = [UIFont boldSystemFontOfSize:14.0];
        [self.contentView addSubview:_titleLbl];
        _titleLbl.backgroundColor = [UIColor lightGrayColor];
        
        _niceBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_niceBtn setTitle:@"nice" forState:UIControlStateNormal];
        [_niceBtn addTarget:self action:@selector(niceBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        _niceBtn.frame = CGRectMake(70, _titleLbl.frame.origin.y + _titleLbl.frame.size.height + 10, 40, 40);
        [self.contentView addSubview:_niceBtn];
        
        _pointLbl = [[UILabel alloc] initWithFrame:CGRectMake(_niceBtn.frame.origin.x + _niceBtn.frame.size.width + 80,
                                                              _titleLbl.frame.origin.y + _titleLbl.frame.size.height + 10,
                                                              40, 40)];
        _pointLbl.font = [UIFont boldSystemFontOfSize:14.0];
        _pointLbl.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_pointLbl];
        _pointLbl.backgroundColor = [UIColor lightGrayColor];
        
    }
    return self;
    
}

-(void)niceBtnTap:(UIButton*)sender
{
    //押されたボタンの順番とtopic_ID
    NSLog(@"niceBtn::%d::%@", sender.tag, sender.accessibilityIdentifier);
    
    int topic_ID = [sender.accessibilityIdentifier intValue];
    
    [[DYManager sharedManager] requestInsertUserTopicIDData:topic_ID Completion:^(BOOL flag) {
        if (flag) {
            //NSLog(@"yesyes");
        }else {
            //NSLog(@"nono");
        }
    }];
    
    [[DYManager sharedManager] updateTopicPointTopic_ID:topic_ID completion:^(BOOL flag) {
        if (flag) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTopicPoint" object:[NSNumber numberWithInt:topic_ID]];
        }else {
            
        }
    }];
    
    sender.enabled = NO;
}

-(void)refresh
{
    if (_titleLbl) {
        [_titleLbl removeFromSuperview];
        _titleLbl = nil;
    }
    /*
    if (_niceBtn) {
        [_niceBtn removeFromSuperview];
        _niceBtn = nil;
    }
    */
    
    _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, _iconImgView.frame.origin.y + _iconImgView.frame.size.height + 10
                                                          ,250, 50)];
    _titleLbl.numberOfLines = 0;
    _titleLbl.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLbl.font = [UIFont boldSystemFontOfSize:14.0];
    [self.contentView addSubview:_titleLbl];
    _titleLbl.backgroundColor = [UIColor lightGrayColor];
    
    /*
    _niceBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_niceBtn setTitle:@"nice" forState:UIControlStateNormal];
    [_niceBtn addTarget:self action:@selector(niceBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    _niceBtn.frame = CGRectMake(30, _titleLbl.frame.origin.y + _titleLbl.frame.size.height + 10, 40, 40);
    [self.contentView addSubview:_niceBtn];
     */
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end







