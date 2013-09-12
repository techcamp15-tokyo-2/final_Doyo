//
//  DYLogContentViewController.h
//  Doyo
//
//  Created by 小田 祐万 on 13/09/10.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYLogContentViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *timeLineArray;
    
    NSString *userID;
}

@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@property (nonatomic, weak) NSString *topicID;
@property (nonatomic, weak) NSString *topicTitle;

@end
