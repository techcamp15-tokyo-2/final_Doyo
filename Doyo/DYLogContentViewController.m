//
//  DYLogContentViewController.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/10.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYLogContentViewController.h"
#import "DYManager.h"
#import "DYModel.h"
#import "DYCell.h"
#import <QuartzCore/QuartzCore.h>

@interface DYLogContentViewController ()

@end

@implementation DYLogContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    userID = [DYManager sharedManager].userID;
    
    //_label.text = _topicID;
    NSLog(@"topic_ID::%d", [_topicID intValue]);
    NSLog(@"topic_title:%@", _topicTitle);
    
    timeLineArray = [NSMutableArray array];
    [[DYManager sharedManager] requestLogPushDataTopic_ID:[_topicID intValue] Completion:^(BOOL success, NSArray *array) {
        if (success) {
            [timeLineArray addObjectsFromArray:array];
            [_tabelView reloadData];
            NSLog(@"%d", timeLineArray.count);
            /*
            if (timeLineArray.count > 0) {
                for (DYModel *model in timeLineArray) {
                    NSLog(@"%@", model.contentStr);
                }
            }
             */
        }
    }];
    
    //tableView
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.separatorColor = [UIColor clearColor];
    _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tabelView.backgroundColor = [UIColor clearColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0;
    view.clipsToBounds = YES;
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, -5, 280, 30)];
    lbl.backgroundColor = [UIColor clearColor];
    //lbl.text = @"ガソリンスタンドの溝ってなんなのよ？";
    lbl.font = [UIFont boldSystemFontOfSize:14.0];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor darkGrayColor];
    [view addSubview:lbl];
    
    
    
    lbl.text = _topicTitle;
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count:%d", timeLineArray.count);
    return timeLineArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DYManager *m = [timeLineArray objectAtIndex:indexPath.row];
    
    
    if ([m.userID isEqualToString:userID]) {
        //自分のcell
        static NSString *CellIdentifier = @"myCell";
        DYTLCell *myCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!myCell) {
            myCell = [[DYTLCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        else {
            [myCell reflesh];
        }
        
        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        DYModel *model = [timeLineArray objectAtIndex:indexPath.row];
        myCell.iconImgView.image = model.iconImg;
        //NSLog(@"iconImg:%@", cell.iconImgView.image);
        myCell.nameLbl.text = model.nameStr;
        myCell.contentLbl.text = model.contentStr;
        
        [myCell.contentLbl sizeToFit];
        //NSLog(@"frame:%f::%f", cell.contentLbl.frame.origin.x, cell.contentLbl.frame.size.width);
        myCell.contentLbl.frame = CGRectMake(320 - 60 - myCell.contentLbl.frame.size.width,
                                             myCell.iconImgView.frame.origin.y + myCell.iconImgView.frame.size.height - 5,
                                             myCell.contentLbl.frame.size.width,
                                             myCell.contentLbl.frame.size.height);
        
        
        myCell.bgImgView.frame = CGRectMake(myCell.contentLbl.frame.origin.x - 5,
                                            myCell.contentLbl.frame.origin.y - 5,
                                            myCell.contentLbl.frame.size.width + 25,
                                            myCell.contentLbl.frame.size.height + 10);
        
        return myCell;
        
    }else {
        //他人のcell
        static NSString *CellIdentifier = @"otherCell";
        DYOtherTLCell *otherCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!otherCell) {
            otherCell = [[DYOtherTLCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        else {
            [otherCell reflesh];
        }
        
        otherCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        DYModel *model = [timeLineArray objectAtIndex:indexPath.row];
        otherCell.iconImgView.image = model.iconImg;
        //NSLog(@"iconImg:%@", otherCell.iconImgView.image);
        otherCell.nameLbl.text = model.nameStr;
        otherCell.contentLbl.text = model.contentStr;
        
        [otherCell.contentLbl sizeToFit];
        //NSLog(@"frame:%f::%f", cell.contentLbl.frame.origin.x, cell.contentLbl.frame.size.width);
        otherCell.contentLbl.frame = CGRectMake(59,
                                                otherCell.iconImgView.frame.origin.y + otherCell.iconImgView.frame.size.height - 5,
                                                otherCell.contentLbl.frame.size.width,
                                                otherCell.contentLbl.frame.size.height);
        
        otherCell.bgImgView.frame = CGRectMake(otherCell.contentLbl.frame.origin.x - 19,
                                               otherCell.contentLbl.frame.origin.y - 5,
                                               otherCell.contentLbl.frame.size.width + 25,
                                               otherCell.contentLbl.frame.size.height + 10);
        
        
        
        return otherCell;
    }
    
    
    //return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    DYModel *model = [timeLineArray objectAtIndex:indexPath.row];
    CGSize contentTextSize = [model.contentStr sizeWithFont:[UIFont boldSystemFontOfSize:12.0]
                                          constrainedToSize:CGSizeMake(170, SIZE_MAX)
                                              lineBreakMode:NSLineBreakByWordWrapping];
    return contentTextSize.height + 50.0;
    
     
}


@end
