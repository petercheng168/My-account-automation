*** Variable ***
${ENV}    dev

*** Settings ***
Variables         ../../env.py
Variables         ${PROJECT_ROOT}/setting.py    ${ENV}
Variables         ${GP_LIB_ROOT}/DataPlatformObject.py

# Robot Standard Library
Resource          ${DP_ROOT}/standard_library_init.robot

# Common Python Library
Library           ${PROJECT_ROOT}/lib/LibAppCipher.py
Library           ${PROJECT_ROOT}/lib/LibCrypto.py
Library           ${PROJECT_ROOT}/lib/LibMail.py

Library           ${GP_LIB_ROOT}/LibCommon.py
Library           ${GP_LIB_ROOT}/LibJSONSchema.py
Library           ${GP_LIB_ROOT}/RobotListener.py

# Common Keyword Library
Resource          ${PROJECT_ROOT}/lib/keywords_app_cipher.robot
Resource          ${PROJECT_ROOT}/lib/keywords_common.robot

# Variable Mapping Library
Resource          ${GP_VARIABLES_ROOT}/variables_billing.robot
Resource          ${GP_VARIABLES_ROOT}/variables_data.robot
Resource          ${GP_VARIABLES_ROOT}/variables_error.robot

# GP API Python Library
Resource          ./gp_library_init.robot

# GP API Keywords Library
Resource          ./gp_keywords_init.robot




# Variables         ../../env.py
# Variables         ${PROJECT_ROOT}/setting.py    ${ENV}
# Variables         ${GP_LIB_ROOT}/DataPlatformObject.py

# # Robot Standard Library
# Resource          ${DP_ROOT}/standard_library_init.robot

# # Common Python Library
# Library           ${PROJECT_ROOT}/lib/LibAppCipher.py
# Library           ${PROJECT_ROOT}/lib/LibCrypto.py
# Library           ${PROJECT_ROOT}/lib/LibMail.py

# Library           ${GP_LIB_ROOT}/LibCommon.py
# Library           ${GP_LIB_ROOT}/LibJSONSchema.py

# # Common Keyword Library
# Resource          ${PROJECT_ROOT}/lib/keywords_app_cipher.robot
# Resource          ${PROJECT_ROOT}/lib/keywords_common.robot

# # GP API Python Library
# Resource          ./gp_library_init.robot

# # GP API Keywords Library
# Resource          ./gp_keywords_init.robot
