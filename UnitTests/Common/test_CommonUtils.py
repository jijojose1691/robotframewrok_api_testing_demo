"""
    This module is unit test module for CommonUtils
"""
import unittest

from Libraries.Common.CommonUtils import CommonUtils


class TestCommonUtils(unittest.TestCase):
    """
        This class contains tests for module CommonUtils
    """

    def test_token_length(self):
        """
            Test if the generated token has the correct length
        """
        token_length = 10
        token = CommonUtils().generate_auth_token(token_length)
        self.assertNotEqual(token, "")
        self.assertEqual(len(token), token_length)


if __name__ == '__main__':
    unittest.main()


