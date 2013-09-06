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
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
