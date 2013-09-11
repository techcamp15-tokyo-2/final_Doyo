//
//  DYLogViewController.h
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYLogViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    int segNum;
    
    NSMutableArray *newArray;
    NSMutableArray *rankingArray;
    
    UILabel *refreshLabel;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
    BOOL isLoading;
    BOOL isDragging;
    UIView *refreshHeaderView;
    UIActivityIndicatorView *refreshSpinner;
    
    //NSMutableArray *alredyBtnArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
