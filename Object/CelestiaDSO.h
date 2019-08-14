//
//  CelestiaDSO.h
//  celestia
//
//  Created by Da Woon Jung on 12/30/06.
//  Copyright 2006 Chris Laurel. All rights reserved.
//

#import <CelestiaCore/CelestiaCatEntry.h>

@class CelestiaVector;

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaDSO : CelestiaCatEntry

@property (readonly) NSString *type;

@property (readonly) NSString *webInfoURL;

@property (readonly) CelestiaVector *position;

@end

NS_ASSUME_NONNULL_END
