/*==============================================================================
 Copyright (c) 2012-2013 Qualcomm Connected Experiences, Inc.
 All Rights Reserved.
 ==============================================================================*/

#import "SampleAppAboutViewController.h"
#import "SampleAppSlidingMenuController.h"

@interface SampleAppAboutViewController ()

@end

@implementation SampleAppAboutViewController

@synthesize selectedArticle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        /*SampleAppAboutViewController *vc = [[[SampleAppAboutViewController alloc] initWithNibName:@"SampleAppAboutViewController" bundle:nil] autorelease];
        vc.appTitle = @"Video Playback";
        vc.appAboutPageName = @"VP_about";
        vc.appViewControllerClassName = @"VideoPlaybackViewController";
        
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
        nc.navigationBar.barStyle = UIBarStyleDefault;
        
        self.window.rootViewController = nc;
        */
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.appTitle;
    [self loadWebView];
    
    UIBarButtonItem *startButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(startButtonTapped:)];
    self.navigationItem.rightBarButtonItem = startButton;
    [startButton release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_uiWebView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setUiWebView:nil];
    [super viewDidUnload];
}

- (IBAction)startButtonTapped:(id)sender {
    self.appViewControllerClassName = @"VideoPlaybackViewController";
    Class vcClass = NSClassFromString(self.appViewControllerClassName);
    NSLog(@"%@", self.appViewControllerClassName);
    id vc = [[vcClass alloc]  initWithNibName:nil bundle:nil];
    
    SampleAppSlidingMenuController *slidingMenuController = [[SampleAppSlidingMenuController alloc] initWithRootViewController:vc];
    [slidingMenuController shouldIgnoreDoubleTap];
    
    [self.navigationController pushViewController:slidingMenuController animated:NO];
    [slidingMenuController release];
    [vc release]; // don't leak memory
}

//------------------------------------------------------------------------------
#pragma mark - Private

- (void)loadWebView
{
    //  Load html from a local file for the about screen
    NSString *aboutFilePath = [[NSBundle mainBundle] pathForResource:self.appAboutPageName
                                                              ofType:@"html"];
    
    NSString* htmlString = [NSString stringWithContentsOfFile:aboutFilePath
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
    
    NSString *aPath = [[NSBundle mainBundle] bundlePath];
    NSURL *anURL = [NSURL fileURLWithPath:aPath];
    [self.uiWebView loadHTMLString:htmlString baseURL:anURL];
}


//------------------------------------------------------------------------------
#pragma mark - UIWebViewDelegate

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType
{
    //  Opens the links within this UIWebView on a safari web browser
    
    BOOL retVal = NO;
    
    if ( inType == UIWebViewNavigationTypeLinkClicked )
    {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
    }
    else
    {
        retVal = YES;
    }
    
    return retVal;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // Uncomment to have the double finger tap show the build number
//    UITapGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTouches:)] autorelease];
//    gesture.numberOfTouchesRequired = 2;
//    [webView addGestureRecognizer:gesture];
}

- (void) handleTouches:(UILongPressGestureRecognizer *)gesture {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Application Version Number"
                                                    message:[NSString stringWithFormat:@"Build number is: %@", version]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

@end
