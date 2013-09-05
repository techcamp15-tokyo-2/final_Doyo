//
//  DYOTLViewController.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYOTLViewController.h"
#import "DYCell.h"
#import "DYManager.h"
#import "DYModel.h"

@interface DYOTLViewController ()

@end

@implementation DYOTLViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.title = @"TL";
        self.navigationItem.title = @"タイムライン";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //self.view.backgroundColor = [UIColor redColor];
    
    
    
    //commentArray = [[NSMutableArray alloc] initWithArray:@[@"hello", @"hora!!!!", @"こんにちわーーーーー", @"もーーーーー！"]];
    
    
    
    NSArray *key1 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value1 =
    [NSArray arrayWithObjects:@"yuma", @"helloooooooooooo", nil];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjects:value1 forKeys:key1];
    
    NSArray *key2 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value2 =
    [NSArray arrayWithObjects:@"kazunori", @"horaaaaaaaaa", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjects:value2 forKeys:key2];
    
    NSArray *key3 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value3 =
    [NSArray arrayWithObjects:@"darekaaaa", @"こんにちはーーーーーーーー", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjects:value3 forKeys:key3];
    
    NSArray *key4 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value4 =
    [NSArray arrayWithObjects:@"uooooooooo", @"paoooooonnnnn", nil];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObjects:value4 forKeys:key4];
    
    NSArray *key5 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value5 =
    [NSArray arrayWithObjects:@"nayyyyyyyyyyyyyyyyyyy", @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", nil];
    NSDictionary *dic5 = [NSDictionary dictionaryWithObjects:value5 forKeys:key5];
    
    NSArray *key6 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value6 =
    [NSArray arrayWithObjects:@"uooooooooo", @"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb", nil];
    NSDictionary *dic6 = [NSDictionary dictionaryWithObjects:value6 forKeys:key6];
    
    NSArray *key7 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value7 =
    [NSArray arrayWithObjects:@"uooooooooo", @"1111111111111111111111111111111111111111111111111111111111111111111111111112222gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggl", nil];
    NSDictionary *dic7 = [NSDictionary dictionaryWithObjects:value7 forKeys:key7];
    
    NSArray *key8 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value8 =
    [NSArray arrayWithObjects:@"yuma", @" ", nil];
    NSDictionary *dic8 = [NSDictionary dictionaryWithObjects:value8 forKeys:key8];
    
    commentArray = [[NSMutableArray alloc] initWithArray:@[dic1, dic2, dic3, dic4, dic5, dic6, dic7, dic8]];
    
    
    //DYModel *model = [[DYModel alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DYTLCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[DYTLCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    else {
        [cell reflesh];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", [commentArray objectAtIndex:indexPath.row]];
    
    DYModel *model = [[DYModel alloc] initWithDictionary:[commentArray objectAtIndex:indexPath.row]];
    cell.nameLbl.text = model.nameStr;
    cell.contentLbl.text = model.contentStr;
    [cell.contentLbl sizeToFit];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     STModel *tweetModel = [modelArray objectAtIndex:indexPath.row];
     
     CGSize cellSize = [tweetModel.content sizeWithFont:[UIFont systemFontOfSize:13.0]
     constrainedToSize:CGSizeMake(320, CGFLOAT_MAX)
     lineBreakMode:NSLineBreakByWordWrapping];
     //NSLog(@"height:%d:%f", indexPath.row, cellSize.height);
     
     float height = 60.0 + cellSize.height + 35.0;
     //NSLog(@"height::%d::%f", indexPath.row, height);
     //return 410.0;
     */
    
    DYModel *model = [[DYModel alloc] initWithDictionary:[commentArray objectAtIndex:indexPath.row]];
    CGSize contentTextSize = [model.contentStr sizeWithFont:[UIFont boldSystemFontOfSize:14.0]
                                          constrainedToSize:CGSizeMake(300, SIZE_MAX)
                                              lineBreakMode:NSLineBreakByWordWrapping];
    
    NSLog(@"row:%d::height:%f", indexPath.row, contentTextSize.height);
    return contentTextSize.height + 75.0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
