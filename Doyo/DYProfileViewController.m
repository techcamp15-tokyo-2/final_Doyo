//
//  DYProfileViewController.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYProfileViewController.h"
#import "DYManager.h"

@interface DYProfileViewController ()

@end

@implementation DYProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"profile";
        self.navigationItem.title = @"profile";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    NSString *userID = [DYManager sharedManager].userID;
    NSString *name = [DYManager sharedManager].name;
    NSString *iconImgStr = [DYManager sharedManager].iconImgStr;
    NSLog(@"userID:%@__name:%@__iconImg:%@", userID, name, iconImgStr);
    
    _iconImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconImgStr]]];
    UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(140, 35, 150, 30)];
    nameLbl.text = name;
    nameLbl.backgroundColor = [UIColor lightGrayColor];
    nameLbl.font = [UIFont systemFontOfSize:14.0];
    nameLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameLbl];
    
    UILabel *userIDLbl = [[UILabel alloc] initWithFrame:CGRectMake(140, nameLbl.frame.origin.y + nameLbl.frame.size.height + 10,
                                                                   150, 30)];
    userIDLbl.text = userID;
    userIDLbl.backgroundColor = [UIColor lightGrayColor];
    userIDLbl.font = [UIFont systemFontOfSize:14.0];
    userIDLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:userIDLbl];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
