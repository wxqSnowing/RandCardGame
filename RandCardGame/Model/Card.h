//
//  Card.h
//  theThirdHomework
//
//  Created by student on 15/10/10.
//  Copyright (c) 2015年 wxq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject <NSCoding>
@property (strong,nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

-(int)match:(NSArray *)otherCards;


@end
