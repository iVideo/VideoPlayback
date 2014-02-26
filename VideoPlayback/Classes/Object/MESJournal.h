//
//  MESJournal.h
//  MiseEnSceneUI
//
//  Created by Tanxin Du on 1/30/14.
//  Copyright (c) 2014 ichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MESJournal : NSObject

@property (nonatomic,strong)NSString* JournalName; //name
@property (nonatomic,strong)NSString* JournalID; //jid

-(id) initWithJournalName: (NSString *) jname andJournalID: (NSString *) jid;


@end
