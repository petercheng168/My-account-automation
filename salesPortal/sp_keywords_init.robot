*** Settings ***
Variables         ../env.py
Variables         ${SP_LIB_ROOT}/SalesPortalObject.py
Variables         ${SP_LIB_ROOT}/ProductList.py

Library           ${SP_LIB_ROOT}/LibJSONSchema.py
# API Librarys
Library           ${SP_API_ROOT}/LibAccountLogin.py
Library           ${SP_API_ROOT}/LibAttachUpdateScooterPairingFlag.py
Library           ${SP_API_ROOT}/LibDiscountGetDiscountList.py
Library           ${SP_API_ROOT}/LibDiscountImportDiscountCoupons.py
Library           ${SP_API_ROOT}/LibGetOrderData.py
Library           ${SP_API_ROOT}/LibOrderFormGetCheckoutData.py
Library           ${SP_API_ROOT}/LibScooterAutoPairing.py
Library           ${SP_API_ROOT}/LibScooterList.py
Library           ${SP_API_ROOT}/LibShoppingCartCheckout.py
Library           ${SP_API_ROOT}/LibShoppingCartModifyOrder.py
Library           ${SP_API_ROOT}/LibShoppingCartScooterAddToCart.py
Library           ${SP_API_ROOT}/LibToken.py
Library           ${SP_API_ROOT}/LibUtilityGetDpUserData.py
Library           ${SP_API_ROOT}/LibUtilityTestOrderInfo.py
Library           ${SP_API_ROOT}/LibUtilityTestOrderOpeningInvoice.py
Library           ${SP_API_ROOT}/LibUtilityTestOrderUpdateInvoiceOpened.py

# API Keywords
Resource          ${SP_API_ROOT}/keywords_common.robot
Resource          ${SP_API_ROOT}/keywords_scooter.robot
Resource          ${SP_API_ROOT}/keywords_scooter_auto_pairing.robot
Resource          ${SP_API_ROOT}/keywords_shopping_cart.robot
Resource          ${SP_API_ROOT}/keywords_utility.robot
# WEB Keywords
Resource          ${SP_WEB_ROOT}/keywords_accessory_order.robot
Resource          ${SP_WEB_ROOT}/keywords_cancel_order.robot
Resource          ${SP_WEB_ROOT}/keywords_common.robot
Resource          ${SP_WEB_ROOT}/keywords_homepage.robot
Resource          ${SP_WEB_ROOT}/keywords_inventory_reserve_setting.robot
Resource          ${SP_WEB_ROOT}/keywords_invoice.robot
Resource          ${SP_WEB_ROOT}/keywords_login.robot
Resource          ${SP_WEB_ROOT}/keywords_order.robot
Resource          ${SP_WEB_ROOT}/keywords_order_modify.robot
Resource          ${SP_WEB_ROOT}/keywords_order_with_legal_entity.robot
Resource          ${SP_WEB_ROOT}/keywords_pairing_warehouse_setting.robot
Resource          ${SP_WEB_ROOT}/keywords_performance.robot
Resource          ${SP_WEB_ROOT}/keywords_priority_setting.robot
Resource          ${SP_WEB_ROOT}/keywords_scooter_auto_pairing.robot
Resource          ${SP_WEB_ROOT}/keywords_scooter_order.robot
Resource          ${SP_WEB_ROOT}/keywords_test_ride.robot
Resource          ${SP_WEB_ROOT}/keywords_test_ride_non_participate.robot
Resource          ${SP_WEB_ROOT}/keywords_transfer_order.robot
Resource          ${SP_WEB_ROOT}/keywords_transfer_scooter.robot
