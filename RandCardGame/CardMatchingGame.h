//
//  CardMatchingGame.h
//  theThirdHomework
//
//  Created by student on 15/10/21.
//  Copyright (c) 2015年 wxq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject <NSCoding>


-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) NSInteger score;
@property (nonatomic) int gameMode;
@property (nonatomic,strong) NSMutableArray *playHistory;

@property (nonatomic,strong) NSDate *startDate;
@property (nonatomic,strong) NSDate *endDate;


@end
