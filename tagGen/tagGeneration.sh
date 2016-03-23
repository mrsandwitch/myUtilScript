#!/bin/bash
#--------------------------------
# for creating cscope and ctags
#--------------------------------
export tagAndDB_dir=.tagsDB

bash ${TAGGEN_SCRIPT_DIR}/cscopeDBSetup.sh
bash ${TAGGEN_SCRIPT_DIR}/ctagsGen.sh

