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

- (void)encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_nameStr forKey:@"_nameStr"];
	[coder encodeObject:_contentStr forKey:@"_contentStr"];
    [coder encodeObject:_iconImg forKey:@"_iconImg"];
    [coder encodeObject:_iconImg forKey:@"_userID"];
    
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _nameStr = [coder decodeObjectForKey:@"_nameStr"];
		_contentStr = [coder decodeObjectForKey:@"_contentStr"];
        //date_str = [coder decodeObjectForKey:@"date_str"];
        _iconImg = [coder decodeObjectForKey:@"_iconImg"];
        _iconImg = [coder decodeObjectForKey:@"_userID"];
        
        
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
