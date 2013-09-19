"""
Here is an example of creating a thread local stderr stream and allowing users to set it.
"""

import sys
import threading
from contextlib import contextmanager


class NewSys(object):

    oldsys = sys
    thread_variables = threading.local()

    def __getattr__(self, name):
        if hasattr(self.thread_variables, name):
            return self.thread_variables.stderr
        elif name in self.__dict__:
            return self.__dict__[name]
        return getattr(self.oldsys, name)
    
    def __dir__(self):
        old_dir = dir(self.oldsys)
        old_dir.extend(self.__dict__)
        return old_dir

    def set_stderr(self, stderr):
        self.thread_variables.stderr = stderr

sys.modules['sys'] = NewSys()
sys = sys.modules['sys']


@contextmanager
def override_stderr(stderr_handle):
    stderr = sys.stderr
    sys.set_stderr(stderr_handle)
    yield
    sys.set_stderr(stderr)
