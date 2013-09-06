//
//  DYTLViewController.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/06.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYTLViewController.h"
#import "DYCell.h"
#import "DYManager.h"
#import "DYModel.h"
#import "DYCommentPostViewController.h"

@interface DYTLViewController ()

@end

@implementation DYTLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
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
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    /*
    NSArray *key1 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value1 =
    [NSArray arrayWithObjects:@"yuma", @"helloooooooooooo", nil];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjects:value1 forKeys:key1];
    */
    
    DYModel *model1 = [[DYModel alloc] init];
    model1.nameStr = @"yuma";
    model1.contentStr = @"helloooooooooooo";
    /*
    NSArray *key2 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value2 =
    [NSArray arrayWithObjects:@"kazunori", @"horaaaaaaaaa", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjects:value2 forKeys:key2];
    */
    DYModel *model2 = [[DYModel alloc] init];
    model2.nameStr = @"kazunori";
    model2.contentStr = @"horaaaaaaaaa";
    /*
    NSArray *key3 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value3 =
    [NSArray arrayWithObjects:@"darekaaaa", @"こんにちはーーーーーーーー", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjects:value3 forKeys:key3];
    */
    DYModel *model3 = [[DYModel alloc] init];
    model3.nameStr = @"darekaaaa";
    model3.contentStr = @"こんにちはーーーーーーーー";
    /*
    NSArray *key4 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value4 =
    [NSArray arrayWithObjects:@"uooooooooo", @"paoooooonnnnn", nil];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObjects:value4 forKeys:key4];
    */
    DYModel *model4 = [[DYModel alloc] init];
    model4.nameStr = @"uooooooooo";
    model4.contentStr = @"paoooooonnnnnーーーーーーーー";
    /*
    NSArray *key5 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value5 =
    [NSArray arrayWithObjects:@"nayyyyyyyyyyyyyyyyyyy", @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", nil];
    NSDictionary *dic5 = [NSDictionary dictionaryWithObjects:value5 forKeys:key5];
    */
    DYModel *model5 = [[DYModel alloc] init];
    model5.nameStr = @"nayyyyyyyyyyyyyyyyyyy";
    model2.contentStr = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    
    /*
    NSArray *key6 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value6 =
    [NSArray arrayWithObjects:@"uooooooooo", @"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb", nil];
    NSDictionary *dic6 = [NSDictionary dictionaryWithObjects:value6 forKeys:key6];
    */
    
    DYModel *model6 = [[DYModel alloc] init];
    model6.nameStr = @"kazunori";
    model6.contentStr = @"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb";
    /*
    NSArray *key7 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value7 =
    [NSArray arrayWithObjects:@"uooooooooo", @"1111111111111111111111111111111111111111111111111111111111111111111111111112222gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggl", nil];
    NSDictionary *dic7 = [NSDictionary dictionaryWithObjects:value7 forKeys:key7];
    */
    DYModel *model7 = [[DYModel alloc] init];
    model7.nameStr = @"kazunori";
    model7.contentStr = @"1111111111111111111111111111111111111111111111111111111111111111111111111112222gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggl";
    /*
    NSArray *key8 = [NSArray arrayWithObjects:@"name", @"content", nil];
    NSArray *value8 =
    [NSArray arrayWithObjects:@"yuma", @" ", nil];
    NSDictionary *dic8 = [NSDictionary dictionaryWithObjects:value8 forKeys:key8];
    */
    DYModel *model8 = [[DYModel alloc] init];
    model8.nameStr = @"kazunori";
    model8.contentStr = @"foooooooooooooo";
    
    
    commentArray = [[NSMutableArray alloc] initWithArray:@[model1, model2, model3, model4, model5, model6, model7, model8]];
    
    [self createArray];
    
    
    //DYModel *model = [[DYModel alloc] init];
    /*
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"post" style:UIBarButtonItemStyleBordered target:self action:@selector(showPostCtl)];
    self.navigationItem.rightBarButtonItem = btn;
    */
    //pull to refresh
    /*
     refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
     refreshSpinner.frame = CGRectMake(floorf(floorf(50 - 20) / 2), floorf((50 - 20) / 2), 20, 20);
     refreshSpinner.hidesWhenStopped = YES;
     refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
     refreshView.backgroundColor = [UIColor grayColor];
     [refreshView addSubview:refreshSpinner];
     
     [_tableView addSubview:refreshView];
     [_tableView sendSubviewToBack:refreshView];
     _tableView.tableFooterView = refreshView;
     _tableView.contentInset = UIEdgeInsetsMake(0, 0, -50, 0);
     */
    
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 459, 320, 40)];
    bottomView.backgroundColor = [UIColor cyanColor];
    bottomView.userInteractionEnabled = YES;
    
    _textField = [[UITextView alloc] init];
    _textField.frame = CGRectMake(10, 2.5, 240, 35);
    _textField.backgroundColor = [UIColor redColor];
    _textField.delegate = self;
    //textField.font = [];
    _textField.textAlignment = NSTextAlignmentLeft;
    //_textField.clipsToBounds = NO;
    _textField.keyboardType = UIKeyboardTypeDefault;
    [bottomView addSubview:_textField];
    
    postBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    postBtn.frame = CGRectMake(260, 2.5, 50, 30);
    [postBtn setTitle:@"post" forState:UIControlStateNormal];
    [postBtn addTarget:self action:@selector(commentPost) forControlEvents:UIControlEventTouchUpInside];
    postBtn.enabled = NO;
    
    [bottomView addSubview:postBtn];
    
    [self.view addSubview:bottomView];
    
    _textField.inputAccessoryView = bottomView;
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    //inputAccessoryView
    
    /*
    UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    postBtn.frame = CGRectMake(260, 2.5, 50, 30);
    [postBtn setTitle:@"post" forState:UIControlStateNormal];
    [postBtn addTarget:self action:@selector(commentPost) forControlEvents:UIControlEventTouchUpInside];
     */
    //[self.view addSubview:postBtn];
    //[self.view bringSubviewToFront:postBtn];
    
    /*
     inputTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 2.5, 240, 30)];
     inputTextView.backgroundColor = [UIColor blueColor];
     inputTextView.delegate = self;
     inputTextView.textAlignment = NSTextAlignmentLeft;
     //_textField.clipsToBounds = NO;
     inputTextView.keyboardType = UIKeyboardTypeDefault;
     */
    
    /*
    UIView *inputView = [[UIView alloc] init];
    //postView.tag = 100;
    //CGSize size = [UIScreen mainScreen].bounds.size;
    inputView.frame = CGRectMake(0, 420, 320, 35);
    inputView.backgroundColor = [UIColor cyanColor];
    inputView.userInteractionEnabled = YES;
    //[self.view addSubview:postView];
    
    [inputView addSubview:postBtn];
    [inputView addSubview:_textField];
    */
    
    //_textField.inputAccessoryView = bottomView;
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    //singleTap.delegate = self;
    singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTap];
}

-(void)createArray
{
    //array1 = [[NSMutableArray alloc] init];
    array2 = [[NSMutableArray alloc] init];
    array3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        DYModel *model = [[DYModel alloc] init];
        model.nameStr = [NSString stringWithFormat:@"%d君", i];
        model.contentStr = [NSString stringWithFormat:@"%dだよ", i];
        [array2 addObject:model];
    }
    
    for (int i = 0; i < 7; i++) {
        DYModel *model = [[DYModel alloc] init];
        model.nameStr = [NSString stringWithFormat:@"%dちゃん", i];
        model.contentStr = [NSString stringWithFormat:@"%dざます", i];
        [array3 addObject:model];
    }
    
}

-(void)onSingleTap:(UITapGestureRecognizer *)recognizer
{
    if (![_textField isFirstResponder]) {
        if (isEditing) {
            [_textField becomeFirstResponder];
        }
    
    }

    [_textField resignFirstResponder];
    //NSLog(@"tap");
//    [self.view resignFirstResponder];
    
    //bottom投稿再配置
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 459, 320, 40)];
    bottomView.backgroundColor = [UIColor cyanColor];
    bottomView.userInteractionEnabled = YES;
    
    _textField = [[UITextView alloc] init];
    _textField.frame = CGRectMake(10, 2.5, 240, 35);
    _textField.backgroundColor = [UIColor redColor];
    _textField.delegate = self;
    //textField.font = [];
    _textField.textAlignment = NSTextAlignmentLeft;
    //_textField.clipsToBounds = NO;
    _textField.keyboardType = UIKeyboardTypeDefault;
    [bottomView addSubview:_textField];
    
    postBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    postBtn.frame = CGRectMake(260, 2.5, 50, 30);
    [postBtn setTitle:@"post" forState:UIControlStateNormal];
    [postBtn addTarget:self action:@selector(commentPost) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:postBtn];
    postBtn.enabled = NO;
    
    [self.view addSubview:bottomView];
    
    _textField.inputAccessoryView = bottomView;
    
    
}


-(void)commentPost
{
    //NSLog(@"commentPost");
    
    
    //[self.navigationController disablesAutomaticKeyboardDismissal];
    //[self disablesAutomaticKeyboardDismissal];
    
    NSLog(@"%d", [_textField isFirstResponder]);
    if (![_textField isFirstResponder]) {
        [_textField becomeFirstResponder];
    }
    [_textField resignFirstResponder];
    
    
    //bottom投稿再配置
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 459, 320, 40)];
    bottomView.backgroundColor = [UIColor cyanColor];
    bottomView.userInteractionEnabled = YES;
    
    _textField = [[UITextView alloc] init];
    _textField.frame = CGRectMake(10, 2.5, 240, 35);
    _textField.backgroundColor = [UIColor redColor];
    _textField.delegate = self;
    //textField.font = [];
    _textField.textAlignment = NSTextAlignmentLeft;
    //_textField.clipsToBounds = NO;
    _textField.keyboardType = UIKeyboardTypeDefault;
    [bottomView addSubview:_textField];
    
    postBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    postBtn.frame = CGRectMake(260, 2.5, 50, 30);
    [postBtn setTitle:@"post" forState:UIControlStateNormal];
    [postBtn addTarget:self action:@selector(commentPost) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:postBtn];
    
    postBtn.enabled = NO;
    
    [self.view addSubview:bottomView];
    
    _textField.inputAccessoryView = bottomView;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*右上投稿ポタン
-(void)showPostCtl
{
    DYCommentPostViewController *viewCtl = [[DYCommentPostViewController alloc] initWithNibName:@"DYCommentPostViewController" bundle:nil];
    [self presentViewController:viewCtl animated:YES completion:^{
        
    }];
}
*/


#pragma mark - UITextViewDelegate


- (void)textViewDidBeginEditing:(UITextView *)textView
{
   
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (!isEditing) {
        isEditing = YES;
    }else {
        isEditing = NO;
    }
    
    commentPostStr = [NSString stringWithFormat:@"%@", _textField.text];
    NSLog(@"commentPostStr:%@", commentPostStr);
    
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // 入力済みのテキストを取得
    NSMutableString *str = [textView.text mutableCopy];
    // 入力済みのテキストと入力が行われたテキストを結合
    [str replaceCharactersInRange:range withString:text];
    
    //EPLog(@"length2::%d", str.length);
    
    /*
    if (textView.tag == 0) {
        int strCount = MIN(str.length, TitleMaxCount);
        _fieldStrCntLbl.text = [NSString stringWithFormat:@"%d", strCount];
        _titleCountLabel.count = strCount;
    }else if (textView.tag == 1) {
        int strCount = MIN(str.length, BodyMaxCount);
        _strCountLbl.text = [NSString stringWithFormat:@"%d", strCount];
        _bodyCountLabel.count = strCount;
    }*/
    
    int strCount = MIN(str.length, 80);
    NSLog(@"strCount:%d", strCount);
    
    if (_textField.text.length <= 0 || _textField.text.length > 80) {
        postBtn.enabled = NO;
    }else {
        postBtn.enabled = YES;
    }
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    
    NSMutableString *str = [textView.text mutableCopy];
    
    /*
    if (textView.tag == 0) {
        if(str.length > TitleMaxCount){
            textView.text = [str substringToIndex:TitleMaxCount];
        }
    }else if (textView.tag == 1) {
        if(str.length > BodyMaxCount){
            textView.text = [str substringToIndex:BodyMaxCount];
        }
    }
    */
    
    if(str.length > 80){
        textView.text = [str substringToIndex:80];
    }
    
    if (_textField.text.length <= 0 || _textField.text.length > 80) {
        postBtn.enabled = NO;
    }else {
        postBtn.enabled = YES;
    }
    
    //[postBtn setEnabled:_textField.text.length > 0 && _textField.text.length > 0];
}



#pragma mark - Table view data source

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        view.backgroundColor = [UIColor redColor];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, -5, 280, 30)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.text = @"ガソリンスタンドの溝ってなんなのよ？";
        lbl.font = [UIFont boldSystemFontOfSize:14.0];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor whiteColor];
        [view addSubview:lbl];
        return view;
    }else if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        view.backgroundColor = [UIColor blueColor];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, -5, 280, 30)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.text = @"剛力あやめどうよ？";
        lbl.font = [UIFont boldSystemFontOfSize:14.0];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor whiteColor];
        [view addSubview:lbl];
        return view;
    }else if (section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        view.backgroundColor = [UIColor brownColor];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, -5, 280, 30)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.text = @"オリンピックどうよ？";
        lbl.font = [UIFont boldSystemFontOfSize:14.0];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor whiteColor];
        [view addSubview:lbl];

        return view;
    }else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        view.backgroundColor = [UIColor blackColor];
        return view;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return commentArray.count;
            break;
        case 1:
            return array2.count;
            break;
        case 2:
            return array3.count;
            break;
        default:
            break;
    }
    
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
    
    switch (indexPath.section) {
        case 0:
        {
            DYModel *model = [commentArray objectAtIndex:indexPath.row];
            cell.nameLbl.text = model.nameStr;
            cell.contentLbl.text = model.contentStr;
            [cell.contentLbl sizeToFit];
        }
            break;
        case 1:
        {
            DYModel *model = [array2 objectAtIndex:indexPath.row];
            cell.nameLbl.text = model.nameStr;
            cell.contentLbl.text = model.contentStr;
            [cell.contentLbl sizeToFit];
            break;
        }
        case 2:
        {
            DYModel *model = [array3 objectAtIndex:indexPath.row];
            cell.nameLbl.text = model.nameStr;
            cell.contentLbl.text = model.contentStr;
            [cell.contentLbl sizeToFit];
            break;
        }
        default:
            break;
    }
    
    /*
    DYModel *model = [commentArray objectAtIndex:indexPath.row];
    cell.nameLbl.text = model.nameStr;
    cell.contentLbl.text = model.contentStr;
    [cell.contentLbl sizeToFit];
    */
    
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
    
    switch (indexPath.section) {
        case 0:
        {
            DYModel *model = [commentArray objectAtIndex:indexPath.row];
            CGSize contentTextSize = [model.contentStr sizeWithFont:[UIFont boldSystemFontOfSize:14.0]
                                                  constrainedToSize:CGSizeMake(300, SIZE_MAX)
                                                      lineBreakMode:NSLineBreakByWordWrapping];
            
            //NSLog(@"row:%d::height:%f", indexPath.row, contentTextSize.height);
            return contentTextSize.height + 70.0;
            break;
        }
        case 1:
        {
            DYModel *model = [array2 objectAtIndex:indexPath.row];
            CGSize contentTextSize = [model.contentStr sizeWithFont:[UIFont boldSystemFontOfSize:14.0]
                                                  constrainedToSize:CGSizeMake(300, SIZE_MAX)
                                                      lineBreakMode:NSLineBreakByWordWrapping];
            
            //NSLog(@"row:%d::height:%f", indexPath.row, contentTextSize.height);
            return contentTextSize.height + 70.0;
            break;
        }
        case 2:
        {
            DYModel *model = [array3 objectAtIndex:indexPath.row];
            CGSize contentTextSize = [model.contentStr sizeWithFont:[UIFont boldSystemFontOfSize:14.0]
                                                  constrainedToSize:CGSizeMake(300, SIZE_MAX)
                                                      lineBreakMode:NSLineBreakByWordWrapping];
            
            //NSLog(@"row:%d::height:%f", indexPath.row, contentTextSize.height);
            return contentTextSize.height + 70.0;
            break;

        }
        default:
            return 100.0;
            break;
    }
    /*
    DYModel *model = [commentArray objectAtIndex:indexPath.row];
    CGSize contentTextSize = [model.contentStr sizeWithFont:[UIFont boldSystemFontOfSize:14.0]
                                          constrainedToSize:CGSizeMake(300, SIZE_MAX)
                                              lineBreakMode:NSLineBreakByWordWrapping];
    
    //NSLog(@"row:%d::height:%f", indexPath.row, contentTextSize.height);
    return contentTextSize.height + 70.0;
     */
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
