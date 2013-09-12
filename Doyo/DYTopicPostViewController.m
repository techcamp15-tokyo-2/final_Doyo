//
//  DYTopicPostViewController.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYTopicPostViewController.h"
#import "DYManager.h"
#import "DYTopicViewController.h"

@interface DYTopicPostViewController ()

@end

@implementation DYTopicPostViewController

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
    /*
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [dismissBtn setTitle:@"dismiss" forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@"dismissView" forControlEvents:UIControlEventTouchUpInside];
    dismissBtn.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    */
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    
    //self.view.backgroundColor = [UIColor greenColor];
    
    //toolbar
    //UIToolbar *toolBar = [ [ UIToolbar alloc ] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //[self.view addSubview:toolBar];
    
    //キャンセルポタン
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"cansel" style:UIBarButtonItemStyleBordered target:self action:@selector(canselBtnTap)];
    cancelBtn.tintColor = [UIColor colorWithRed:246.0/255.0 green:129.0/255.0 blue:35.0/255.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
    
    //投稿ボタン
    postBtn = [[UIBarButtonItem alloc] initWithTitle:@"post" style:UIBarButtonItemStyleBordered target:self action:@selector(postBtnTap)];
    postBtn.tintColor = [UIColor colorWithRed:246.0/255.0 green:129.0/255.0 blue:35.0/255.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = postBtn;
    //初期ではpostBtnは押せない
    postBtn.enabled = NO;
    
    //textView
    _textView.delegate = self;
    _textView.text = @"";
    _textView.editable = YES;
    _textView.keyboardType = UIKeyboardTypeDefault;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    if (![_textView isFirstResponder]) {
        [_textView becomeFirstResponder];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_textView resignFirstResponder];
}

-(void)canselBtnTap
{
    //キャンセル時
    //DYTopicViewController *viewCtl = [[DYTopicViewController alloc] init];
    //viewCtl.isPostFlag = YES;
    [DYManager sharedManager].isPostFlag = NO;
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

-(void)postBtnTap
{
    NSLog(@"postStr:%@", _textView.text);
    
    [[DYManager sharedManager] requestInsertTopicData:_textView.text Completion:^(BOOL flag) {
        if (flag) {
            [DYManager sharedManager].isPostFlag = YES;
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else {
            NSLog(@"topicInsertError");
        }
    }];
    
    /*
    //投稿時
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textView delegate
/*
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
*/
/*
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //postStr = [NSString stringWithFormat:@"%@", _textView.text];
    //NSLog(@"commentPostStr:%@", postStr);
    
    return YES;
}
*/
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    //postStr = [NSString stringWithFormat:@"%@", _textView.text];
    //NSLog(@"topicPostStr:%@", postStr);
    
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
    //NSLog(@"strCount:%d", strCount);
    
    if (_textView.text.length <= 0 || _textView.text.length > 80) {
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
    
    if (_textView.text.length <= 0 || _textView.text.length > 80) {
        postBtn.enabled = NO;
    }else {
        postBtn.enabled = YES;
    }
    
    //[postBtn setEnabled:_textField.text.length > 0 && _textField.text.length > 0];
}


@end
