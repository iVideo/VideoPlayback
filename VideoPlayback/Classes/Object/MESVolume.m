//
//  MESVolume.m
//  MiseEnScene
//
//  Created by Tanxin Du on 2/3/14.
//  Copyright (c) 2014 ichi. All rights reserved.
//

#import "MESVolume.h"

@implementation MESVolume

@synthesize Volume;

-(id) initWithVolume: (NSString *) jvolume;
{
    self = [super init];
    if(self){
        
        Volume = jvolume;
        
    }
    return self;
}

@end
