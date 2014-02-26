//
//  MESArticle.h
//  MiseEnSceneUI
//
//  Created by Tanxin Du on 1/30/14.
//  Copyright (c) 2014 tdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MESArticle : NSObject

@property (nonatomic,strong)NSString* Article_ID; //name
@property (nonatomic,strong)NSString* Article_Name; //name
@property (nonatomic,strong)NSString* Article_Author; //author
@property (nonatomic,strong)NSString* Article_Abstract;
@property (nonatomic,strong)NSString* Article_fPage; //page from
@property (nonatomic,strong)NSString* Article_ePage; //page to

@property (nonatomic,strong)NSString* Journal_ID;
@property (nonatomic,strong)NSString* Journal_Volume; //volume
@property (nonatomic,strong)NSString* Journal_Issue;

@property (nonatomic,strong)NSString* hasAR;


//Methods

-(id) initWithArticle_ID: (NSString *) aid andArticle_Name: (NSString *) aname andArticle_Author: (NSString *) aauthor andArticle_Abstract: (NSString *) aabstract andJournal_ID: (NSString *) jid andJournal_Volume: (NSString *) jvolume andJournal_Issue: (NSString *) jissue andArticle_fPage: (NSString *) afpage andArticle_ePage: (NSString *) aepage andhasAR: (NSString *) hasar;

@end
