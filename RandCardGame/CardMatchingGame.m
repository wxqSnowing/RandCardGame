//
//  CardMatchingGame.m
//  theThirdHomework
//
//  Created by student on 15/10/21.
//  Copyright (c) 2015年 wxq. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.score forKey:@"Score"];
    [aCoder encodeInteger:self.gameMode forKey:@"GameMode"];
    
    [aCoder encodeObject:self.cards forKey:@"Cards"];
    [aCoder encodeObject:self.playHistory forKey:@"PlayHistory"];
    [aCoder encodeObject:self.startDate forKey:@"StartDate"];
    [aCoder encodeObject:self.endDate forKey:@"EndDate"];
    
    
    
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.score = [aDecoder decodeIntegerForKey:@"Score"];
        self.gameMode =(int) [aDecoder decodeIntegerForKey:@"GameMode"];
        self.cards = [aDecoder decodeObjectForKey:@"Cards"];
        self.playHistory = [aDecoder decodeObjectForKey:@"PlayHistory"];
        self.startDate = [aDecoder decodeObjectForKey:@"StartDate"];
        self.endDate = [aDecoder decodeObjectForKey:@"EndDate"];
    }
    return self;
}
-(NSMutableArray *)cards{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}
-(NSMutableArray *)playHistory{
    if (!_playHistory) {
        _playHistory=[[NSMutableArray alloc] init];
        _startDate = [NSDate date];
    }
    return _playHistory;
}
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super init];
    
    if (self) {
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index{
    return (index<[self.cards count]) ? self.cards[index]:nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


-(void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        NSString *lastState=[NSString stringWithFormat:@"%s %@",card.isChosen?"Flip Down":"Flip Up", card];
        if (card.isChosen) {
            card.chosen = NO;
        }else{
            //游戏逻辑部分：做具体匹配工作
            Card *firstCard=nil;
            Card *secondCard=nil;
            switch (self.gameMode) {
                case 0:
                    //第一种游戏 2张牌的游戏
                    //match against other chosen cards
                    for (Card *otherCard in self.cards) {
                        if (otherCard.isChosen && !otherCard.isMatched) {
                            int matchScore = [card match:@[otherCard]];
                            if (matchScore) {
                                self.score += matchScore * MATCH_BONUS;
                                otherCard.matched = YES;
                                card.matched = YES;
                                lastState=[NSString stringWithFormat:@"Matched %@ and %@ for %d points",card,otherCard,matchScore];
                            }else{
                                self.score -= MISMATCH_PENALTY;
                                otherCard.chosen = NO;
                                lastState=[NSString stringWithFormat:@"%@ and %@ don't match,%d point penalty",card,otherCard,matchScore];
                            }
                            break;
                        }
                    }
                    break;
                    
                case 1:
                    //第二种游戏 3张牌的游戏（困难，需要三种同时匹配）
                    for (Card *otherCard in self.cards) {
                        if (otherCard.isChosen && !otherCard.isMatched) {
                            if (!firstCard) firstCard=otherCard;
                            if (firstCard!=otherCard) secondCard=otherCard;
                            if (secondCard) {
                                int matchScore=[card match:@[firstCard,secondCard]];
                                
                                if (matchScore) {
                                    firstCard.matched=YES;
                                    secondCard.matched=YES;
                                    card.matched=YES;
                                    self.score += matchScore * MATCH_BONUS;
                                    lastState=[NSString stringWithFormat:@"Matched %@,%@ and %@ for %d points",card,firstCard,secondCard,matchScore];
                                }else{
                                    firstCard.chosen = NO;
                                    secondCard.chosen=NO;
                                    self.score += matchScore * MISMATCH_PENALTY;
                                    lastState=[NSString stringWithFormat:@"%@,%@ and %@ don't match,%d point penalty",card,firstCard,secondCard,matchScore];
                                }
                                break;
                            }
                        }
                    }
                    break;
                default:
                    break;
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            
        }
        [self.playHistory addObject:lastState];
    }
}

@end
