//
//  Created by Jerome Morissard on 12/29/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#ifndef JMOLogMacro_h
#define JMOLogMacro_h

// Log using the same parameters above but include the function name and source code line number in the log statement
#ifdef DEBUG
#define JMOLog(fmt, ...) NSLog((@"Func: %s, Line: %d, " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define JMOLog(...)
#endif

#endif
