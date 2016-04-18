//
//  Deck.h
//  theThirdHomework
//
//  Created by student on 15/10/10.
//  Copyright (c) 2015年 wxq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;
@end
