// Copyright (c) 2000-2016 Synology Inc. All rights reserved.
// Testing tool template longOpt
#include <stdio.h>
#include <getopt.h>

typedef enum _tag_LUNUPDATE_ACTION {
	TOOL_ACTION_1,
	TOOL_ACTION_2,
	TOOL_ACTION_3,
	TOOL_ACTION_4,
	TOOL_ACTION_5,
	TOOL_ACTION_6,
	TOOL_ACTION_7,
	TOOL_ACTION_8,
	TOOL_ACTION_9,
	TOOL_ACTION_10,
	TOOL_ACTION_11,
	TOOL_ACTION_NONE,
} TOOL_ACTION;

static struct option longOpts[] = {
	{ "a"   , no_argument, NULL, TOOL_ACTION_1 }, 
	{ "b"   , no_argument, NULL, TOOL_ACTION_2 }, 
	{ "c"   , no_argument, NULL, TOOL_ACTION_3 }, 
	{ "d"   , no_argument, NULL, TOOL_ACTION_4 }, 
	{ "e"   , no_argument, NULL, TOOL_ACTION_5 }, 
	{ "f"   , no_argument, NULL, TOOL_ACTION_6 }, 
	{ "g"   , no_argument, NULL, TOOL_ACTION_7 }, 
	{ "h"   , no_argument, NULL, TOOL_ACTION_8 }, 
	{ "i"   , no_argument, NULL, TOOL_ACTION_9 }, 
	{ "j"   , no_argument, NULL, TOOL_ACTION_10 },
	{ NULL, 0, NULL, 0}
};

/***********************
 * @param argc
 * @param argv
 *
 * @return -1: error
 *         0: success
 ************************/
int main(int argc, char *argv[])
{
	int ret = -1;
	TOOL_ACTION action = TOOL_ACTION_NONE;

	while (0 <= (ret = getopt_long_only(argc, argv, "", longOpts, NULL))) {
        if(0 > ret) {
			goto END;
		}
		action = ret;		
	}

	switch (action) {
	case TOOL_ACTION_1:
		printf("Action 1 is called\n");
		break;
	case TOOL_ACTION_2:
		printf("Action 2 is called\n");
		break;
	default:
		printf("Invalid option. Use --help to see the usage.\n");
		return -1;
	}

	err = 0;
END:
	return err;
}

