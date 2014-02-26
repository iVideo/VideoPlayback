//
//  MESJournal.m
//  MiseEnSceneUI
//
//  Created by Tanxin Du on 1/30/14.
//  Copyright (c) 2014 ichi. All rights reserved.
//

#import "MESJournal.h"

@implementation MESJournal

@synthesize JournalName, JournalID;

-(id) initWithJournalName: (NSString *) jname andJournalID: (NSString *) jid;
{
    self = [super init];
    if(self){
        
        JournalName = jname;
        JournalID = jid;
        
    }
    return self;
}

@end
