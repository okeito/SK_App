//
//  RSSFeed.h
//  St Kilda App
//
//  Created by Okeito on 4/13/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSFeed : NSObject
@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)NSString *link;
@property(nonatomic,retain)NSString *comments;
@property(nonatomic,retain)NSString *pubDate;
@property(nonatomic,retain)NSMutableArray *categories;
@property(nonatomic,retain)NSString *descriptionText;
@property(nonatomic,retain)NSString *rssFeedImage;
@end
