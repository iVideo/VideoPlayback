//
//  VolumeViewController.h
//  filmJournal
//
//  Created by Tanxin Du on 2/13/14.
//  Copyright (c) 2014 Tanxin Du. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MESArticle.h"
#import "MESJournal.h"
#import "MESVolume.h"

@interface VolumeViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray * json;
@property (nonatomic,strong) NSMutableArray * volumeArray;
@property (nonatomic,strong) NSString *selectedJournalID;
@property (nonatomic,strong) NSString *selectedVolume;
@property(strong,nonatomic) IBOutlet UITableView *myTableView;

#pragma mark - Methods

- (void) retrieveData;
/*Changes made till here to include Data from MySql Server*/
@end
