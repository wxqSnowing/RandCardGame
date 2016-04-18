//
//  Card.m
//  theThirdHomework
//
//  Created by student on 15/10/10.
//  Copyright (c) 2015年 wxq. All rights reserved.
//

#import "Card.h"
@interface Card()

@end

@implementation Card

-(NSString *)description{
    return self.contents;
}

-(int)match:(NSArray *)otherCards
{
    int score=0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeBool:self.isMatched forKey:@"Machted"];
    [aCoder encodeBool:self.isChosen  forKey:@"Chosed"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self){
        self.matched = [aDecoder decodeBoolForKey:@"Machted"];
        self.chosen = [aDecoder decodeBoolForKey:@"Chosed"];
    }
    return self;
}

@end
