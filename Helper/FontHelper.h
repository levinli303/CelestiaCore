//
// FontHelper.h
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN

@interface FallbackFont : NSObject

@property (readonly) NSString *filePath;
@property (readonly) NSInteger collectionIndex;

- (instancetype)initWithFilePath:(NSString *)filePath collectionIndex:(NSInteger)collectionIndex;

@end

FallbackFont * _Nullable GetFontForLocale(NSString *locale, CTFontUIFontType fontType);

NS_ASSUME_NONNULL_END
