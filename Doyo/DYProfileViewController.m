//
//  DYProfileViewController.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYProfileViewController.h"
#import "DYManager.h"
#import <QuartzCore/QuartzCore.h>

@interface DYProfileViewController ()

@end

@implementation DYProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"ぷろふぃーる";
        self.navigationItem.title = @"profile";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
    

    NSString *userID = [DYManager sharedManager].userID;
    NSString *name = [DYManager sharedManager].name;
    NSString *iconImgStr = [DYManager sharedManager].iconImgStr;
    NSLog(@"userID:%@__name:%@__iconImg:%@", userID, name, iconImgStr);
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 300, 100)];
    bgview.backgroundColor = [UIColor whiteColor];
    bgview.layer.cornerRadius = 10.0;
    bgview.clipsToBounds = YES;
    [_scrollView addSubview:bgview];
    
    _iconImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconImgStr]]];
    
    [self.view bringSubviewToFront:_iconImg];
    UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(140, 35, 150, 30)];
    nameLbl.text = name;
    nameLbl.backgroundColor = [UIColor lightGrayColor];
    nameLbl.font = [UIFont systemFontOfSize:14.0];
    nameLbl.textAlignment = NSTextAlignmentCenter;
    nameLbl.layer.cornerRadius = 5.0;
    nameLbl.clipsToBounds = YES;
    
    _iconImg.layer.cornerRadius = _iconImg.frame.size.width / 2.0;
    _iconImg.clipsToBounds = YES;
    [_scrollView bringSubviewToFront:_iconImg];
    [_scrollView addSubview:nameLbl];
    
    UILabel *userIDLbl = [[UILabel alloc] initWithFrame:CGRectMake(140, nameLbl.frame.origin.y + nameLbl.frame.size.height + 10,
                                                                   150, 30)];
    userIDLbl.text = userID;
    userIDLbl.backgroundColor = [UIColor lightGrayColor];
    userIDLbl.font = [UIFont systemFontOfSize:14.0];
    userIDLbl.textAlignment = NSTextAlignmentCenter;
    userIDLbl.layer.cornerRadius = 5.0;
    userIDLbl.clipsToBounds = YES;
    [_scrollView addSubview:userIDLbl];
    
    _profImgView.image = [UIImage imageNamed:@"profile"];
    
    _scrollView.frame = self.view.frame;
    _scrollView.contentSize = CGSizeMake(320, 400);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
