//
//  IssueViewController.m
//  filmJournal
//
//  Created by Tanxin Du on 2/13/14.
//  Copyright (c) 2014 Tanxin Du. All rights reserved.
//

#import "IssueViewController.h"
#import "ArticleListViewController.h"
#import "MESArticle.h"
#import "MESJournal.h"
#import "MESVolume.h"
#import "MESIssue.h"
#import "AFNetworking.h"

#define dataURL @"http://agiledev.bgsu.edu/~tdu/issue.php"

@interface IssueViewController ()

@end

@implementation IssueViewController

@synthesize json, issueArray, myTableView, selectedJournalID, selectedVolume, selectedIssue;

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return issueArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"issueCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(cell==Nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    MESIssue * currentIssue = [issueArray  objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentIssue.Issue ;
    //    cell.detailTextLabel.text = currentVolume.Journal_Issue ;
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    }
    return cell;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showArticle"]) {
        
        ArticleListViewController *destViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.selectedIssue = [[NSString alloc] init];
        MESIssue *tempissue = [issueArray objectAtIndex:indexPath.row];
        
        
        destViewController.selectedJournalID = selectedJournalID;
        destViewController.selectedVolume = selectedVolume;
        destViewController.selectedIssue = tempissue.Issue;
    }
}

# pragma mark - UITableView Delegate methods

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Methods

- (void) retrieveData{
    
    //    NSURL * url= [NSURL URLWithString:dataURL];
    //    NSData * data= [NSData dataWithContentsOfURL:url];
    //    json =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:Nil];
    
    //Populating Article array
    issueArray = [[NSMutableArray alloc]init];
    
    NSDictionary *param = @{
                            @"jid": selectedJournalID,
                            @"jvolume": selectedVolume,
                            };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:dataURL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        json = responseObject;
        
        
        for (int i = 0; i < [responseObject count]; i++) {
            
            // Create a volume object
            
            NSString  * jissue = [[json objectAtIndex:i]objectForKey:@"jissue"];
            
            MESIssue *myIssue = [[MESIssue alloc] initWithIssue: jissue];
            
            //Add our Issue object to Issuw array
            [issueArray addObject: myIssue];
            
        }
        
        [self.myTableView reloadData];
        
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
    
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
