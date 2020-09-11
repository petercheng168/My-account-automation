import calendar
import datetime
from dateutil.relativedelta import relativedelta


class LibCommon(object):

    def __init__(self):
        pass

# -----------------------------------------------------------------------------
    def get_next_cycle_end_date(self, cycle_end_day):
        """Return the cycle end date timestamp (23:59:59) of now.

        Arguments:
        - ``cycle_end_day:``    `cycle_end_day` of `es_contract`, only support
                                `5`, `10`, `15`, `20`, `25`, `31`

        Examples:
        | ${time_stamp} = | Get Next Cycle End Date | 15 |
        | ${time_stamp} = | Get Next Cycle End Date | 31 |
        """
        cycle_end_day = int(cycle_end_day)
        current_date = datetime.date.today()

        if cycle_end_day >= 31:
            last_day_of_month = calendar.monthrange(current_date.year,
                                                    current_date.month)[1]

            cycle_end_date = datetime.date.today().replace(day=last_day_of_month)
        else:
            cycle_end_date = datetime.date.today().replace(day=cycle_end_day)

        diff_days = (current_date - cycle_end_date).days

        if diff_days > 0:
            next_cycle_end_date = cycle_end_date + relativedelta(months=+1)

        elif diff_days < 0 or diff_days == 0:
            next_cycle_end_date = cycle_end_date

        next_cycle_end_date += relativedelta(hour=23, minute=59, second=59)

        return int(next_cycle_end_date.timestamp())
