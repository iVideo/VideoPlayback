//
//  ArticleDetailViewController.h
//  filmJournal
//
//  Created by Tanxin Du on 2/13/14.
//  Copyright (c) 2014 Tanxin Du. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MESArticle.h"

@interface ArticleDetailViewController : UIViewController

@property (nonatomic, strong) MESArticle *selectedArticle;
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
@property (weak, nonatomic) IBOutlet UITextView *authorTextView;
@property (weak, nonatomic) IBOutlet UITextView *abstractTextView;

@end
