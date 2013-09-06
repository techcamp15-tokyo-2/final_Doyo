//
//  DYTextView.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/06.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYTextView.h"

@implementation DYTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UIView *)inputAccessoryView
{
    [super inputAccessoryView];
    
    inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    inputView.backgroundColor = [UIColor cyanColor];
    inputView.userInteractionEnabled = YES;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 2.5, 240, 30)];
    textView.backgroundColor = [UIColor redColor];
    textView.delegate = self;
    textView.textAlignment = NSTextAlignmentLeft;
    //_textField.clipsToBounds = NO;
    textView.keyboardType = UIKeyboardTypeDefault;
    textView.text = @"hello";
    [inputView addSubview:textView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"hello" forState:UIControlStateNormal];
    btn.frame = CGRectMake(260, 2.5, 50, 30);
    
    
    
    return inputView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
