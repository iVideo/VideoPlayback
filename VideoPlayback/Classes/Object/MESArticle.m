//
//  MESArticle.m
//  MiseEnSceneUI
//
//  Created by Tanxin Du on 1/30/14.
//  Copyright (c) 2014 tdu. All rights reserved.
//

#import "MESArticle.h"

@implementation MESArticle

@synthesize Article_ID, Article_Name, Article_Author, Article_Abstract, Article_fPage, Article_ePage, Journal_ID, Journal_Volume, Journal_Issue, hasAR;

-(id) initWithArticle_ID: (NSString *) aid andArticle_Name: (NSString *) aname andArticle_Author: (NSString *) aauthor andArticle_Abstract: (NSString *) aabstract andJournal_ID: (NSString *) jid andJournal_Volume: (NSString *) jvolume andJournal_Issue: (NSString *) jissue andArticle_fPage: (NSString *) afpage andArticle_ePage: (NSString *) aepage andhasAR: (NSString *) hasar;
    {
    self = [super init];
    if(self){
        
        Article_ID = aid; //id
        Article_Name = aname; //name
        Article_Author = aauthor; //author
        Article_Abstract = aabstract;
        
        Journal_ID = jid;
        Journal_Volume = jvolume; //volume
        Journal_Issue = jissue;
        
        Article_fPage = afpage; //page from
        Article_ePage = aepage; //page to
        
        hasAR = hasar;
        
    }
    return self;
}

@end
