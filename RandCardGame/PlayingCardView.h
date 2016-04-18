//
//  PlayingCardView.h
//  theThirdHomework
//
//  Created by WXQ on 15/12/17.
//  Copyright © 2015年 wxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIButton

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL chosen;
@property (nonatomic) BOOL matched;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
