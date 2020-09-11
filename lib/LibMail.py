import os
import sys
__dirname = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(__dirname, '../'))
from codecs import decode
from robot.libraries.BuiltIn import BuiltIn


class LibMail(object):
    def __init__(self):
        self.imaplibrary = BuiltIn().get_library_instance('ImapLibrary')
        self.imap = self.imaplibrary._imap

    def delete_all_email_in_all_mail(self, email_address):
        """
        Delete all email in All Mail with assgin receiver email address.
        Arguments:
        - ``email_address``: Receiver email address.
        Examples:
        | Delete All Email In All Mail | EMAIL_ADDRESS |
        """
        idx_list = self.get_all_email_index('"[Gmail]/All Mail"', email_address)
        for index in reversed(idx_list):
            self.delete_specific_email(index)

    def delete_all_email_in_trash(self, email_address):
        """
        Delete all email in Trash with assgin receiver email address.
        Arguments:
        - ``email_address``: Receiver email address.
        Examples:
        | Delete All Email In Trash | EMAIL_ADDRESS |
        """
        idx_list = self.get_all_email_index('[Gmail]/Trash', email_address)
        for index in reversed(idx_list):
            self.delete_specific_email(index)

    def delete_specific_email(self, index):
        """
        Move the mail to trash, label flags as deleted and
        permantly delete it.
        Arguments:
        - ``index``: Email index.
        Examples:
        | Delete Specific Email | INDEX |
        """
        self.imap.store(index, '+X-GM-LABELS', '\\Trash')
        self.imap.store(index, '+FLAGS', '\\Deleted')
        self.imap.expunge()

    def get_all_email_index(self, label_type, email_address):
        """
        Get email index list from assign receive email address
        and label type.
        Arguments:
        - ``label_type``: Name of email label for searching.
        - ``email_address``: Receiver email address.
        Examples:
        | Get All Email Index | LABEL_TYPE | EMAIL_ADDRESS |
        """
        self.imap.select(label_type)
        search_result = self.imap.search(None, 'HEADER TO "{}"'.format(email_address))
        idx_list = search_result[1][0].decode("utf-8").split()
        return idx_list

    def get_email_body_with_utf8(self, email_index):
        """
        Returns the decoded email body on multipart email message,
        otherwise returns the body text.
        Arguments:
        - ``email_index``: An email index to identity the email message.
        Examples:
        | Get Email Body With Utf8 | INDEX |
        """
        if self.imaplibrary._is_walking_multipart(email_index):
            body = self.imaplibrary.get_multipart_payload(decode=True)
        else:
            encoded_body = self.imaplibrary._imap.uid('fetch', email_index, '(BODY[TEXT])')[1][0][1]
            body = decode(encoded_body, 'quopri_codec').decode('utf-8')
        return body