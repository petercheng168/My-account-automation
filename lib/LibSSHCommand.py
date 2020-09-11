# -*- coding: utf-8 -*-
from paramiko import client


class LibSSHCommand:

    def __init__(self, address, username, password):
        self.client = client.SSHClient()
        self.client.set_missing_host_key_policy(client.AutoAddPolicy())
        self.client.connect(address, username=username, password=password, look_for_keys=False)

    def exec_command(self, command):
        result = None
        if self.client:
            stdin, stdout, stderr = self.client.exec_command(command)
            while not stdout.channel.exit_status_ready():
                if stdout.channel.recv_ready():
                    all_data = stdout.channel.recv(1024)
                    prev_data = b'1'
                    while prev_data:
                        prev_data = stdout.channel.recv(1024)
                        all_data += prev_data

                    result = str(all_data, 'utf8')
        else:
            raise Exception('Connection not open')

        return result

    def close_connect(self):
        self.client.close()
