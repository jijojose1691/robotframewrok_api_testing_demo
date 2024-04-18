"""
Utility keywords
"""
import random
import string


class CommonUtils:
    """
    Class implementing common utility keywords
    """

    @staticmethod
    def generate_auth_token(length=16):
        """
        Generate a random authentication token of the specified length.
       :param length: the required lenght of random string
        :return random string with given length
        """
        characters = string.ascii_letters + string.digits
        auth_token = ''.join(random.choice(characters) for _ in range(length))
        return auth_token


