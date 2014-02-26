//
//  JournalViewController.m
//  filmJournal
//
//  Created by Tanxin Du on 2/13/14.
//  Copyright (c) 2014 Tanxin Du. All rights reserved.
//

#import "JournalViewController.h"
#import "VolumeViewController.h"
#import "MESArticle.h"
#import "MESJournal.h"

@interface JournalViewController ()

@end

#define dataURL @"http://agiledev.bgsu.edu/~tdu/journal.php"

@implementation JournalViewController

@synthesize json, articleArray, myTableView, selectedJournalID, journalArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self retrieveData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//Method thats called before segueing to next view, passing relevant data
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showVolume"]) {
        
        VolumeViewController *destViewController = segue.destinationViewController;
        //putting existing Journals in an array---------------------------
        
        //        allVolumes = [[NSMutableArray alloc] init];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.selectedJournalID= [[NSString alloc] init];
        
        MESJournal *tempjournal = [journalArray objectAtIndex:indexPath.row];
        
        destViewController.selectedJournalID = tempjournal.JournalID;
        
        //Passing the array of articles--------------------------------------------
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return journalArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"journalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(cell==Nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier];
    }
    
    MESJournal * currentJournal = [journalArray objectAtIndex:indexPath.row];
    cell.textLabel.text = currentJournal.JournalName;
    
    return cell;
}

# pragma mark - UITableView Delegate methods

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - Methods

- (void) retrieveData{
    
    NSURL * url= [NSURL URLWithString:dataURL];
    NSData * data= [NSData dataWithContentsOfURL:url];
    
    json =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:Nil];
    
    //Populating journal array
    journalArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i<json.count; i++) {
        
        // Create a article object
        
        NSString  * jname = [[json objectAtIndex:i]objectForKey:@"jname"];
        NSString  * jid = [[json objectAtIndex:i]objectForKey:@"jid"];
        MESJournal *myJournal = [[MESJournal alloc] initWithJournalName: jname andJournalID: jid];
        
        //Add our Article object to Article array
        [journalArray addObject:myJournal];
        
    }
    
    [self.myTableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
