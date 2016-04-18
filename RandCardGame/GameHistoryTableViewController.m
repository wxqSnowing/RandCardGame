//
//  GameHistoryTableViewController.m
//  theThirdHomework
//
//  Created by WXQ on 15/12/17.
//  Copyright © 2015年 wxq. All rights reserved.
//

#import "GameHistoryTableViewController.h"
#import "CardMatchingGame.h"
#import "PlayHistoryTableViewController.h"

@interface GameHistoryTableViewController ()

@end

@implementation GameHistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gameHistory.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    id game=self.gameHistory[indexPath.row];
    if ([game isKindOfClass:[CardMatchingGame class]]) {
        CardMatchingGame * cardGame=game;
        cell.textLabel.text = [NSString stringWithFormat:@"Score: %ld (%d Card Game)",(long)cardGame.score,cardGame.gameMode+2];
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yy-MM-dd HH:mm:ss";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"From %@ to %@",[dateFormatter stringFromDate:cardGame.startDate],[dateFormatter stringFromDate:cardGame.endDate]];
    }
    // Configure the cell...
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([segue.identifier isEqualToString:@"detail"]) {
        id destvc=segue.destinationViewController;
        if ([destvc isKindOfClass:[PlayHistoryTableViewController class]]) {
            PlayHistoryTableViewController *phvc=destvc;
            
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            id game=self.gameHistory[indexPath.row];
            if ([game isKindOfClass:[CardMatchingGame class]]) {
                CardMatchingGame * cardGame=game;
                phvc.historyArray= cardGame.playHistory;
            }
            
        }
    }
    // Pass the selected object to the new view controller.
}


@end
