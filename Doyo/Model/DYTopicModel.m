//
//  DYTopicModel.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/06.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYTopicModel.h"

@implementation DYTopicModel

-(id)init
{
    self = [super init];
    if (self) {
        
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_nameStr forKey:@"_nameStr"];
	[coder encodeObject:_titleStr forKey:@"_titleStr"];
    [coder encodeObject:[NSNumber numberWithInt:_point] forKey:@"_point"];
    [coder encodeObject:_iconImgStr forKey:@"_iconImgStr"];
    [coder encodeObject:_iconImg forKey:@"_iconImg"];
    [coder encodeObject:_topicIDStr forKey:@"_topicIDStr"];
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _nameStr = [coder decodeObjectForKey:@"_nameStr"];
		_titleStr = [coder decodeObjectForKey:@"_titleStr"];
        _point = [[coder decodeObjectForKey:@"_point"] intValue];
        _iconImgStr = [coder decodeObjectForKey:@"_iconImgStr"];
        _iconImg = [coder decodeObjectForKey:@"_iconImg"];
        _topicIDStr = [coder decodeObjectForKey:@"_topicIDStr"];
        
    }
    return self;
}

@end
