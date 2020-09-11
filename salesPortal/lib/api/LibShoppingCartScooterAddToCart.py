#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import os
import re
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../../../'))
from salesPortal.lib.api.LibBase import LibBase
from salesPortal.lib.ProductList import *


class LibShoppingCartScooterAddToCart(object):

    def __init__(self):
        self.init = LibBase()

# ---------------------------------------------------------------------------
    def _get_product_information_payload(self, product_name):
        """ Get scooter detail information payload
        Args:
            product_name (str): default product_list

        Returns:
            dict: The return value
        """
        products = {
            "Gogoro VIVA":
            [
                shopping_cart_gogoroviva
            ],
            "Gogoro S2 Café Racer":
            [
                shopping_cart_gogoros2caferacer
            ],
            "Gogoro S2 Café Racer+Anti slip mat":
            [
                shopping_cart_gogoros2caferacer,
                shopping_cart_anti_slip_mat
            ],
            "Gogoro S2 Café Racer+Light sensor":
            [
                shopping_cart_gogoros2caferacer,
                shopping_cart_light_sensor
            ],
            "Gogoro 2 Delight":
            [
                shopping_cart_gogoro2delight
            ],
            "Gogoro 2 Delight+Anti slip mat":
            [
                shopping_cart_gogoro2delight,
                shopping_cart_anti_slip_mat
            ],
            "Gogoro 2 Delight+Light sensor":
            [
                shopping_cart_gogoro2delight,
                shopping_cart_light_sensor
            ],
            "Gogoro 2 Rumbler":
            [
                shopping_cart_gogoro2rumbler
            ],
            "Gogoro 2 Rumbler+Anti slip mat":
            [
                shopping_cart_gogoro2rumbler,
                shopping_cart_anti_slip_mat
            ],
            "Gogoro 2 Rumbler+Light sensor":
            [
                shopping_cart_gogoro2rumbler,
                shopping_cart_light_sensor
            ]
        }
        return products[product_name]

    def shopping_cart_scooter_add_to_cart_post(self, product_name='Gogoro S2 Café Racer', t_shirt=None, badge=None,
                                                badge_type='A', student_plan='N', payment_method=1, token=None):
        """ Add scooter into shopping cart
        Args:
            product_no (str): scooter type code
            product_main_id (str): scooter model id
            product_color_id (str): scooter color id
            order_type (int): 1 is scooter (default)
            payment_method (int): 1 is cash, 2 is loan

        Returns:
            resp: Return json object
            hash_id: Return cart information in cookies

        Examples:
            | Shopping Cart Scooter Add To Cart Post | PAYLOAD |
        """
        self.init.auth(token)
        product = self._get_product_information_payload(product_name)

        data = {
            "Product": product,
            "TShirt": t_shirt,
            "Badge": badge,
            "BadgeType": badge_type,
            "StudentPlan": student_plan,
            "PaymentMethod": payment_method
        }
        data = self.init.dict_to_json_string(data)
        data = {
            "jsonData": data
        }
        print(data)
        resp = self.init.request('post', '/shopping-cart/scooter-add-to-cart', json=data)

        print(resp.headers['Set-Cookie'])
        hash_id = re.findall("HashId=[\w\S]+", resp.headers['Set-Cookie'])[0]

        return resp, hash_id
