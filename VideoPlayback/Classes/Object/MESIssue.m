//
//  MESIssue.m
//  MiseEnScene
//
//  Created by Tanxin Du on 2/10/14.
//  Copyright (c) 2014 ichi. All rights reserved.
//

#import "MESIssue.h"

@implementation MESIssue
@synthesize Issue;

-(id) initWithIssue: (NSString *) jissue;
{
    self = [super init];
    if(self){
        
        Issue = jissue;
        
    }
    return self;
}

@end
