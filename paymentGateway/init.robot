*** Variable ***
${ENV}    pa

*** Settings ***
Variables         ../env.py
Variables         ../setting.py    ${ENV}
Variables         ./lib/PaymentGatewayObject.py

Library           BuiltIn
Library           Collections
Library           DateTime
Library           ImapLibrary
Library           OperatingSystem
Library           Process
Library           RequestsLibrary
Library           SSHLibrary
Library           String
Library           XML
#Library           ./api/ACH.py
#Library           ./api/ATM.py
#Library           ./api/ApplePay.py
#Library           ./api/ConvenientStore.py
#Library           ./api/CreditCard.py
Library           ./api/External.py
Library           ./api/Internal.py
Library           ./api/Scheduler.py
Library           ./lib/LibJSONSchema.py
Library           ./lib/LibLocalStorage.py
Library           ./lib/LibPaymentActions.py
Library           ../lib/LibAppCipher.py
Library           ../lib/LibCrypto.py
Library           ../lib/LibMail.py
Library           ../lib/LibZip.py

# GP API Python Library
Resource          ${GP_ROOT}/gp_library_init.robot

Library           ../goBank/api/Wallet.py

Resource          ./lib/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot
