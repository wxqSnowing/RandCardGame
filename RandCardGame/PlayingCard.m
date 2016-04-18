//
//  PlayingCard.m
//  theThirdHomework
//
//  Created by student on 15/10/10.
//  Copyright (c) 2015年 wxq. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeInteger:self.rank forKey:@"Rank"];
    [aCoder encodeObject:self.suit forKey:@"Suit"];
    
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        self.rank = [aDecoder decodeIntegerForKey:@"Rank"];
        self.suit = [aDecoder decodeObjectForKey:@"Suit"];
    }
    return self;
}

-(int)match:(NSArray *)otherCards{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    }else if([otherCards count]==2){
        PlayingCard *firstCard=otherCards[0];
        PlayingCard *secondCard=otherCards[1];
        if ([firstCard.suit isEqualToString:secondCard.suit] && [firstCard.suit isEqualToString:self.suit]) {
            score =5;
        }else if (firstCard.rank==secondCard.rank && firstCard.rank==self.rank){
            score=10;
        }
    }
    return score;
}


-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


@synthesize suit = _suit;

-(void)setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit{
    return _suit ? _suit : @"?";
}

+(NSArray *)validSuits{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+(NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank{
    return [[self rankStrings] count]-1;
}
-(void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
@end
