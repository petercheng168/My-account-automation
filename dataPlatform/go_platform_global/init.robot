*** Variable ***
${ENV}    dev

*** Settings ***
Variables         ../../env.py
Variables         ${PROJECT_ROOT}/setting.py    ${ENV}
Variables         ./lib/DataPlatformGlobalObject.py

# Robot Standard Library
Resource          ../standard_library_init.robot

# Common Python Library
Library           ${PROJECT_ROOT}/lib/LibAppCipher.py
Library           ${PROJECT_ROOT}/lib/LibCrypto.py
Library           ${PROJECT_ROOT}/lib/LibMail.py

Library           ${GP_GLOBAL_LIB_ROOT}/LibCommon.py
Library           ${GP_GLOBAL_LIB_ROOT}/LibJSONSchema.py

# Common Keyword Library
Resource          ${PROJECT_ROOT}/lib/keywords_app_cipher.robot
Resource          ${PROJECT_ROOT}/lib/keywords_common.robot

# GP API Python Library
Resource          ./gp_global_library_init.robot

# GP API Keywords Library
Resource          ./gp_global_keywords_init.robot

