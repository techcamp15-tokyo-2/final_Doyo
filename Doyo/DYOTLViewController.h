//
//  DYOTLViewController.h
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYOTLViewController : UITableViewController
{
    NSMutableArray *commentArray;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
