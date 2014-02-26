//
//  ArticleListViewController.m
//  filmJournal
//
//  Created by Tanxin Du on 2/13/14.
//  Copyright (c) 2014 Tanxin Du. All rights reserved.
//

#import "ArticleListViewController.h"
#import "ArticleDetailViewController.h"
#import "MESJournal.h"
#import "MESVolume.h"
#import "MESArticle.h"
#import "AFNetworking.h"

#define dataURL @"http://agiledev.bgsu.edu/~tdu/article.php"

@interface ArticleListViewController ()

@end

@implementation ArticleListViewController

@synthesize json, articleArray, selectedJournalID, selectedVolume, selectedIssue, selectedArticle, myTableView;

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
    return articleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"articleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(cell==Nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    MESArticle *currentArticle = [articleArray objectAtIndex:indexPath.row];
    cell.textLabel.text = currentArticle.Article_Name;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        
        ArticleDetailViewController *destViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.selectedArticle = [[MESArticle alloc] init];
        
        destViewController.selectedArticle = [articleArray objectAtIndex:indexPath.row];
        
        //NSLog(selectedArticle);
    }
    
}

# pragma mark - UITableView Delegate methods

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Methods

- (void) retrieveData{
    
    //Populating Article array
    articleArray = [[NSMutableArray alloc]init];
    
    //    NSURL *url = [NSURL URLWithString:dataURL];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSDictionary *param = @{
                            @"jid": selectedJournalID,
                            @"jvolume": selectedVolume,
                            @"jissue": selectedIssue
                            };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:dataURL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        json = responseObject;
        
        
        for (int i = 0; i < [responseObject count]; i++) {
            
            NSString *aid = [[json objectAtIndex:i]objectForKey:@"aid"];
            NSString *aname = [[json objectAtIndex:i]objectForKey:@"aname"];
            NSString *aauthor = [[json objectAtIndex:i]objectForKey:@"aauthor"];
            NSString *aabstract = [[json objectAtIndex:i]objectForKey:@"aabstract"];
            NSString *jid = [[json objectAtIndex:i]objectForKey:@"jid"];
            NSString *jvolume = [[json objectAtIndex:i]objectForKey:@"jvolume"];
            NSString *jissue = [[json objectAtIndex:i]objectForKey:@"jissue"];
            NSString *afpage = [[json objectAtIndex:i]objectForKey:@"afpage"];
            NSString *aepage = [[json objectAtIndex:i]objectForKey:@"aepage"];
            NSString *hasar = [[json objectAtIndex:i]objectForKey:@"hasar"];
            
            MESArticle *myArticle = [[MESArticle alloc] initWithArticle_ID: aid andArticle_Name: aname andArticle_Author: aauthor andArticle_Abstract: aabstract andJournal_ID: jid andJournal_Volume: jvolume andJournal_Issue: jissue andArticle_fPage: afpage andArticle_ePage: aepage andhasAR: hasar];
            
            //Add our Article object to Article array
            [articleArray addObject: myArticle];
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
