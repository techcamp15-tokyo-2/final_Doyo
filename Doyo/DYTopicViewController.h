//
//  DYTopicViewController.h
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYTopicViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    int segNum;
    
    NSMutableArray *newArray;
    NSMutableArray *rankingArray;
    
    BOOL isLoading;
    BOOL isDragging;
    
    UIView *refreshHeaderView;
    UIActivityIndicatorView *refreshSpinner;
    
    NSMutableArray *BtnArray;
    NSMutableArray *alredyBtnArray;
    
    UILabel *refreshLabel;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property BOOL isPostFlag;

@end
