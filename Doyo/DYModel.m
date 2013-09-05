//
//  DYModel.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYModel.h"

@implementation DYModel

-(id)init
{
    self = [super init];
    if (self) {
        
        
    }
    
    return self;
}

-(id)initWithDictionary:(NSDictionary *)d
{
    self = [super init];
    if (self) {
        
        _iconImg = [UIImage imageNamed:[d objectForKey:@"iconImg"]];
        _nameStr = [d objectForKey:@"name"];
        _contentStr = [d objectForKey:@"content"];
        
    }
    return self;
}

@end
