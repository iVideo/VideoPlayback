//
//  ArticleDetailViewController.m
//  filmJournal
//
//  Created by Tanxin Du on 2/13/14.
//  Copyright (c) 2014 Tanxin Du. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import "MESArticle.h"

@interface ArticleDetailViewController ()

@end

@implementation ArticleDetailViewController

@synthesize selectedArticle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _titleTextView.text = selectedArticle.Article_Name;
    _authorTextView.text = selectedArticle.Article_Author;
    _abstractTextView.text = selectedArticle.Article_Abstract;
    
	// Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showAR"]) {
        
        ArticleDetailViewController *destViewController = segue.destinationViewController;
        destViewController.selectedArticle = selectedArticle;
        
        //NSLog(selectedArticle);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
