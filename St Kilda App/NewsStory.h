//
//  NewsStory.h
//  St Kilda App
//
//  Created by Okeito on 4/2/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsStory : NSObject

@property (nonatomic, strong) NSString * image; // accompanying imge
@property (nonatomic, strong) NSString * headline; //title of articl/story
@property (nonatomic, strong) NSString * story; //actual body copy of article/story

@end
