//
//  JournalViewController.h
//  filmJournal
//
//  Created by Tanxin Du on 2/13/14.
//  Copyright (c) 2014 Tanxin Du. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MESArticle.h"
#import "MESJournal.h"

@interface JournalViewController : UITableViewController

<UITableViewDataSource, UITableViewDelegate>
//@property NSMutableArray *articleArray; //I-chi

/*Changes to include Data from MySql Server*/
@property (nonatomic,strong) NSMutableArray * json;
@property (nonatomic,strong) NSMutableArray * articleArray;
@property (nonatomic,strong) NSMutableArray * journalArray;
@property (nonatomic,strong) NSString * selectedJournalID;
@property(strong,nonatomic) IBOutlet UITableView *myTableView;

#pragma mark - Methods

- (void) retrieveData;
/*Changes made till here to include Data from MySql Server*/

@end
