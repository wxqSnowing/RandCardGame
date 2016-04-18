//
//  ViewController.m
//  theThirdHomework
//
//  Created by student on 15/9/30.
//  Copyright (c) 2015年 wxq. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"
#import "GameHistoryTableViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong,nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *lastStateLabel;
@property (strong, nonatomic) IBOutletCollection(PlayingCardView) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchSegment;
@property (weak, nonatomic) IBOutlet UISlider *playHistroySlider;
@property (nonatomic,strong) NSMutableArray *gameHistory;
@end

@implementation ViewController

-(void)viewWillDisappear:(BOOL)animated{
    //store
    NSData *gameData=[NSKeyedArchiver archivedDataWithRootObject:self.game];
    NSData *gameHistoryData=[NSKeyedArchiver archivedDataWithRootObject:self.gameHistory];
    [[NSUserDefaults standardUserDefaults] setObject:gameData forKey:@"Game"];
    [[NSUserDefaults standardUserDefaults] setObject:gameHistoryData forKey:@"GameHistory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    //load history data;
    NSData *gameData=[[NSUserDefaults standardUserDefaults] objectForKey:@"Game"];
    NSData *gameHistoryData=[[NSUserDefaults standardUserDefaults] objectForKey:@"GameHistory"];
    if (gameData) {
        self.game = [NSKeyedUnarchiver unarchiveObjectWithData:gameData];
        self.gameHistory = [NSKeyedUnarchiver unarchiveObjectWithData:gameHistoryData];
        [self updateUI];
        
    }
    
}

-(CardMatchingGame *)game{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

-(NSMutableArray *)playerHistory{
    if (!_gameHistory) {
        _gameHistory = [[NSMutableArray alloc] init];
    }
    return _gameHistory;
}

-(Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}
- (IBAction)switchGameMode:(UISegmentedControl *)sender {
    self.game.gameMode=(int)sender.selectedSegmentIndex;
    
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.switchSegment.enabled=NO;
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}
- (IBAction)changePlayHistroy:(UISlider *)sender {
    if (sender.value<self.game.playHistory.count) {
        self.lastStateLabel.text=[self.game.playHistory objectAtIndex:round(sender.value)];
        self.lastStateLabel.alpha=0.5;
        sender.alpha=0.5;
    }

    
}

- (IBAction)deal:(id)sender {
    self.game.endDate = [NSDate date];
    [self.playerHistory addObject:self.game];
    
    self.game=nil;
    self.game.gameMode=(int)self.switchSegment.selectedSegmentIndex;
    self.switchSegment.enabled=YES;
    [self updateUI];
    
}


-(void)updateUI{
    for (PlayingCardView *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        PlayingCard *card = (PlayingCard *)[self.game cardAtIndex:cardButtonIndex];
        if (cardButton.chosen !=card.isChosen) {
            [UIView transitionWithView:cardButton
                              duration:1
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^{
                                cardButton.rank = card.rank;
                                cardButton.suit = card.suit;
                                
                                cardButton.chosen = card.isChosen;
                            } completion:nil];
        }
        
        cardButton.matched = card.isMatched;
        
        
    }
    self.playHistroySlider.alpha=1;
    self.lastStateLabel.alpha=1;
    self.playHistroySlider.maximumValue=self.game.playHistory.count-1;
    self.playHistroySlider.value=self.playHistroySlider.maximumValue;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",(long)self.game.score];
    self.lastStateLabel.text=[self.game.playHistory lastObject];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"history"]) {
        id destvc=segue.destinationViewController;
        if ([destvc isKindOfClass:[GameHistoryTableViewController class]]) {
            GameHistoryTableViewController *ghvc=destvc;
            ghvc.gameHistory=self.gameHistory;
        }
    }
}




@end
