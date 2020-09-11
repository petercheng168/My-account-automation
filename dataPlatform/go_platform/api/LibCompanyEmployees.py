import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../api'))
from _init_ import _init_


class LibCompanyEmployees(object):

    def __init__(self):
        self.init = _init_()

# ---------------------------------------------------------------------------
    def employees_get_by_emp_id(self, emp_id, account=None):
        """ Get employees information """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "emp_id": emp_id
            }
        }
        resp = self.init.request('post', "/company/employees", json=data)
        return resp

    def employees_get(self,
                        department_id=None,
                        department_id_list=None,
                        emp_id=None,
                        emp_code=None,
                        emp_job_code=None,
                        first_name=None,
                        middle_name=None,
                        last_name=None,
                        legal_first_name=None,
                        legal_middle_name=None,
                        legal_last_name=None,
                        profile_id=None,
                        mobile_phone=None,
                        email=None,
                        job_title=None,
                        job_code=None,
                        gender=None,
                        status=None,
                        since_last_update=None,
                        pagination_criteria=None,
                        account=None):
        """ Get employees information """
        self.init.authHeader(account)
        data = {
            "op_code": "get",
            "get_data": {
                "department_id": department_id,
                "department_id_list": department_id_list,
                "emp_id": emp_id,
                "emp_code": emp_code,
                "emp_job_code": emp_job_code,
                "first_name": first_name,
                "middle_name": middle_name,
                "last_name": last_name,
                "legal_first_name": legal_first_name,
                "legal_middle_name": legal_middle_name,
                "legal_last_name": legal_last_name,
                "profile_id": profile_id,
                "mobile_phone": mobile_phone,
                "email": email,
                "job_title": job_title,
                "job_code": job_code,
                "gender": gender,
                "status": status,
                "since_last_update": since_last_update,
                "pagination_criteria": pagination_criteria
            }
        }
        resp = self.init.request('post', "/company/employees", json=data)
        return resp

    def employees_add(self,
                        department_id=None,
                        emp_code=None,
                        first_name=None,
                        middle_name=None,
                        last_name=None,
                        legal_first_name=None,
                        legal_middle_name=None,
                        legal_last_name=None,
                        profile_id=None,
                        mobile_phone=None,
                        email=None,
                        password=None,
                        contact_address=None,
                        contact_zip=None,
                        job_title=None,
                        job_duty=None,
                        job_code=None,
                        gender=None,
                        emp_date=None,
                        terminate_date=None,
                        password_force_update=None,
                        account=None):
        """ Add employees information """
        self.init.authHeader(account)
        data = {
            "op_code": "add",
            "add_data": [
                {
                    "department_id": department_id,
                    "emp_code": emp_code,
                    "first_name": first_name,
                    "middle_name": middle_name,
                    "last_name": last_name,
                    "legal_first_name": legal_first_name,
                    "legal_middle_name": legal_middle_name,
                    "legal_last_name": legal_last_name,
                    "profile_id": profile_id,
                    "mobile_phone": mobile_phone,
                    "email": email,
                    "password": password,
                    "contact_address": contact_address,
                    "contact_zip": contact_zip,
                    "job_title": job_title,
                    "job_duty": job_duty,
                    "job_code": job_code,
                    "gender": gender,
                    "emp_date": emp_date,
                    "terminate_date": terminate_date,
                    "password_force_update": password_force_update
                }
            ]
        }
        resp = self.init.request('post', "/company/employees", json=data)
        return resp

    def employees_update(self,
                            emp_id=None,
                            new_company_id=None,
                            department_id=None,
                            first_name=None,
                            middle_name=None,
                            last_name=None,
                            legal_first_name=None,
                            legal_middle_name=None,
                            legal_last_name=None,
                            profile_id=None,
                            mobile_phone=None,
                            email=None,
                            password=None,
                            contact_address=None,
                            contact_zip=None,
                            job_title=None,
                            job_duty=None,
                            job_code=None,
                            gender=None,
                            emp_date=None,
                            terminate_date=None,
                            security_key=None,
                            status=None,
                            password_force_update=None,
                            account=None):
        """ Update employees information """
        self.init.authHeader(account)
        data = {
            "op_code": "update",
            "update_data": [
                {
                    "emp_id": emp_id,
                    "new_company_id": new_company_id,
                    "department_id": department_id,
                    "first_name": first_name,
                    "middle_name": middle_name,
                    "last_name": last_name,
                    "legal_first_name": legal_first_name,
                    "legal_middle_name": legal_middle_name,
                    "legal_last_name": legal_last_name,
                    "profile_id": profile_id,
                    "mobile_phone": mobile_phone,
                    "email": email,
                    "password": password,
                    "contact_address": contact_address,
                    "contact_zip": contact_zip,
                    "job_title": job_title,
                    "job_duty": job_duty,
                    "job_code": job_code,
                    "gender": gender,
                    "emp_date": emp_date,
                    "terminate_date": terminate_date,
                    "security_key": security_key,
                    "status": status,
                    "password_force_update": password_force_update
                }
            ]
        }
        resp = self.init.request('post', "/company/employees", json=data)
        return resp
